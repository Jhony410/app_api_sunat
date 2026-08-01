import 'package:drift/drift.dart';

import '../../../core/constantes/catalogos_sunat.dart';
import '../../../core/database/app_database.dart';
import '../../clientes/domain/entidades/cliente.dart';
import '../domain/entidades/comprobante.dart';
import '../domain/entidades/item_comprobante.dart';
import '../domain/entidades/resumen_comprobante.dart';

/// Persistencia de comprobantes y de sus correlativos.
class ComprobanteRepositorio {
  ComprobanteRepositorio(this._db);

  final AppDatabase _db;

  /// Guarda un comprobante nuevo reservando su correlativo dentro de la misma
  /// transacción.
  ///
  /// Que la reserva y la inserción compartan transacción es lo que garantiza
  /// que dos emisiones simultáneas no puedan tomar el mismo número: si la
  /// segunda falla, el correlativo se devuelve con el rollback.
  Future<Comprobante> crear(Comprobante comprobante) async {
    return _db.transaction(() async {
      final correlativo = await _reservarCorrelativo(comprobante.serie, comprobante.tipo);
      final aGuardar = comprobante.copyWith(correlativo: correlativo);
      final totales = aGuardar.totales;

      final id = await _db.into(_db.comprobantesTabla).insert(
            ComprobantesTablaCompanion.insert(
              tipo: aGuardar.tipo,
              serie: aGuardar.serie,
              correlativo: correlativo,
              fechaEmision: aGuardar.fechaEmision,
              fechaVencimiento: Value(aGuardar.fechaVencimiento),
              moneda: aGuardar.moneda,
              formaPago: aGuardar.formaPago,
              clienteId: Value(aGuardar.clienteId),
              clienteTipoDocumento: aGuardar.cliente.tipoDocumento,
              clienteNumeroDocumento: aGuardar.cliente.numeroDocumento,
              clienteRazonSocial: aGuardar.cliente.razonSocialONombres,
              clienteDireccion: Value(aGuardar.cliente.direccion),
              clienteTelefono: Value(aGuardar.cliente.telefono),
              clienteEmail: Value(aGuardar.cliente.email),
              observaciones: Value(aGuardar.observaciones),
              estadoSunat: aGuardar.estadoSunat,
              mensajeSunat: Value(aGuardar.mensajeSunat),
              xmlGenerado: Value(aGuardar.xmlGenerado),
              cdrRecibido: Value(aGuardar.cdrRecibido),
              hashCodigo: Value(aGuardar.hashCodigo),
              ticket: Value(aGuardar.ticket),
              motivoNota: Value(aGuardar.motivoNota),
              documentoAfectado: Value(aGuardar.documentoAfectado),
              tipoDocumentoAfectado: Value(aGuardar.tipoDocumentoAfectado),
              importeTotal: Value(totales.importeTotal),
            ),
          );

      await _guardarItems(id, aGuardar.items);
      return aGuardar.copyWith(id: id);
    });
  }

  /// Reserva y devuelve el siguiente correlativo de la serie.
  Future<int> _reservarCorrelativo(String serie, TipoComprobante tipo) async {
    final serieLimpia = serie.trim().toUpperCase();
    final consulta = _db.select(_db.correlativosTabla)
      ..where((c) => c.serie.equals(serieLimpia));
    final fila = await consulta.getSingleOrNull();
    final siguiente = (fila?.ultimoCorrelativo ?? 0) + 1;

    await _db.into(_db.correlativosTabla).insertOnConflictUpdate(
          CorrelativosTablaCompanion.insert(
            serie: serieLimpia,
            tipo: tipo,
            ultimoCorrelativo: Value(siguiente),
          ),
        );

    return siguiente;
  }

  /// Número que tomaría el próximo comprobante de la serie, sin reservarlo.
  ///
  /// Es sólo para mostrarlo en el formulario; el número definitivo se asigna
  /// al guardar.
  Future<int> proximoCorrelativo(String serie) async {
    final consulta = _db.select(_db.correlativosTabla)
      ..where((c) => c.serie.equals(serie.trim().toUpperCase()));
    final fila = await consulta.getSingleOrNull();
    return (fila?.ultimoCorrelativo ?? 0) + 1;
  }

  Future<void> _guardarItems(int comprobanteId, List<ItemComprobante> items) async {
    await (_db.delete(_db.itemsComprobanteTabla)
          ..where((i) => i.comprobanteId.equals(comprobanteId)))
        .go();

    await _db.batch((batch) {
      for (var i = 0; i < items.length; i++) {
        final item = items[i];
        batch.insert(
          _db.itemsComprobanteTabla,
          ItemsComprobanteTablaCompanion.insert(
            comprobanteId: comprobanteId,
            orden: i + 1,
            codigo: Value(item.codigo),
            descripcion: item.descripcion,
            unidadMedida: item.unidadMedida,
            cantidad: item.cantidad,
            valorUnitario: item.valorUnitario,
            tipoAfectacionIgv: item.tipoAfectacionIgv,
            descuento: Value(item.descuento),
          ),
        );
      }
    });
  }

  /// Comprobante completo con sus ítems, o `null` si no existe.
  Future<Comprobante?> obtenerPorId(int id) async {
    final consultaCabecera = _db.select(_db.comprobantesTabla)
      ..where((c) => c.id.equals(id));
    final cabecera = await consultaCabecera.getSingleOrNull();
    if (cabecera == null) return null;

    final consultaItems = _db.select(_db.itemsComprobanteTabla)
      ..where((i) => i.comprobanteId.equals(id))
      ..orderBy([(i) => OrderingTerm.asc(i.orden)]);
    final items = await consultaItems.get();

    return _aEntidad(cabecera, items);
  }

  /// Igual que [obtenerPorId] pero se mantiene al día ante cualquier cambio.
  Stream<Comprobante?> observarPorId(int id) {
    final consultaCabecera = _db.select(_db.comprobantesTabla)
      ..where((c) => c.id.equals(id));

    return consultaCabecera.watchSingleOrNull().asyncMap((cabecera) async {
      if (cabecera == null) return null;
      final consultaItems = _db.select(_db.itemsComprobanteTabla)
        ..where((i) => i.comprobanteId.equals(id))
        ..orderBy([(i) => OrderingTerm.asc(i.orden)]);
      return _aEntidad(cabecera, await consultaItems.get());
    });
  }

  /// Historial filtrado, del más reciente al más antiguo.
  Stream<List<ResumenComprobante>> observarResumenes(FiltroComprobantes filtro) {
    final consulta = _db.select(_db.comprobantesTabla)
      ..orderBy([
        (c) => OrderingTerm.desc(c.fechaEmision),
        (c) => OrderingTerm.desc(c.id),
      ]);

    final tipo = filtro.tipo;
    if (tipo != null) {
      consulta.where((c) => c.tipo.equalsValue(tipo));
    }

    final estado = filtro.estado;
    if (estado != null) {
      consulta.where((c) => c.estadoSunat.equalsValue(estado));
    }

    final desde = filtro.desde;
    if (desde != null) {
      consulta.where((c) => c.fechaEmision.isBiggerOrEqualValue(_inicioDelDia(desde)));
    }

    final hasta = filtro.hasta;
    if (hasta != null) {
      consulta.where((c) => c.fechaEmision.isSmallerOrEqualValue(_finDelDia(hasta)));
    }

    final clienteId = filtro.clienteId;
    if (clienteId != null) {
      consulta.where((c) => c.clienteId.equals(clienteId));
    }

    final texto = filtro.texto.trim();
    if (texto.isNotEmpty) {
      final patron = '%${texto.toLowerCase()}%';
      consulta.where(
        (c) =>
            c.clienteRazonSocial.lower().like(patron) |
            c.clienteNumeroDocumento.like(patron) |
            c.serie.lower().like(patron) |
            // Permite buscar "F001-00000012" y también sólo "12".
            (c.serie.lower() + const Constant('-') + c.correlativo.cast<String>())
                .like(patron),
      );
    }

    return consulta.watch().map((filas) => filas.map(_aResumen).toList());
  }

  /// Actualiza el resultado del envío a SUNAT.
  Future<void> actualizarEstado(
    int id, {
    required EstadoSunat estado,
    String? mensaje,
    String? xml,
    String? cdr,
    String? hash,
    String? ticket,
  }) async {
    await (_db.update(_db.comprobantesTabla)..where((c) => c.id.equals(id))).write(
      ComprobantesTablaCompanion(
        estadoSunat: Value(estado),
        mensajeSunat: Value(mensaje),
        xmlGenerado: xml == null ? const Value.absent() : Value(xml),
        cdrRecibido: cdr == null ? const Value.absent() : Value(cdr),
        hashCodigo: hash == null ? const Value.absent() : Value(hash),
        ticket: ticket == null ? const Value.absent() : Value(ticket),
        actualizadoEn: Value(DateTime.now()),
      ),
    );
  }

  /// Deja registrado el valor resumen calculado al emitir en modo Simulación.
  Future<void> actualizarHash(int id, String hash) async {
    await (_db.update(_db.comprobantesTabla)..where((c) => c.id.equals(id)))
        .write(ComprobantesTablaCompanion(hashCodigo: Value(hash)));
  }

  /// Elimina un comprobante y sus ítems (borrado en cascada).
  Future<void> eliminar(int id) async {
    await (_db.delete(_db.comprobantesTabla)..where((c) => c.id.equals(id))).go();
  }

  /// Totales agregados para el dashboard, entre dos fechas inclusive.
  Stream<ResumenPeriodo> observarResumenPeriodo(DateTime desde, DateTime hasta) {
    final tabla = _db.comprobantesTabla;
    final sumaImporte = tabla.importeTotal.sum();
    final cantidad = tabla.id.count();

    final consulta = _db.selectOnly(tabla)
      ..addColumns([sumaImporte, cantidad])
      ..where(
        tabla.fechaEmision.isBetweenValues(_inicioDelDia(desde), _finDelDia(hasta)) &
            tabla.tipo.equalsValue(TipoComprobante.notaCredito).not(),
      );

    return consulta.watchSingle().map(
          (fila) => ResumenPeriodo(
            totalFacturado: fila.read(sumaImporte) ?? 0,
            cantidadComprobantes: fila.read(cantidad) ?? 0,
          ),
        );
  }

  /// Importe emitido por día dentro del rango, para el gráfico del dashboard.
  Stream<Map<DateTime, double>> observarImportePorDia(DateTime desde, DateTime hasta) {
    final tabla = _db.comprobantesTabla;
    final consulta = _db.select(tabla)
      ..where((c) =>
          c.fechaEmision.isBetweenValues(_inicioDelDia(desde), _finDelDia(hasta)));

    return consulta.watch().map((filas) {
      final porDia = <DateTime, double>{};
      for (final fila in filas) {
        final dia = DateTime(
          fila.fechaEmision.year,
          fila.fechaEmision.month,
          fila.fechaEmision.day,
        );
        final signo = fila.tipo == TipoComprobante.notaCredito ? -1 : 1;
        porDia[dia] = (porDia[dia] ?? 0) + fila.importeTotal * signo;
      }
      return porDia;
    });
  }

  static DateTime _inicioDelDia(DateTime fecha) =>
      DateTime(fecha.year, fecha.month, fecha.day);

  static DateTime _finDelDia(DateTime fecha) =>
      DateTime(fecha.year, fecha.month, fecha.day, 23, 59, 59, 999);

  Comprobante _aEntidad(ComprobanteRow fila, List<ItemComprobanteRow> items) =>
      Comprobante(
        id: fila.id,
        tipo: fila.tipo,
        serie: fila.serie,
        correlativo: fila.correlativo,
        fechaEmision: fila.fechaEmision,
        fechaVencimiento: fila.fechaVencimiento,
        moneda: fila.moneda,
        formaPago: fila.formaPago,
        clienteId: fila.clienteId,
        cliente: Cliente(
          id: fila.clienteId,
          tipoDocumento: fila.clienteTipoDocumento,
          numeroDocumento: fila.clienteNumeroDocumento,
          razonSocialONombres: fila.clienteRazonSocial,
          direccion: fila.clienteDireccion,
          telefono: fila.clienteTelefono,
          email: fila.clienteEmail,
        ),
        items: items
            .map(
              (i) => ItemComprobante(
                id: i.id,
                comprobanteId: i.comprobanteId,
                codigo: i.codigo,
                descripcion: i.descripcion,
                unidadMedida: i.unidadMedida,
                cantidad: i.cantidad,
                valorUnitario: i.valorUnitario,
                tipoAfectacionIgv: i.tipoAfectacionIgv,
                descuento: i.descuento,
                orden: i.orden,
              ),
            )
            .toList(),
        observaciones: fila.observaciones,
        estadoSunat: fila.estadoSunat,
        mensajeSunat: fila.mensajeSunat,
        xmlGenerado: fila.xmlGenerado,
        cdrRecibido: fila.cdrRecibido,
        hashCodigo: fila.hashCodigo,
        ticket: fila.ticket,
        motivoNota: fila.motivoNota,
        documentoAfectado: fila.documentoAfectado,
        tipoDocumentoAfectado: fila.tipoDocumentoAfectado,
        creadoEn: fila.creadoEn,
        actualizadoEn: fila.actualizadoEn,
      );

  ResumenComprobante _aResumen(ComprobanteRow fila) => ResumenComprobante(
        id: fila.id,
        tipo: fila.tipo,
        serie: fila.serie,
        correlativo: fila.correlativo,
        fechaEmision: fila.fechaEmision,
        moneda: fila.moneda,
        clienteRazonSocial: fila.clienteRazonSocial,
        clienteDocumento: fila.clienteNumeroDocumento,
        estadoSunat: fila.estadoSunat,
        importeTotal: fila.importeTotal,
      );
}

/// Cifras agregadas de un periodo, para las tarjetas del dashboard.
class ResumenPeriodo {
  const ResumenPeriodo({
    required this.totalFacturado,
    required this.cantidadComprobantes,
  });

  final double totalFacturado;
  final int cantidadComprobantes;

  static const vacio = ResumenPeriodo(totalFacturado: 0, cantidadComprobantes: 0);
}
