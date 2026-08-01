import 'dart:io';

import 'package:app_api_sunat/core/constantes/catalogos_sunat.dart';
import 'package:app_api_sunat/core/router/rutas.dart';
import 'package:app_api_sunat/features/comprobantes/data/generador_ride.dart';
import 'package:app_api_sunat/features/comprobantes/domain/entidades/comprobante.dart';
import 'package:app_api_sunat/features/comprobantes/domain/entidades/item_comprobante.dart';
import 'package:app_api_sunat/features/comprobantes/domain/servicios/generador_hash.dart';
import 'package:app_api_sunat/features/comprobantes/presentation/providers/comprobantes_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../utiles/entorno_prueba.dart';

/// Genera capturas de las pantallas y el RIDE en `capturas/`.
///
/// No es una prueba de regresión: es la forma de mirar la interfaz cuando no
/// hay dispositivo a mano. El nombre del archivo no acaba en `_test.dart`
/// justamente para que `flutter test` no lo recoja —las capturas dependen de
/// la máquina que las renderiza—; se ejecuta a mano con:
///
/// ```bash
/// flutter test --update-goldens test/capturas/generar_capturas.dart
/// ```
///
/// A diferencia del resto de pruebas, aquí sí se cargan las tipografías reales
/// del proyecto: el motor de pruebas usa por defecto una fuente de rectángulos
/// y las capturas saldrían ilegibles.
void main() {
  const carpeta = 'capturas';

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    Directory(carpeta).createSync(recursive: true);

    for (final familia in const {
      'Inter': ['Regular', 'Medium', 'SemiBold', 'Bold'],
      'Outfit': ['Regular', 'Medium', 'SemiBold', 'Bold'],
    }.entries) {
      final cargador = FontLoader(familia.key);
      for (final peso in familia.value) {
        cargador.addFont(
          rootBundle.load('assets/fonts/${familia.key}-$peso.ttf'),
        );
      }
      await cargador.load();
    }

    // Sin esto los íconos saldrían como cuadros: `uses-material-design: true`
    // mete la tipografía en el paquete de recursos, pero el motor de pruebas
    // no la registra por su cuenta.
    await (FontLoader('MaterialIcons')
          ..addFont(rootBundle.load('fonts/MaterialIcons-Regular.otf')))
        .load();
  });

  late EntornoPrueba entorno;

  setUp(() async {
    entorno = await EntornoPrueba.crear(empresa: empresaDePrueba);
  });

  tearDown(() => entorno.cerrar());

  Future<Comprobante> emitirDePrueba() async {
    final repositorio = entorno.contenedor.read(comprobanteRepositorioProvider);
    final guardado = await repositorio.crear(
      Comprobante(
        tipo: TipoComprobante.factura,
        serie: 'F001',
        correlativo: 0,
        fechaEmision: DateTime(2026, 8, 1),
        cliente: clienteConRuc,
        observaciones: 'Entrega en almacén central. Pago a 30 días.',
        items: const [
          ItemComprobante(
            codigo: 'SERV-001',
            descripcion: 'Servicio de consultoría tributaria',
            cantidad: 2,
            valorUnitario: 250,
            unidadMedida: UnidadMedida.servicio,
            orden: 1,
          ),
          ItemComprobante(
            codigo: 'LIB-014',
            descripcion: 'Manual de facturación electrónica',
            cantidad: 3,
            valorUnitario: 45,
            tipoAfectacionIgv: TipoAfectacionIgv.exonerado,
            orden: 2,
          ),
          ItemComprobante(
            descripcion: 'Bolígrafo de cortesía',
            cantidad: 5,
            valorUnitario: 2.5,
            tipoAfectacionIgv: TipoAfectacionIgv.gravadoBonificacion,
            orden: 3,
          ),
        ],
      ),
    );

    await repositorio.actualizarEstado(
      guardado.id!,
      estado: EstadoSunat.simulado,
      hash: generarHashSimulado(guardado, rucEmisor: empresaDePrueba.ruc),
    );
    return guardado;
  }

  /// Vuelca la pantalla actual a PNG con el tamaño de un móvil.
  Future<void> capturar(WidgetTester tester, String nombre) async {
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../../$carpeta/$nombre.png'),
    );
  }

  testWidgets('inicio', (tester) async {
    await emitirDePrueba();
    await entorno.montar(tester, tamano: const Size(430, 932));
    await capturar(tester, '1-inicio');
  });

  testWidgets('nuevo comprobante', (tester) async {
    await entorno.guardarCliente(clienteConRuc);
    await entorno.montar(tester, tamano: const Size(430, 1400));
    await entorno.irA(tester, Rutas.nuevoComprobante);
    await capturar(tester, '2-nuevo-comprobante-vacio');
  });

  testWidgets('detalle del comprobante', (tester) async {
    final comprobante = await emitirDePrueba();
    await entorno.montar(tester, tamano: const Size(430, 1600));
    await entorno.irA(tester, Rutas.detalleDe(comprobante.id!));
    await capturar(tester, '3-detalle-comprobante');
  });

  testWidgets('historial', (tester) async {
    await emitirDePrueba();
    await entorno.montar(tester, tamano: const Size(430, 932));
    await entorno.irA(tester, Rutas.historial);
    await capturar(tester, '4-historial');
  });

  testWidgets('configuración', (tester) async {
    await entorno.montar(tester, tamano: const Size(430, 1400));
    await entorno.irA(tester, Rutas.configuracion);
    await capturar(tester, '5-configuracion');
  });

  testWidgets('RIDE en PDF', (tester) async {
    final comprobante = await emitirDePrueba();
    final completo = await entorno.contenedor
        .read(comprobanteRepositorioProvider)
        .obtenerPorId(comprobante.id!);

    final bytes = await const GeneradorRide().generar(completo!, empresaDePrueba);
    File('$carpeta/ride.pdf').writeAsBytesSync(bytes);
    expect(bytes, isNotEmpty);
  });
}
