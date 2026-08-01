import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Bloque de contenido con encabezado, usado en formularios y en el detalle
/// del comprobante para agrupar campos relacionados.
class Seccion extends StatelessWidget {
  const Seccion({
    required this.titulo,
    required this.hijo,
    this.subtitulo,
    this.icono,
    this.accion,
    this.padding = const EdgeInsets.all(Espaciado.md),
    super.key,
  });

  final String titulo;
  final String? subtitulo;
  final IconData? icono;
  final Widget? accion;
  final Widget hijo;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;
    final esquema = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (icono != null) ...[
                  Icon(icono, size: 18, color: esquema.primary),
                  const SizedBox(width: Espaciado.xs),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(titulo, style: textos.titleSmall),
                      if (subtitulo != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(subtitulo!, style: textos.bodySmall),
                        ),
                    ],
                  ),
                ),
                if (accion != null) accion!,
              ],
            ),
            const SizedBox(height: Espaciado.md),
            hijo,
          ],
        ),
      ),
    );
  }
}

/// Fila de "etiqueta a la izquierda, valor a la derecha", el patrón que se
/// repite en el detalle del comprobante y en los totales.
class FilaDato extends StatelessWidget {
  const FilaDato({
    required this.etiqueta,
    required this.valor,
    this.destacado = false,
    this.colorValor,
    super.key,
  });

  final String etiqueta;
  final String valor;
  final bool destacado;
  final Color? colorValor;

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;
    final esquema = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: Espaciado.xxs + 1),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Text(
              etiqueta,
              style: (destacado ? textos.titleSmall : textos.bodyMedium)?.copyWith(
                color: destacado ? esquema.onSurface : esquema.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(width: Espaciado.sm),
          Expanded(
            flex: 5,
            child: Text(
              valor,
              textAlign: TextAlign.end,
              style: (destacado ? textos.titleMedium : textos.bodyMedium)?.copyWith(
                color: colorValor,
                fontWeight: destacado ? FontWeight.w700 : FontWeight.w500,
                fontFeatures: const [FontFeature.tabularFigures()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
