import 'package:flutter/material.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatos.dart';
import '../../domain/entidades/item_comprobante.dart';
import '../../domain/entidades/totales.dart';

/// Línea del comprobante tal como se lee en pantalla.
///
/// Sirve al formulario (con [onEditar] / [onEliminar]) y al detalle de un
/// comprobante ya emitido (sin acciones). El importe que muestra sale de la
/// [linea] calculada, nunca de una multiplicación hecha aquí.
class FilaItemComprobante extends StatelessWidget {
  const FilaItemComprobante({
    required this.item,
    required this.linea,
    required this.moneda,
    this.onEditar,
    this.onEliminar,
    super.key,
  });

  final ItemComprobante item;
  final LineaCalculada linea;
  final Moneda moneda;
  final VoidCallback? onEditar;
  final VoidCallback? onEliminar;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;
    final esGratuita = linea.afectacion.esGratuita;

    final contenido = Padding(
      padding: EdgeInsets.fromLTRB(
        Espaciado.sm,
        Espaciado.sm,
        onEliminar == null ? Espaciado.sm : Espaciado.xxs,
        Espaciado.sm,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Número de línea: es el `cbc:ID` que viajará al XML.
          Container(
            width: 26,
            height: 26,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: esquema.surfaceContainerHigh,
              borderRadius: BorderRadius.circular(Radios.chico - 4),
            ),
            child: Text('${linea.orden}', style: textos.labelSmall),
          ),
          const SizedBox(width: Espaciado.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.descripcion, style: textos.titleSmall),
                const SizedBox(height: 2),
                Text(
                  '${formatearCantidad(linea.cantidad)} ${item.unidadMedida.etiqueta} · '
                  '${formatearImporte(linea.valorUnitario)} c/u',
                  style: textos.bodySmall,
                ),
                if (item.codigo.trim().isNotEmpty)
                  Text('Código ${item.codigo}', style: textos.bodySmall),
                if (linea.descuento > 0)
                  Text(
                    'Descuento ${formatearImporte(linea.descuento)}',
                    style: textos.bodySmall
                        ?.copyWith(color: ColoresEstado.advertencia(context)),
                  ),
                if (!linea.afectacion.generaIgv)
                  Padding(
                    padding: const EdgeInsets.only(top: Espaciado.xxs),
                    child: Text(
                      linea.afectacion.etiqueta,
                      style: textos.labelSmall
                          ?.copyWith(color: esquema.onSurfaceVariant),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: Espaciado.xs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                esGratuita
                    ? 'Gratuito'
                    : formatearMoneda(linea.totalLinea, moneda: moneda),
                style: textos.titleSmall?.copyWith(
                  color: esGratuita ? esquema.onSurfaceVariant : esquema.onSurface,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
              if (linea.igv > 0)
                Text(
                  'IGV ${formatearImporte(linea.igv)}',
                  style: textos.bodySmall,
                ),
            ],
          ),
          if (onEliminar != null)
            IconButton(
              tooltip: 'Quitar ítem',
              visualDensity: VisualDensity.compact,
              icon: const Icon(Icons.close_rounded, size: 18),
              onPressed: onEliminar,
            ),
        ],
      ),
    );

    if (onEditar == null) return contenido;

    return InkWell(
      borderRadius: BorderRadius.circular(Radios.chico),
      onTap: onEditar,
      child: contenido,
    );
  }
}
