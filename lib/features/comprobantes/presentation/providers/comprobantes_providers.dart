import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/providers/nucleo_providers.dart';
import '../../data/comprobante_repositorio.dart';
import '../../domain/entidades/comprobante.dart';
import '../../domain/entidades/resumen_comprobante.dart';

part 'comprobantes_providers.g.dart';

@Riverpod(keepAlive: true)
ComprobanteRepositorio comprobanteRepositorio(Ref ref) =>
    ComprobanteRepositorio(ref.watch(appDatabaseProvider));

/// Filtros activos del historial.
@riverpod
class FiltroHistorial extends _$FiltroHistorial {
  @override
  FiltroComprobantes build() => const FiltroComprobantes();

  void cambiarTexto(String texto) => state = state.copyWith(texto: texto);

  void cambiarTipo(TipoComprobante? tipo) =>
      state = FiltroComprobantes(
        texto: state.texto,
        tipo: tipo,
        estado: state.estado,
        desde: state.desde,
        hasta: state.hasta,
        clienteId: state.clienteId,
      );

  void cambiarEstado(EstadoSunat? estado) => state = FiltroComprobantes(
        texto: state.texto,
        tipo: state.tipo,
        estado: estado,
        desde: state.desde,
        hasta: state.hasta,
        clienteId: state.clienteId,
      );

  void cambiarRangoFechas(DateTime? desde, DateTime? hasta) => state =
      FiltroComprobantes(
        texto: state.texto,
        tipo: state.tipo,
        estado: state.estado,
        desde: desde,
        hasta: hasta,
        clienteId: state.clienteId,
      );

  void cambiarCliente(int? clienteId) => state = FiltroComprobantes(
        texto: state.texto,
        tipo: state.tipo,
        estado: state.estado,
        desde: state.desde,
        hasta: state.hasta,
        clienteId: clienteId,
      );

  void limpiar() => state = const FiltroComprobantes();
}

/// Historial que corresponde a los filtros activos.
@riverpod
Stream<List<ResumenComprobante>> historialComprobantes(Ref ref) {
  final filtro = ref.watch(filtroHistorialProvider);
  return ref.watch(comprobanteRepositorioProvider).observarResumenes(filtro);
}

/// Un comprobante concreto con todos sus ítems.
@riverpod
Stream<Comprobante?> comprobantePorId(Ref ref, int id) =>
    ref.watch(comprobanteRepositorioProvider).observarPorId(id);

/// Próximo número que tomaría la serie indicada (sólo informativo).
@riverpod
Future<int> proximoCorrelativo(Ref ref, String serie) {
  // Se recalcula cuando se emite un comprobante nuevo.
  ref.watch(historialComprobantesProvider);
  return ref.watch(comprobanteRepositorioProvider).proximoCorrelativo(serie);
}

/// Cifras del mes en curso para el dashboard.
@riverpod
Stream<ResumenPeriodo> resumenDelMes(Ref ref) {
  final hoy = DateTime.now();
  final inicioMes = DateTime(hoy.year, hoy.month);
  final finMes = DateTime(hoy.year, hoy.month + 1, 0);
  return ref
      .watch(comprobanteRepositorioProvider)
      .observarResumenPeriodo(inicioMes, finMes);
}

/// Cifras del día de hoy para el dashboard.
@riverpod
Stream<ResumenPeriodo> resumenDelDia(Ref ref) {
  final hoy = DateTime.now();
  return ref.watch(comprobanteRepositorioProvider).observarResumenPeriodo(hoy, hoy);
}

/// Importe emitido en los últimos 14 días, para el gráfico del dashboard.
@riverpod
Stream<Map<DateTime, double>> importeUltimosDias(Ref ref, {int dias = 14}) {
  final hoy = DateTime.now();
  final desde = hoy.subtract(Duration(days: dias - 1));
  return ref.watch(comprobanteRepositorioProvider).observarImportePorDia(desde, hoy);
}
