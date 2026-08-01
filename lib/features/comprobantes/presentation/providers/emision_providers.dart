import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../configuracion/presentation/providers/ajustes_providers.dart';
import '../../../empresa/presentation/providers/empresa_providers.dart';
import '../../domain/entidades/comprobante.dart';
import '../../domain/servicios/servicio_emision.dart';
import 'borrador_providers.dart';
import 'comprobantes_providers.dart';

part 'emision_providers.g.dart';

/// Servicio de emisión con la pasarela que corresponda al modo de operación.
///
/// En Fase 1 nunca hay pasarela, así que todo se emite en modo Simulación.
/// En Fase 3 este provider devuelve la pasarela de Lycet cuando está
/// configurada.
@riverpod
ServicioEmision servicioEmision(Ref ref) => const ServicioEmision();

/// Resultado de la última emisión, para que la pantalla sepa qué informar.
class EmisionCompletada {
  const EmisionCompletada({
    required this.comprobante,
    required this.resultado,
  });

  final Comprobante comprobante;
  final ResultadoEmision resultado;
}

/// Acciones de emisión. El estado `AsyncValue` refleja el progreso para poder
/// bloquear el botón y mostrar el indicador de carga.
@riverpod
class ControladorEmision extends _$ControladorEmision {
  @override
  Future<EmisionCompletada?> build() async => null;

  /// Guarda y emite el borrador actual.
  ///
  /// Devuelve `null` si el comprobante no pasó las validaciones de negocio;
  /// en ese caso [problemas] contiene el detalle.
  Future<EmisionCompletada?> emitirBorrador({required bool intentarEnvioReal}) async {
    final empresa = ref.read(empresaProvider).value;
    if (empresa == null) {
      state = AsyncError(
        StateError('Configura los datos de la empresa antes de emitir.'),
        StackTrace.current,
      );
      return null;
    }

    final borrador = ref.read(borradorComprobanteProvider);
    state = const AsyncLoading();

    try {
      final repositorio = ref.read(comprobanteRepositorioProvider);

      // El correlativo definitivo se asigna aquí, dentro de la transacción.
      final guardado = await repositorio.crear(borrador);

      final resultado = await ref.read(servicioEmisionProvider).emitir(
            guardado,
            empresa,
            intentarEnvioReal: intentarEnvioReal,
          );

      await repositorio.actualizarEstado(
        guardado.id!,
        estado: resultado.estado,
        mensaje: resultado.mensaje,
        xml: resultado.xml,
        cdr: resultado.cdr,
        hash: resultado.hash,
        ticket: resultado.ticket,
      );

      final completada = EmisionCompletada(
        comprobante: guardado.copyWith(
          estadoSunat: resultado.estado,
          mensajeSunat: resultado.mensaje,
          hashCodigo: resultado.hash,
        ),
        resultado: resultado,
      );

      state = AsyncData(completada);
      return completada;
    } catch (error, pila) {
      state = AsyncError(error, pila);
      return null;
    }
  }

  /// Reintenta el envío de un comprobante ya guardado.
  Future<ResultadoEmision?> reintentar(Comprobante comprobante) async {
    final empresa = ref.read(empresaProvider).value;
    if (empresa == null || comprobante.id == null) return null;

    final ajustes = ref.read(ajustesProvider).value;
    state = const AsyncLoading();

    try {
      final resultado = await ref.read(servicioEmisionProvider).emitir(
            comprobante,
            empresa,
            intentarEnvioReal: ajustes?.puedeEmitirEnReal ?? false,
          );

      await ref.read(comprobanteRepositorioProvider).actualizarEstado(
            comprobante.id!,
            estado: resultado.estado,
            mensaje: resultado.mensaje,
            xml: resultado.xml,
            cdr: resultado.cdr,
            hash: resultado.hash,
            ticket: resultado.ticket,
          );

      state = AsyncData(
        EmisionCompletada(comprobante: comprobante, resultado: resultado),
      );
      return resultado;
    } catch (error, pila) {
      state = AsyncError(error, pila);
      return null;
    }
  }
}
