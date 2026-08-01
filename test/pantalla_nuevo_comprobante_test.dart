import 'package:app_api_sunat/core/constantes/catalogos_sunat.dart';
import 'package:app_api_sunat/core/router/rutas.dart';
import 'package:app_api_sunat/features/comprobantes/presentation/providers/comprobantes_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utiles/entorno_prueba.dart';

/// Recorrido de la pantalla de emisión sobre la app real.
void main() {
  late EntornoPrueba entorno;

  setUp(() async {
    entorno = await EntornoPrueba.crear(empresa: empresaDePrueba);
  });

  tearDown(() => entorno.cerrar());

  /// Captura un ítem a través de la hoja inferior, como haría el usuario.
  Future<void> agregarItem(
    WidgetTester tester, {
    required String descripcion,
    required String cantidad,
    required String valorUnitario,
  }) async {
    await tester.tap(find.text('Agregar el primero').hitTestable());
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'Descripción'),
      descripcion,
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Cantidad'),
      cantidad,
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Valor unitario (sin IGV)'),
      valorUnitario,
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Agregar al comprobante'));
    await tester.pumpAndSettle();
  }

  testWidgets('parte de la serie de la empresa y del correlativo 1', (tester) async {
    await entorno.montar(tester);
    await entorno.irA(tester, Rutas.nuevoComprobante);

    expect(find.text('Nueva factura'), findsOneWidget);
    expect(find.text('F001'), findsWidgets);
    // El número previsto es informativo: sale de la tabla de correlativos.
    expect(find.text('00000001'), findsOneWidget);
  });

  testWidgets('el borrador nace sin receptor cuando el tipo es factura', (tester) async {
    await entorno.montar(tester);
    await entorno.irA(tester, Rutas.nuevoComprobante);

    // "CLIENTES VARIOS" no vale para una factura, así que no debe arrastrarse.
    expect(find.text('CLIENTES VARIOS'), findsNothing);
    expect(find.text('Sin cliente'), findsOneWidget);
  });

  testWidgets('los totales se recalculan al agregar un ítem', (tester) async {
    await entorno.montar(tester);
    await entorno.irA(tester, Rutas.nuevoComprobante);

    await agregarItem(
      tester,
      descripcion: 'Servicio de consultoría',
      cantidad: '2',
      valorUnitario: '50',
    );

    expect(find.text('Servicio de consultoría'), findsOneWidget);
    // 2 × 50 = 100 de base, 18 de IGV, 118 a pagar.
    expect(find.text('S/ 118.00'), findsWidgets);
    expect(find.text('S/ 18.00'), findsOneWidget);
  });

  testWidgets('emitir sin receptor avisa en lugar de guardar', (tester) async {
    await entorno.montar(tester);
    await entorno.irA(tester, Rutas.nuevoComprobante);

    await agregarItem(
      tester,
      descripcion: 'Servicio',
      cantidad: '1',
      valorUnitario: '100',
    );

    await tester.tap(find.text('Emitir'));
    await tester.pumpAndSettle();

    expect(find.text('Falta completar el comprobante'), findsOneWidget);
    expect(
      find.textContaining('debe tener razón social o nombres'),
      findsOneWidget,
    );

    // Nada llegó a la base de datos.
    final historial =
        await entorno.contenedor.read(historialComprobantesProvider.future);
    expect(historial, isEmpty);
  });

  testWidgets('emitir con receptor guarda, reserva el correlativo y abre el detalle',
      (tester) async {
    await entorno.guardarCliente(clienteConRuc);
    await entorno.montar(tester);
    await entorno.irA(tester, Rutas.nuevoComprobante);

    // Elegir el cliente desde la agenda.
    await tester.tap(find.text('Buscar en la agenda'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('CLIENTE DEMO S.A.C.'));
    await tester.pumpAndSettle();

    await agregarItem(
      tester,
      descripcion: 'Servicio',
      cantidad: '1',
      valorUnitario: '100',
    );

    await tester.tap(find.text('Emitir'));
    await tester.pumpAndSettle();

    // La pantalla de detalle tomó el relevo.
    expect(find.text('F001-00000001'), findsWidgets);
    expect(find.text('RIDE'), findsOneWidget);

    final historial =
        await entorno.contenedor.read(historialComprobantesProvider.future);
    expect(historial, hasLength(1));
    expect(historial.single.correlativo, 1);
    expect(historial.single.importeTotal, 118.00);
    // Sin pasarela configurada, la emisión degrada a Simulación.
    expect(historial.single.estadoSunat, EstadoSunat.simulado);

    // El comprobante guarda copia del receptor, no una referencia.
    final guardado = await entorno.contenedor
        .read(comprobanteRepositorioProvider)
        .obtenerPorId(historial.single.id);
    expect(guardado!.cliente.razonSocialONombres, 'CLIENTE DEMO S.A.C.');
    expect(guardado.cliente.numeroDocumento, '20552103816');
    expect(guardado.hashCodigo, isNotEmpty);
  });

  testWidgets('dos emisiones seguidas no repiten el correlativo', (tester) async {
    await entorno.guardarCliente(clienteConRuc);
    await entorno.montar(tester);

    for (var i = 0; i < 2; i++) {
      await entorno.irA(tester, Rutas.nuevoComprobante);
      await tester.tap(find.text('Buscar en la agenda'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('CLIENTE DEMO S.A.C.'));
      await tester.pumpAndSettle();
      await agregarItem(
        tester,
        descripcion: 'Servicio',
        cantidad: '1',
        valorUnitario: '100',
      );
      await tester.tap(find.text('Emitir'));
      await tester.pumpAndSettle();
    }

    final historial =
        await entorno.contenedor.read(historialComprobantesProvider.future);
    expect(
      historial.map((c) => c.correlativo).toList()..sort(),
      [1, 2],
    );
  });
}
