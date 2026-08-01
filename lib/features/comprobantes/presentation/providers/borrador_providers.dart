import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../clientes/domain/entidades/cliente.dart';
import '../../domain/entidades/comprobante.dart';
import '../../domain/entidades/item_comprobante.dart';
import '../../domain/entidades/totales.dart';

part 'borrador_providers.g.dart';

/// Comprobante que se está capturando en la pantalla "Nuevo comprobante".
///
/// Vive sólo mientras la pantalla está abierta: es un `@riverpod` sin
/// `keepAlive`, así que al salir se descarta y la siguiente emisión empieza
/// limpia. El correlativo real no se asigna aquí, sino al guardar.
@riverpod
class BorradorComprobante extends _$BorradorComprobante {
  @override
  Comprobante build() => Comprobante(
        tipo: TipoComprobante.factura,
        serie: '',
        correlativo: 0,
        fechaEmision: DateTime.now(),
        cliente: Cliente.publicoGeneral(),
      );

  /// Reinicia el borrador para un tipo de comprobante concreto.
  void iniciar({required TipoComprobante tipo, required String serie}) {
    state = Comprobante(
      tipo: tipo,
      serie: serie,
      correlativo: 0,
      fechaEmision: DateTime.now(),
      cliente: tipo == TipoComprobante.factura
          ? const Cliente(
              tipoDocumento: TipoDocumentoIdentidad.ruc,
              numeroDocumento: '',
              razonSocialONombres: '',
            )
          : Cliente.publicoGeneral(),
    );
  }

  void cambiarTipo(TipoComprobante tipo, {String? serie}) {
    // Una factura exige receptor con RUC: si el cliente actual no lo tiene, se
    // limpia para que el formulario obligue a elegir uno válido.
    final clienteCompatible =
        tipo != TipoComprobante.factura || state.cliente.puedeRecibirFactura;

    state = state.copyWith(
      tipo: tipo,
      serie: serie ?? state.serie,
      cliente: clienteCompatible
          ? state.cliente
          : const Cliente(
              tipoDocumento: TipoDocumentoIdentidad.ruc,
              numeroDocumento: '',
              razonSocialONombres: '',
            ),
      clienteId: clienteCompatible ? state.clienteId : null,
    );
  }

  void cambiarSerie(String serie) => state = state.copyWith(serie: serie);

  void cambiarCliente(Cliente cliente) =>
      state = state.copyWith(cliente: cliente, clienteId: cliente.id);

  void cambiarFechaEmision(DateTime fecha) =>
      state = state.copyWith(fechaEmision: fecha);

  void cambiarMoneda(Moneda moneda) => state = state.copyWith(moneda: moneda);

  void cambiarFormaPago(FormaPago formaPago) {
    state = state.copyWith(
      formaPago: formaPago,
      // Al volver a contado deja de tener sentido la fecha de vencimiento.
      fechaVencimiento:
          formaPago == FormaPago.contado ? null : state.fechaVencimiento,
    );
  }

  void cambiarFechaVencimiento(DateTime? fecha) =>
      state = state.copyWith(fechaVencimiento: fecha);

  void cambiarObservaciones(String? texto) =>
      state = state.copyWith(observaciones: (texto ?? '').trim().isEmpty ? null : texto);

  void agregarItem(ItemComprobante item) {
    state = state.copyWith(
      items: [...state.items, item.copyWith(orden: state.items.length + 1)],
    );
  }

  void actualizarItem(int indice, ItemComprobante item) {
    if (indice < 0 || indice >= state.items.length) return;
    final items = [...state.items];
    items[indice] = item.copyWith(orden: indice + 1);
    state = state.copyWith(items: items);
  }

  void eliminarItem(int indice) {
    if (indice < 0 || indice >= state.items.length) return;
    final items = [...state.items]..removeAt(indice);
    // Se renumera para que el orden coincida con `cbc:ID` del XML.
    state = state.copyWith(
      items: [
        for (var i = 0; i < items.length; i++) items[i].copyWith(orden: i + 1),
      ],
    );
  }

  void limpiarItems() => state = state.copyWith(items: const []);
}

/// Totales del borrador, recalculados en vivo con cada cambio.
@riverpod
Totales totalesBorrador(Ref ref) => ref.watch(borradorComprobanteProvider).totales;
