import 'package:app_api_sunat/core/constantes/catalogos_sunat.dart';
import 'package:app_api_sunat/core/database/app_database.dart';
import 'package:app_api_sunat/core/providers/nucleo_providers.dart';
import 'package:app_api_sunat/core/router/router_provider.dart';
import 'package:app_api_sunat/core/utils/formatos.dart';
import 'package:app_api_sunat/features/clientes/domain/entidades/cliente.dart';
import 'package:app_api_sunat/features/clientes/presentation/providers/clientes_providers.dart';
import 'package:app_api_sunat/features/empresa/domain/entidades/empresa.dart';
import 'package:app_api_sunat/features/empresa/presentation/providers/empresa_providers.dart';
import 'package:app_api_sunat/main.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

/// Andamiaje para montar la app real contra una base de datos en memoria.
///
/// Se monta la app entera —router, tema y providers incluidos— en lugar de la
/// pantalla suelta: así las pruebas cubren también el cableado, que es
/// justamente donde se esconden los fallos que `flutter analyze` no ve.
class EntornoPrueba {
  EntornoPrueba._(this.contenedor, this.base);

  final ProviderContainer contenedor;
  final AppDatabase base;

  /// Prepara el contenedor con la base en memoria y, si se pide, con una
  /// empresa ya configurada (sin ella el router fuerza el onboarding).
  static Future<EntornoPrueba> crear({Empresa? empresa}) async {
    await initializeDateFormatting(kLocalePeru);

    final base = AppDatabase.paraPruebas(NativeDatabase.memory());
    final contenedor = ProviderContainer(
      overrides: [appDatabaseProvider.overrideWithValue(base)],
    );

    if (empresa != null) {
      await contenedor.read(empresaRepositorioProvider).guardar(empresa);
    }

    return EntornoPrueba._(contenedor, base);
  }

  Future<int> guardarCliente(Cliente cliente) =>
      contenedor.read(clienteRepositorioProvider).guardar(cliente);

  /// Monta la app y espera a que se asienten los streams de Drift.
  ///
  /// El lienzo por defecto del entorno de pruebas (800 × 600) deja fuera de
  /// pantalla la mitad de un formulario largo. Se agranda para poder tocar
  /// cualquier control sin desplazar en cada paso.
  Future<void> montar(WidgetTester tester, {Size tamano = const Size(1200, 2400)}) async {
    tester.view.physicalSize = tamano;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: contenedor,
        child: const AppFacturacion(),
      ),
    );
    await tester.pumpAndSettle();
  }

  /// Navega por el router real, como haría un toque en la interfaz.
  Future<void> irA(WidgetTester tester, String ruta) async {
    contenedor.read(routerProvider).push(ruta);
    await tester.pumpAndSettle();
  }

  Future<void> cerrar() async {
    contenedor.dispose();
    await base.close();
  }
}

/// Emisor de ejemplo, con RUC válido según el módulo 11.
const empresaDePrueba = Empresa(
  ruc: '20601030013',
  razonSocial: 'DEMO FACTURACIÓN S.A.C.',
  nombreComercial: 'DEMO',
  direccion: 'AV. SIEMPRE VIVA 742',
  ubigeo: '150101',
  departamento: 'LIMA',
  provincia: 'LIMA',
  distrito: 'LIMA',
  seriesFactura: ['F001'],
  seriesBoleta: ['B001'],
);

/// Receptor con RUC, apto para recibir una factura.
const clienteConRuc = Cliente(
  tipoDocumento: TipoDocumentoIdentidad.ruc,
  numeroDocumento: '20552103816',
  razonSocialONombres: 'CLIENTE DEMO S.A.C.',
  direccion: 'JR. LOS OLIVOS 123',
);
