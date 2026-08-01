import 'package:app_api_sunat/core/database/tablas.dart';
import 'package:app_api_sunat/core/router/rutas.dart';
import 'package:app_api_sunat/features/configuracion/presentation/providers/ajustes_providers.dart';
import 'package:app_api_sunat/features/empresa/presentation/providers/empresa_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'utiles/entorno_prueba.dart';

void main() {
  late EntornoPrueba entorno;

  setUp(() async {
    entorno = await EntornoPrueba.crear(empresa: empresaDePrueba);
  });

  tearDown(() => entorno.cerrar());

  testWidgets('arranca en modo Simulación y lo explica', (tester) async {
    await entorno.montar(tester);
    await entorno.irA(tester, Rutas.configuracion);

    expect(find.text('Configuración'), findsOneWidget);
    expect(
      find.textContaining('no se envían a SUNAT'),
      findsOneWidget,
    );
    expect(find.text('Sin configurar'), findsOneWidget);
  });

  testWidgets('cambiar a emisión real se persiste y avisa de que falta Lycet',
      (tester) async {
    await entorno.montar(tester);
    await entorno.irA(tester, Rutas.configuracion);

    await tester.tap(find.text('Emisión real (BETA)'));
    await tester.pumpAndSettle();

    final ajustes = await entorno.contenedor.read(ajustesProvider.future);
    expect(ajustes.modoOperacion, ModoOperacion.real);
    // Sin URL de Lycet la emisión seguiría degradando a Simulación.
    expect(ajustes.puedeEmitirEnReal, isFalse);
    expect(
      find.textContaining('seguirá cayendo a modo Simulación'),
      findsOneWidget,
    );
  });

  testWidgets('guardar la conexión de Lycet escribe URL y token', (tester) async {
    await entorno.montar(tester);
    await entorno.irA(tester, Rutas.configuracion);

    await tester.tap(find.text('URL del servicio'));
    await tester.pumpAndSettle();

    await tester.enterText(
      find.widgetWithText(TextField, 'URL del servicio'),
      'https://lycet.demo.pe',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Token de acceso'),
      'token-secreto-1234',
    );
    await tester.tap(find.text('Guardar'));
    await tester.pumpAndSettle();

    // Las dos claves se escriben con un `await` entre medias: si el controlador
    // se destruyera tras la primera, la segunda no llegaría.
    final ajustes = await entorno.contenedor.read(ajustesProvider.future);
    expect(ajustes.lycetUrl, 'https://lycet.demo.pe');
    expect(ajustes.lycetToken, 'token-secreto-1234');

    // El token no se muestra entero.
    expect(find.text('••••••••1234'), findsOneWidget);
    expect(find.text('token-secreto-1234'), findsNothing);
  });

  testWidgets('el tema elegido se guarda', (tester) async {
    await entorno.montar(tester);
    await entorno.irA(tester, Rutas.configuracion);

    await tester.tap(find.text('Oscuro'));
    await tester.pumpAndSettle();

    final ajustes = await entorno.contenedor.read(ajustesProvider.future);
    expect(ajustes.temaApp, ThemeMode.dark);
  });

  testWidgets('se pueden editar los datos del emisor', (tester) async {
    await entorno.montar(tester);
    await entorno.irA(tester, Rutas.configuracion);

    await tester.tap(find.text(empresaDePrueba.razonSocial));
    await tester.pumpAndSettle();

    expect(find.text('Datos de la empresa'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextField, 'Series de factura'),
      'F001, F002',
    );
    await tester.tap(find.text('Guardar cambios'));
    await tester.pumpAndSettle();

    final empresa = await entorno.contenedor.read(empresaProvider.future);
    expect(empresa!.seriesFactura, ['F001', 'F002']);
  });
}
