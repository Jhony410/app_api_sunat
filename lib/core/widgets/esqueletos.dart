import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

/// Bloque gris con brillo animado que ocupa el sitio del contenido mientras
/// carga, para evitar el salto de layout de un spinner centrado.
class Esqueleto extends StatefulWidget {
  const Esqueleto({
    this.ancho,
    this.alto = 16,
    this.radio = Radios.chico,
    super.key,
  });

  final double? ancho;
  final double alto;
  final double radio;

  @override
  State<Esqueleto> createState() => _EsqueletoState();
}

class _EsqueletoState extends State<Esqueleto> with SingleTickerProviderStateMixin {
  late final AnimationController _controlador = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat(reverse: true);

  @override
  void dispose() {
    _controlador.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;

    return AnimatedBuilder(
      animation: _controlador,
      builder: (context, _) {
        return Container(
          width: widget.ancho,
          height: widget.alto,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(widget.radio),
            color: Color.lerp(
              esquema.surfaceContainerHigh,
              esquema.surfaceContainerHighest,
              _controlador.value,
            ),
          ),
        );
      },
    );
  }
}

/// Esqueleto con la forma de una fila del historial o de la lista de clientes.
class EsqueletoFilaLista extends StatelessWidget {
  const EsqueletoFilaLista({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: Espaciado.md,
        vertical: Espaciado.sm,
      ),
      child: Row(
        children: [
          const Esqueleto(ancho: 44, alto: 44, radio: Radios.chico),
          const SizedBox(width: Espaciado.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Esqueleto(ancho: 160, alto: 14),
                const SizedBox(height: Espaciado.xs),
                Esqueleto(
                  ancho: 100 + (context.hashCode % 60).toDouble(),
                  alto: 12,
                ),
              ],
            ),
          ),
          const SizedBox(width: Espaciado.md),
          const Esqueleto(ancho: 64, alto: 16),
        ],
      ),
    );
  }
}

/// Varias filas de esqueleto, para rellenar una lista completa.
class EsqueletoLista extends StatelessWidget {
  const EsqueletoLista({this.filas = 6, super.key});

  final int filas;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: Espaciado.xs),
      itemCount: filas,
      separatorBuilder: (_, _) => const SizedBox(height: Espaciado.xxs),
      itemBuilder: (_, _) => const EsqueletoFilaLista(),
    );
  }
}
