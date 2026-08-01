import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/rutas.dart';

/// Contenedor de las cuatro secciones principales con la barra de navegación
/// inferior. En pantallas anchas la barra se convierte en un riel lateral.
class CascaronNavegacion extends StatelessWidget {
  const CascaronNavegacion({required this.child, super.key});

  final Widget child;

  static const _destinos = [
    (
      ruta: Rutas.inicio,
      icono: Icons.dashboard_outlined,
      iconoActivo: Icons.dashboard_rounded,
      etiqueta: 'Inicio',
    ),
    (
      ruta: Rutas.historial,
      icono: Icons.receipt_long_outlined,
      iconoActivo: Icons.receipt_long_rounded,
      etiqueta: 'Historial',
    ),
    (
      ruta: Rutas.clientes,
      icono: Icons.people_outline_rounded,
      iconoActivo: Icons.people_rounded,
      etiqueta: 'Clientes',
    ),
    (
      ruta: Rutas.configuracion,
      icono: Icons.settings_outlined,
      iconoActivo: Icons.settings_rounded,
      etiqueta: 'Ajustes',
    ),
  ];

  int _indiceActual(BuildContext context) {
    final ubicacion = GoRouterState.of(context).matchedLocation;
    final indice = _destinos.indexWhere((d) => d.ruta == ubicacion);
    return indice < 0 ? 0 : indice;
  }

  void _ir(BuildContext context, int indice) {
    final destino = _destinos[indice].ruta;
    if (destino != GoRouterState.of(context).matchedLocation) {
      context.go(destino);
    }
  }

  @override
  Widget build(BuildContext context) {
    final indice = _indiceActual(context);
    final esAncha = MediaQuery.sizeOf(context).width >= 720;

    if (esAncha) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: indice,
              onDestinationSelected: (i) => _ir(context, i),
              labelType: NavigationRailLabelType.all,
              destinations: [
                for (final destino in _destinos)
                  NavigationRailDestination(
                    icon: Icon(destino.icono),
                    selectedIcon: Icon(destino.iconoActivo),
                    label: Text(destino.etiqueta),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: indice,
        onDestinationSelected: (i) => _ir(context, i),
        destinations: [
          for (final destino in _destinos)
            NavigationDestination(
              icon: Icon(destino.icono),
              selectedIcon: Icon(destino.iconoActivo),
              label: destino.etiqueta,
            ),
        ],
      ),
    );
  }
}
