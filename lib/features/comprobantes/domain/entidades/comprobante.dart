import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/utils/formatos.dart';
import '../../../clientes/domain/entidades/cliente.dart';
import '../servicios/calculadora_totales.dart';
import 'item_comprobante.dart';
import 'totales.dart';

part 'comprobante.freezed.dart';

/// Comprobante de pago electrónico completo (cabecera + ítems).
///
/// El [cliente] se guarda como copia, no como referencia: un comprobante ya
/// emitido no puede cambiar porque después se edite la ficha del cliente.
@freezed
abstract class Comprobante with _$Comprobante {
  const factory Comprobante({
    int? id,
    @Default(TipoComprobante.factura) TipoComprobante tipo,
    required String serie,
    required int correlativo,
    required DateTime fechaEmision,
    DateTime? fechaVencimiento,
    @Default(Moneda.soles) Moneda moneda,
    @Default(FormaPago.contado) FormaPago formaPago,

    /// Referencia a la agenda de clientes, si el receptor estaba guardado.
    int? clienteId,

    /// Copia inmutable de los datos del receptor al momento de emitir.
    required Cliente cliente,
    @Default(<ItemComprobante>[]) List<ItemComprobante> items,
    String? observaciones,
    @Default(EstadoSunat.simulado) EstadoSunat estadoSunat,

    /// Último mensaje devuelto por SUNAT o por Lycet (código + descripción).
    String? mensajeSunat,

    /// XML UBL 2.1 firmado, tal como se envió.
    String? xmlGenerado,

    /// Constancia de Recepción devuelta por SUNAT (XML del CDR).
    String? cdrRecibido,

    /// Valor resumen del comprobante; alimenta el código QR del RIDE.
    String? hashCodigo,

    /// Ticket de un envío asíncrono (resúmenes y comunicaciones de baja).
    String? ticket,

    /// Motivo, sólo en notas de crédito y débito.
    MotivoNotaCredito? motivoNota,

    /// Comprobante que modifica la nota, en formato `F001-00000123`.
    String? documentoAfectado,
    TipoComprobante? tipoDocumentoAfectado,
    DateTime? creadoEn,
    DateTime? actualizadoEn,
  }) = _Comprobante;

  const Comprobante._();

  /// `F001-00000123`
  String get numeroCompleto => formatearNumeroComprobante(serie, correlativo);

  /// Totales recalculados a partir de los ítems. Nunca se persisten como
  /// verdad: se derivan siempre para que no puedan quedar desincronizados.
  Totales get totales => calculadoraTotales.calcular(items, moneda: moneda);

  /// `true` si el comprobante todavía puede enviarse o reenviarse a SUNAT.
  bool get admiteEnvio => !estadoSunat.esFinal;

  /// `true` si es una nota de crédito o débito.
  bool get esNota =>
      tipo == TipoComprobante.notaCredito || tipo == TipoComprobante.notaDebito;

  /// Cadena que se codifica en el QR del RIDE, con los campos y el orden que
  /// exige SUNAT (Resolución 097-2012/SUNAT y modificatorias), separados por `|`.
  String cadenaQr({required String rucEmisor}) {
    final t = totales;
    return [
      rucEmisor,
      tipo.codigo,
      serie,
      correlativo.toString(),
      importeParaSunat(t.totalIgv),
      importeParaSunat(t.importeTotal),
      formatearFechaSunat(fechaEmision),
      cliente.tipoDocumento.codigo,
      cliente.numeroDocumento,
      hashCodigo ?? '',
    ].join('|');
  }

  /// Validaciones de negocio previas a guardar o emitir.
  ///
  /// Devuelve la lista de problemas encontrados; vacía significa que el
  /// comprobante es emitible.
  List<String> validar() {
    final problemas = <String>[];

    if (items.isEmpty) {
      problemas.add('Agrega al menos un ítem al comprobante.');
    }
    if (items.any((i) => !i.esValida)) {
      problemas.add('Hay ítems con descripción vacía, cantidad o importes inválidos.');
    }
    if (serie.trim().isEmpty) {
      problemas.add('Selecciona una serie.');
    }
    if (tipo == TipoComprobante.factura && !cliente.puedeRecibirFactura) {
      problemas.add('Una factura sólo puede emitirse a un cliente con RUC.');
    }
    if (cliente.razonSocialONombres.trim().isEmpty) {
      problemas.add('El cliente debe tener razón social o nombres.');
    }
    if (esNota && (documentoAfectado == null || documentoAfectado!.trim().isEmpty)) {
      problemas.add('Indica el comprobante que modifica la nota.');
    }
    if (formaPago == FormaPago.credito && fechaVencimiento == null) {
      problemas.add('Una venta al crédito necesita fecha de vencimiento.');
    }

    return problemas;
  }
}
