import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../empresa/domain/entidades/empresa.dart';
import '../entidades/comprobante.dart';
import 'generador_hash.dart';

/// Resultado de intentar emitir un comprobante.
class ResultadoEmision {
  const ResultadoEmision({
    required this.estado,
    this.mensaje,
    this.xml,
    this.cdr,
    this.hash,
    this.ticket,
    this.degradadoASimulacion = false,
  });

  final EstadoSunat estado;
  final String? mensaje;

  /// XML UBL firmado, cuando lo devuelve la pasarela.
  final String? xml;

  /// Constancia de Recepción (CDR) devuelta por SUNAT.
  final String? cdr;
  final String? hash;
  final String? ticket;

  /// `true` cuando se pidió emisión real pero hubo que caer a Simulación.
  final bool degradadoASimulacion;

  bool get fueAceptado => estado == EstadoSunat.aceptado;
}

/// Contrato de la pasarela que habla con SUNAT.
///
/// Se declara aquí, en el dominio, para que el resto de la app no dependa de
/// Lycet ni de ningún proveedor concreto. La implementación real vive en la
/// capa de datos (Fase 3).
abstract interface class PasarelaSunat {
  /// Comprueba que la pasarela responde antes de intentar un envío.
  Future<bool> estaDisponible();

  /// Firma y envía el comprobante, devolviendo el CDR de SUNAT.
  Future<ResultadoEmision> enviar(Comprobante comprobante, Empresa empresa);
}

/// Orquesta la emisión de un comprobante.
///
/// Su responsabilidad principal es la **degradación elegante**: si la app está
/// en modo Simulación, si no hay pasarela configurada o si Lycet no responde,
/// el comprobante se emite igual en modo Simulación en lugar de romperse. El
/// usuario nunca pierde el documento que acaba de capturar.
class ServicioEmision {
  const ServicioEmision({this.pasarela});

  /// `null` mientras no se configure la emisión real.
  final PasarelaSunat? pasarela;

  /// Emite [comprobante].
  ///
  /// Con [intentarEnvioReal] en `false` (o sin pasarela disponible) el
  /// comprobante queda en estado `Simulado` con un valor resumen calculado en
  /// local, suficiente para imprimir el RIDE y su QR.
  Future<ResultadoEmision> emitir(
    Comprobante comprobante,
    Empresa empresa, {
    required bool intentarEnvioReal,
  }) async {
    if (!intentarEnvioReal || pasarela == null) {
      return _simular(comprobante, empresa);
    }

    try {
      if (!await pasarela!.estaDisponible()) {
        return _simular(
          comprobante,
          empresa,
          motivoDegradacion:
              'No se pudo contactar al servicio de emisión. El comprobante se guardó en modo Simulación.',
        );
      }

      return await pasarela!.enviar(comprobante, empresa);
    } catch (error) {
      // Cualquier fallo de red, de certificado o de la pasarela degrada a
      // Simulación en lugar de perder el comprobante.
      return _simular(
        comprobante,
        empresa,
        motivoDegradacion:
            'Falló el envío a SUNAT ($error). El comprobante se guardó en modo Simulación.',
      );
    }
  }

  ResultadoEmision _simular(
    Comprobante comprobante,
    Empresa empresa, {
    String? motivoDegradacion,
  }) {
    return ResultadoEmision(
      estado: EstadoSunat.simulado,
      mensaje: motivoDegradacion,
      hash: generarHashSimulado(comprobante, rucEmisor: empresa.ruc),
      degradadoASimulacion: motivoDegradacion != null,
    );
  }
}
