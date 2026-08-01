import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/esqueletos.dart';

/// Tarjeta de cifra destacada del dashboard.
///
/// Con [valor] en `null` muestra esqueletos en lugar de un spinner, para que la
/// cuadrícula no cambie de tamaño al terminar de cargar.
class TarjetaMetrica extends StatelessWidget {
  const TarjetaMetrica({
    required this.etiqueta,
    required this.icono,
    this.valor,
    this.detalle,
    this.acentuada = false,
    super.key,
  });

  final String etiqueta;
  final IconData icono;
  final String? valor;
  final String? detalle;

  /// La versión acentuada usa el color primario como fondo.
  final bool acentuada;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    final fondo = acentuada ? esquema.primary : esquema.surfaceContainerLowest;
    final tinte = acentuada ? esquema.onPrimary : esquema.onSurface;
    final tinteSuave =
        acentuada ? esquema.onPrimary.withValues(alpha: 0.75) : esquema.onSurfaceVariant;

    return Container(
      padding: const EdgeInsets.all(Espaciado.md),
      decoration: BoxDecoration(
        color: fondo,
        borderRadius: BorderRadius.circular(Radios.medio),
        border: acentuada
            ? null
            : Border.all(color: esquema.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icono, size: 16, color: tinteSuave),
              const SizedBox(width: Espaciado.xxs + 2),
              Text(etiqueta, style: textos.labelMedium?.copyWith(color: tinteSuave)),
            ],
          ),
          const SizedBox(height: Espaciado.sm),
          if (valor == null)
            const Esqueleto(alto: 24, ancho: 108)
          else
            FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                valor!,
                style: textos.headlineSmall?.copyWith(
                  color: tinte,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ),
          const SizedBox(height: Espaciado.xxs),
          if (detalle == null)
            const Esqueleto(alto: 12, ancho: 72)
          else
            Text(detalle!, style: textos.bodySmall?.copyWith(color: tinteSuave)),
        ],
      ),
    );
  }
}
