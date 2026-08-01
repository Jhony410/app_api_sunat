import 'package:flutter/material.dart';

import '../constantes/catalogos_sunat.dart';
import '../theme/app_theme.dart';

/// Insignia con el estado del comprobante frente a SUNAT.
///
/// El color comunica el resultado y el ícono lo refuerza, para que el estado
/// siga siendo legible sin depender sólo del color.
class EtiquetaEstado extends StatelessWidget {
  const EtiquetaEstado(this.estado, {this.compacta = false, super.key});

  final EstadoSunat estado;
  final bool compacta;

  @override
  Widget build(BuildContext context) {
    final (color, icono) = _aspecto(context, estado);
    final textos = Theme.of(context).textTheme;

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: compacta ? Espaciado.xs : Espaciado.sm,
        vertical: compacta ? 3 : 6,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Radios.completo),
        border: Border.all(color: color.withValues(alpha: 0.28)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icono, size: compacta ? 12 : 14, color: color),
          const SizedBox(width: Espaciado.xxs + 2),
          Text(
            estado.etiqueta,
            style: (compacta ? textos.labelSmall : textos.labelMedium)
                ?.copyWith(color: color, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  static (Color, IconData) _aspecto(BuildContext context, EstadoSunat estado) {
    return switch (estado) {
      EstadoSunat.simulado => (
          ColoresEstado.neutro(context),
          Icons.science_outlined,
        ),
      EstadoSunat.pendienteEnvio => (
          ColoresEstado.advertencia(context),
          Icons.schedule_outlined,
        ),
      EstadoSunat.enviado => (
          ColoresEstado.informacion(context),
          Icons.cloud_upload_outlined,
        ),
      EstadoSunat.aceptado => (
          ColoresEstado.exito(context),
          Icons.verified_outlined,
        ),
      EstadoSunat.rechazado => (
          Theme.of(context).colorScheme.error,
          Icons.cancel_outlined,
        ),
      EstadoSunat.observado => (
          ColoresEstado.advertencia(context),
          Icons.report_problem_outlined,
        ),
    };
  }
}

/// Insignia con el tipo de comprobante (`Factura`, `Boleta`, …).
class EtiquetaTipoComprobante extends StatelessWidget {
  const EtiquetaTipoComprobante(this.tipo, {super.key});

  final TipoComprobante tipo;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final color = switch (tipo) {
      TipoComprobante.factura => esquema.primary,
      TipoComprobante.boleta => esquema.tertiary,
      TipoComprobante.notaCredito => esquema.error,
      TipoComprobante.notaDebito => ColoresEstado.advertencia(context),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Espaciado.xs, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Radios.chico - 4),
      ),
      child: Text(
        tipo.etiqueta,
        style: Theme.of(context)
            .textTheme
            .labelSmall
            ?.copyWith(color: color, fontWeight: FontWeight.w600),
      ),
    );
  }
}
