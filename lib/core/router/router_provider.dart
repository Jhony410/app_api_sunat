import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/clientes/presentation/pantallas/pantalla_clientes.dart';
import '../../features/clientes/presentation/pantallas/pantalla_editar_cliente.dart';
import '../../features/comprobantes/presentation/pantallas/pantalla_detalle_comprobante.dart';
import '../../features/comprobantes/presentation/pantallas/pantalla_historial.dart';
import '../../features/comprobantes/presentation/pantallas/pantalla_nuevo_comprobante.dart';
import '../../features/configuracion/presentation/pantallas/pantalla_configuracion.dart';
import '../../features/empresa/presentation/pantallas/pantalla_datos_empresa.dart';
import '../../features/empresa/presentation/pantallas/pantalla_onboarding.dart';
import '../../features/empresa/presentation/providers/empresa_providers.dart';
import '../../features/inicio/presentation/pantallas/cascaron_navegacion.dart';
import '../../features/inicio/presentation/pantallas/pantalla_inicio.dart';
import 'rutas.dart';

part 'router_provider.g.dart';

final _claveNavegadorRaiz = GlobalKey<NavigatorState>(debugLabel: 'raiz');
final _claveNavegadorShell = GlobalKey<NavigatorState>(debugLabel: 'shell');

/// Enrutador de la app.
///
/// Las cuatro secciones principales viven dentro de un `ShellRoute` con barra
/// de navegación inferior; el resto de pantallas se apila por encima. Mientras
/// falte configurar la empresa, cualquier ruta redirige al onboarding.
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: _claveNavegadorRaiz,
    initialLocation: Rutas.inicio,
    debugLogDiagnostics: false,
    redirect: (context, estado) {
      final faltaConfigurar = ref.read(requiereConfiguracionInicialProvider);
      final estaEnOnboarding = estado.matchedLocation == Rutas.onboarding;

      if (faltaConfigurar && !estaEnOnboarding) return Rutas.onboarding;
      if (!faltaConfigurar && estaEnOnboarding) return Rutas.inicio;
      return null;
    },
    // Vuelve a evaluar el `redirect` en cuanto la empresa quede configurada.
    refreshListenable: _EscuchaProvider(ref),
    routes: [
      GoRoute(
        path: Rutas.onboarding,
        name: NombresRuta.onboarding,
        builder: (context, estado) => const PantallaOnboarding(),
      ),
      ShellRoute(
        navigatorKey: _claveNavegadorShell,
        builder: (context, estado, hijo) => CascaronNavegacion(child: hijo),
        routes: [
          GoRoute(
            path: Rutas.inicio,
            name: NombresRuta.inicio,
            pageBuilder: (context, estado) =>
                const NoTransitionPage(child: PantallaInicio()),
          ),
          GoRoute(
            path: Rutas.historial,
            name: NombresRuta.historial,
            pageBuilder: (context, estado) =>
                const NoTransitionPage(child: PantallaHistorial()),
          ),
          GoRoute(
            path: Rutas.clientes,
            name: NombresRuta.clientes,
            pageBuilder: (context, estado) =>
                const NoTransitionPage(child: PantallaClientes()),
          ),
          GoRoute(
            path: Rutas.configuracion,
            name: NombresRuta.configuracion,
            pageBuilder: (context, estado) =>
                const NoTransitionPage(child: PantallaConfiguracion()),
            routes: [
              // Se apila sobre el navegador raíz para que tape la barra
              // inferior: es una pantalla de trabajo, no una sección.
              GoRoute(
                path: 'empresa',
                name: NombresRuta.datosEmpresa,
                parentNavigatorKey: _claveNavegadorRaiz,
                builder: (context, estado) => const PantallaDatosEmpresa(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: Rutas.nuevoComprobante,
        name: NombresRuta.nuevoComprobante,
        parentNavigatorKey: _claveNavegadorRaiz,
        builder: (context, estado) => const PantallaNuevoComprobante(),
      ),
      GoRoute(
        path: Rutas.nuevoCliente,
        name: NombresRuta.nuevoCliente,
        parentNavigatorKey: _claveNavegadorRaiz,
        builder: (context, estado) => const PantallaEditarCliente(),
      ),
      GoRoute(
        path: Rutas.editarCliente,
        name: NombresRuta.editarCliente,
        parentNavigatorKey: _claveNavegadorRaiz,
        builder: (context, estado) => PantallaEditarCliente(
          clienteId: int.tryParse(estado.pathParameters['id'] ?? ''),
        ),
      ),
      GoRoute(
        path: Rutas.detalleComprobante,
        name: NombresRuta.detalleComprobante,
        parentNavigatorKey: _claveNavegadorRaiz,
        builder: (context, estado) => PantallaDetalleComprobante(
          comprobanteId: int.parse(estado.pathParameters['id']!),
        ),
      ),
    ],
    errorBuilder: (context, estado) => _PantallaRutaNoEncontrada(ruta: estado.uri.path),
  );
}

/// Puente entre Riverpod y `GoRouter.refreshListenable`.
class _EscuchaProvider extends ChangeNotifier {
  _EscuchaProvider(Ref ref) {
    ref.listen(requiereConfiguracionInicialProvider, (_, _) => notifyListeners());
  }
}

class _PantallaRutaNoEncontrada extends StatelessWidget {
  const _PantallaRutaNoEncontrada({required this.ruta});

  final String ruta;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Página no encontrada')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.explore_off_outlined, size: 56),
            const SizedBox(height: 16),
            Text('No existe la ruta $ruta'),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () => context.go(Rutas.inicio),
              child: const Text('Ir al inicio'),
            ),
          ],
        ),
      ),
    );
  }
}
