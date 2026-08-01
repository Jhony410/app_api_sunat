import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:share_plus/share_plus.dart';

import '../../../empresa/domain/entidades/empresa.dart';
import '../../data/generador_ride.dart';
import '../../domain/entidades/comprobante.dart';

part 'ride_providers.g.dart';

@Riverpod(keepAlive: true)
GeneradorRide generadorRide(Ref ref) => const GeneradorRide();

/// Acciones sobre la representación impresa: previsualizar, imprimir,
/// compartir y guardar el PDF.
@riverpod
class ControladorRide extends _$ControladorRide {
  @override
  void build() {}

  GeneradorRide get _generador => ref.read(generadorRideProvider);

  Future<Uint8List> bytes(Comprobante comprobante, Empresa empresa) =>
      _generador.generar(comprobante, empresa);

  /// Abre el diálogo del sistema para imprimir o guardar como PDF.
  Future<void> imprimir(Comprobante comprobante, Empresa empresa) async {
    await Printing.layoutPdf(
      name: _generador.nombreArchivo(comprobante, empresa),
      onLayout: (_) => _generador.generar(comprobante, empresa),
    );
  }

  /// Comparte el PDF por las apps instaladas en el dispositivo.
  Future<void> compartir(Comprobante comprobante, Empresa empresa) async {
    final archivo = await _escribirEnTemporal(comprobante, empresa);

    await Share.shareXFiles(
      [XFile(archivo.path, mimeType: 'application/pdf')],
      subject: '${comprobante.tipo.tituloRide} ${comprobante.numeroCompleto}',
      text: '${comprobante.tipo.etiqueta} ${comprobante.numeroCompleto} — '
          '${comprobante.cliente.razonSocialONombres}',
    );
  }

  /// Guarda el PDF en la carpeta de documentos de la app y devuelve su ruta.
  Future<String> guardar(Comprobante comprobante, Empresa empresa) async {
    final directorio = await getApplicationDocumentsDirectory();
    final carpeta = Directory('${directorio.path}${Platform.pathSeparator}comprobantes');
    if (!carpeta.existsSync()) carpeta.createSync(recursive: true);

    final archivo = await _generador.guardarEn(carpeta, comprobante, empresa);
    return archivo.path;
  }

  /// El PDF a compartir vive en la carpeta temporal: el sistema la limpia solo
  /// y no se acumulan copias del mismo comprobante.
  Future<File> _escribirEnTemporal(Comprobante comprobante, Empresa empresa) async {
    final temporal = await getTemporaryDirectory();
    return _generador.guardarEn(temporal, comprobante, empresa);
  }
}
