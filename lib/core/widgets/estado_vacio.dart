import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Estado vacío ilustrado: un ícono dentro de un halo de color, un título, una
/// explicación y —si procede— la acción que resuelve el vacío.
///
/// Se usa en historial, clientes y resultados de búsqueda para que una lista
/// sin datos nunca sea una pantalla en blanco.
class EstadoVacio extends StatelessWidget {
  const EstadoVacio({
    required this.icono,
    required this.titulo,
    required this.mensaje,
    this.etiquetaAccion,
    this.onAccion,
    this.compacto = false,
    super.key,
  });

  final IconData icono;
  final String titulo;
  final String mensaje;
  final String? etiquetaAccion;
  final VoidCallback? onAccion;

  /// Versión reducida, para cuando el vacío ocupa sólo una tarjeta.
  final bool compacto;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;
    final diametro = compacto ? 72.0 : 104.0;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(Espaciado.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Halo concéntrico: da presencia al vacío sin necesitar una imagen.
            Container(
              width: diametro,
              height: diametro,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: esquema.primary.withValues(alpha: 0.07),
              ),
              child: Center(
                child: Container(
                  width: diametro * 0.62,
                  height: diametro * 0.62,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: esquema.primary.withValues(alpha: 0.12),
                  ),
                  child: Icon(
                    icono,
                    size: diametro * 0.32,
                    color: esquema.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: compacto ? Espaciado.md : Espaciado.lg),
            Text(
              titulo,
              textAlign: TextAlign.center,
              style: compacto ? textos.titleSmall : textos.titleMedium,
            ),
            const SizedBox(height: Espaciado.xs),
            ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Text(
                mensaje,
                textAlign: TextAlign.center,
                style: textos.bodyMedium?.copyWith(color: esquema.onSurfaceVariant),
              ),
            ),
            if (etiquetaAccion != null && onAccion != null) ...[
              const SizedBox(height: Espaciado.lg),
              FilledButton.tonal(onPressed: onAccion, child: Text(etiquetaAccion!)),
            ],
          ],
        ),
      ),
    );
  }
}
