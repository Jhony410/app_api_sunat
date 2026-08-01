import 'package:app_api_sunat/core/constantes/catalogos_sunat.dart';
import 'package:app_api_sunat/core/router/rutas.dart';
import 'package:app_api_sunat/features/comprobantes/data/generador_ride.dart';
import 'package:app_api_sunat/features/comprobantes/domain/entidades/comprobante.dart';
import 'package:app_api_sunat/features/comprobantes/domain/entidades/item_comprobante.dart';
import 'package:app_api_sunat/features/comprobantes/domain/servicios/generador_hash.dart';
import 'package:app_api_sunat/features/comprobantes/presentation/providers/comprobantes_providers.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utiles/entorno_prueba.dart';

void main() {
  late EntornoPrueba entorno;

  setUp(() async {
    entorno = await EntornoPrueba.crear(empresa: empresaDePrueba);
  });

  tearDown(() => entorno.cerrar());

  /// Deja un comprobante guardado, como si ya se hubiera emitido.
  Future<Comprobante> emitirDePrueba() async {
    final repositorio = entorno.contenedor.read(comprobanteRepositorioProvider);
    final guardado = await repositorio.crear(
      Comprobante(
        tipo: TipoComprobante.factura,
        serie: 'F001',
        correlativo: 0,
        fechaEmision: DateTime(2026, 8, 1),
        cliente: clienteConRuc,
        observaciones: 'Entrega en almacén central',
        items: const [
          ItemComprobante(
            descripcion: 'Servicio de consultoría',
            cantidad: 2,
            valorUnitario: 50,
            orden: 1,
          ),
          ItemComprobante(
            descripcion: 'Manual impreso',
            cantidad: 1,
            valorUnitario: 30,
            tipoAfectacionIgv: TipoAfectacionIgv.exonerado,
            orden: 2,
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

  testWidgets('muestra cabecera, receptor, ítems y totales', (tester) async {
    final comprobante = await emitirDePrueba();
    await entorno.montar(tester);
    await entorno.irA(tester, Rutas.detalleDe(comprobante.id!));

    expect(find.text('F001-00000001'), findsWidgets);
    expect(find.text('Simulado'), findsOneWidget);
    expect(find.text('CLIENTE DEMO S.A.C.'), findsWidgets);

    expect(find.text('Servicio de consultoría'), findsOneWidget);
    expect(find.text('Manual impreso'), findsOneWidget);

    // 100 gravado (18 de IGV) + 30 exonerado = 148.
    expect(find.text('S/ 148.00'), findsWidgets);
    expect(find.text('S/ 18.00'), findsOneWidget);
    expect(
      find.text('CIENTO CUARENTA Y OCHO CON 00/100 SOLES'),
      findsOneWidget,
    );
  });

  testWidgets('las observaciones y la trazabilidad quedan a la vista',
      (tester) async {
    final comprobante = await emitirDePrueba();
    await entorno.montar(tester);
    await entorno.irA(tester, Rutas.detalleDe(comprobante.id!));

    expect(find.text('Entrega en almacén central'), findsOneWidget);
    expect(find.text(empresaDePrueba.ruc), findsOneWidget);
    expect(find.text('01 — Factura'), findsOneWidget);
  });

  testWidgets('un id inexistente no rompe la pantalla', (tester) async {
    await entorno.montar(tester);
    await entorno.irA(tester, Rutas.detalleDe(9999));

    expect(find.text('Comprobante no encontrado'), findsOneWidget);
  });

  testWidgets('el RIDE se genera como un PDF bien formado', (tester) async {
    final comprobante = await emitirDePrueba();
    final completo = await entorno.contenedor
        .read(comprobanteRepositorioProvider)
        .obtenerPorId(comprobante.id!);

    final bytes = await const GeneradorRide().generar(completo!, empresaDePrueba);
    final cola = String.fromCharCodes(bytes.skip(bytes.length - 32));

    // Documento completo: cabecera y marca de fin. Llegar hasta aquí ya prueba
    // que las cuatro TTF se cargaron y que el QR se pudo trazar, porque
    // `generar` lanzaría antes de devolver nada.
    expect(String.fromCharCodes(bytes.take(5)), '%PDF-');
    expect(cola, contains('%%EOF'));
    // Un PDF sin tipografías incrustadas no pasaría de unos pocos kilobytes.
    expect(bytes.length, greaterThan(10000));

    expect(
      const GeneradorRide().nombreArchivo(completo, empresaDePrueba),
      '20601030013-01-F001-00000001.pdf',
    );
  });

  testWidgets('la cadena del QR lleva los campos que exige SUNAT', (tester) async {
    final comprobante = await emitirDePrueba();
    final completo = await entorno.contenedor
        .read(comprobanteRepositorioProvider)
        .obtenerPorId(comprobante.id!);

    final partes = completo!.cadenaQr(rucEmisor: empresaDePrueba.ruc).split('|');

    expect(partes[0], empresaDePrueba.ruc);
    expect(partes[1], '01');
    expect(partes[2], 'F001');
    expect(partes[3], '1');
    expect(partes[4], '18.00');
    expect(partes[5], '148.00');
    expect(partes[6], '2026-08-01');
    expect(partes[7], '6');
    expect(partes[8], clienteConRuc.numeroDocumento);
    expect(partes[9], isNotEmpty);
  });
}
