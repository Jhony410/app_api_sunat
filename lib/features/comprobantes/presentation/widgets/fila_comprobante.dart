import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/router/rutas.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatos.dart';
import '../../../../core/widgets/etiqueta_estado.dart';
import '../../domain/entidades/resumen_comprobante.dart';

/// Fila del historial: identifica el comprobante, su receptor, su estado y su
/// importe. Al tocarla abre el detalle con una transición Hero sobre el número.
class FilaComprobante extends StatelessWidget {
  const FilaComprobante(this.resumen, {this.mostrarFecha = true, super.key});

  final ResumenComprobante resumen;
  final bool mostrarFecha;

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;
    final esquema = Theme.of(context).colorScheme;
    final esNotaCredito = resumen.tipo == TipoComprobante.notaCredito;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(Radios.medio),
        onTap: () => context.push(Rutas.detalleDe(resumen.id)),
        child: Padding(
          padding: const EdgeInsets.all(Espaciado.sm + 2),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconoTipo(tipo: resumen.tipo),
              const SizedBox(width: Espaciado.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Hero(
                            tag: 'comprobante-${resumen.id}',
                            child: Material(
                              type: MaterialType.transparency,
                              child: Text(
                                resumen.numeroCompleto,
                                style: textos.titleSmall,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        if (mostrarFecha) ...[
                          const SizedBox(width: Espaciado.xs),
                          Text(
                            formatearFecha(resumen.fechaEmision),
                            style: textos.bodySmall,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      resumen.clienteRazonSocial,
                      style: textos.bodyMedium
                          ?.copyWith(color: esquema.onSurfaceVariant),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: Espaciado.xs),
                    EtiquetaEstado(resumen.estadoSunat, compacta: true),
                  ],
                ),
              ),
              const SizedBox(width: Espaciado.xs),
              Text(
                // Las notas de crédito restan: se muestran con signo negativo.
                '${esNotaCredito ? '−' : ''}'
                '${formatearMoneda(resumen.importeTotal, moneda: resumen.moneda)}',
                style: textos.titleSmall?.copyWith(
                  color: esNotaCredito ? esquema.error : esquema.onSurface,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconoTipo extends StatelessWidget {
  const _IconoTipo({required this.tipo});

  final TipoComprobante tipo;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final (color, icono) = switch (tipo) {
      TipoComprobante.factura => (esquema.primary, Icons.description_outlined),
      TipoComprobante.boleta => (esquema.tertiary, Icons.receipt_outlined),
      TipoComprobante.notaCredito => (esquema.error, Icons.undo_rounded),
      TipoComprobante.notaDebito => (
          ColoresEstado.advertencia(context),
          Icons.redo_rounded,
        ),
    };

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(Radios.chico),
      ),
      child: Icon(icono, color: color, size: 20),
    );
  }
}
