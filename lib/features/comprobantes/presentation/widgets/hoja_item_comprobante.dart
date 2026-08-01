import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/formatos.dart';
import '../../domain/entidades/item_comprobante.dart';
import '../../domain/entidades/totales.dart';
import '../../domain/servicios/calculadora_totales.dart';

/// Hoja inferior para agregar o editar una línea del comprobante.
///
/// Mientras se teclea muestra el resultado de `CalculadoraTotales` para esa
/// línea. No calcula nada por su cuenta: usa el mismo motor que después
/// producirá los totales, el RIDE y el XML, así que lo que se ve aquí es
/// exactamente lo que se va a emitir.
class HojaItemComprobante extends StatefulWidget {
  const HojaItemComprobante({this.inicial, super.key});

  /// `null` para capturar una línea nueva.
  final ItemComprobante? inicial;

  /// Abre la hoja y devuelve el ítem capturado, o `null` si se canceló.
  static Future<ItemComprobante?> mostrar(
    BuildContext context, {
    ItemComprobante? inicial,
  }) {
    return showModalBottomSheet<ItemComprobante>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => HojaItemComprobante(inicial: inicial),
    );
  }

  @override
  State<HojaItemComprobante> createState() => _HojaItemComprobanteState();
}

class _HojaItemComprobanteState extends State<HojaItemComprobante> {
  final _formKey = GlobalKey<FormBuilderState>();

  late UnidadMedida _unidadMedida =
      widget.inicial?.unidadMedida ?? UnidadMedida.unidad;
  late TipoAfectacionIgv _afectacion =
      widget.inicial?.tipoAfectacionIgv ?? TipoAfectacionIgv.gravado;

  /// El usuario de a pie conoce el precio al público, no el valor sin IGV. Se
  /// deja elegir cuál teclea y la conversión la hace la calculadora.
  bool _capturaPrecioConIgv = false;

  /// Vista previa de la línea, recalculada con cada pulsación.
  late LineaCalculada _vistaPrevia = _calcular();

  /// Afectaciones ofrecidas: las frecuentes, más la del ítem que se edita si
  /// resulta ser una de las poco habituales.
  List<TipoAfectacionIgv> get _afectacionesDisponibles => {
        ...TipoAfectacionIgv.opcionesFrecuentes,
        _afectacion,
      }.toList();

  double _numero(String clave) {
    final valor = _formKey.currentState?.instantValue[clave];
    return _aNumero(valor as String?);
  }

  /// Acepta tanto `12.50` como `12,50`: el teclado numérico de Android e iOS
  /// ofrece uno u otro separador según la configuración del dispositivo.
  static double _aNumero(String? texto) =>
      double.tryParse((texto ?? '').trim().replaceAll(',', '.')) ?? 0;

  ItemComprobante _leerItem() {
    final valores = _formKey.currentState?.instantValue ?? const {};
    final capturado = _numero('importeUnitario');

    return ItemComprobante(
      id: widget.inicial?.id,
      comprobanteId: widget.inicial?.comprobanteId,
      codigo: (valores['codigo'] as String? ?? '').trim(),
      descripcion: (valores['descripcion'] as String? ?? '').trim(),
      unidadMedida: _unidadMedida,
      cantidad: _numero('cantidad'),
      // Lo que se persiste siempre es el valor sin IGV.
      valorUnitario: _capturaPrecioConIgv
          ? calculadoraTotales.valorUnitarioDesdePrecio(capturado, _afectacion)
          : capturado,
      tipoAfectacionIgv: _afectacion,
      descuento: _numero('descuento'),
      orden: widget.inicial?.orden ?? 0,
    );
  }

  LineaCalculada _calcular() => calculadoraTotales.calcularLinea(_leerItem());

  void _recalcular() => setState(() => _vistaPrevia = _calcular());

  void _confirmar() {
    if (!(_formKey.currentState?.saveAndValidate() ?? false)) return;
    Navigator.pop(context, _leerItem());
  }

  @override
  Widget build(BuildContext context) {
    final textos = Theme.of(context).textTheme;
    final esNuevo = widget.inicial == null;

    return Padding(
      // Deja sitio al teclado para que el resumen y el botón no queden tapados.
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          Espaciado.md,
          0,
          Espaciado.md,
          Espaciado.md,
        ),
        child: FormBuilder(
          key: _formKey,
          onChanged: _recalcular,
          initialValue: {
            'descripcion': widget.inicial?.descripcion ?? '',
            'codigo': widget.inicial?.codigo ?? '',
            'cantidad': _textoCantidad(widget.inicial?.cantidad ?? 1),
            'importeUnitario': widget.inicial == null
                ? ''
                : _textoImporte(widget.inicial!.valorUnitario),
            'descuento': (widget.inicial?.descuento ?? 0) == 0
                ? ''
                : _textoImporte(widget.inicial!.descuento),
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                esNuevo ? 'Agregar ítem' : 'Editar ítem',
                style: textos.titleMedium,
              ),
              const SizedBox(height: Espaciado.md),

              FormBuilderTextField(
                name: 'descripcion',
                autofocus: esNuevo,
                decoration: const InputDecoration(
                  labelText: 'Descripción',
                  hintText: 'Servicio de consultoría',
                  prefixIcon: Icon(Icons.notes_rounded),
                ),
                textCapitalization: TextCapitalization.sentences,
                validator: (valor) => (valor ?? '').trim().isEmpty
                    ? 'Describe el bien o servicio'
                    : null,
              ),
              const SizedBox(height: Espaciado.md),

              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'cantidad',
                      decoration: const InputDecoration(labelText: 'Cantidad'),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [_formatoDecimal],
                      validator: (valor) =>
                          _aNumero(valor) > 0 ? null : 'Debe ser mayor que cero',
                    ),
                  ),
                  const SizedBox(width: Espaciado.sm),
                  Expanded(
                    flex: 2,
                    child: DropdownButtonFormField<UnidadMedida>(
                      initialValue: _unidadMedida,
                      decoration: const InputDecoration(
                        labelText: 'Unidad de medida',
                      ),
                      isExpanded: true,
                      items: [
                        for (final unidad in UnidadMedida.values)
                          DropdownMenuItem(
                            value: unidad,
                            child: Text(
                              unidad.etiqueta,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                      onChanged: (unidad) {
                        if (unidad == null) return;
                        setState(() => _unidadMedida = unidad);
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Espaciado.md),

              FormBuilderTextField(
                name: 'importeUnitario',
                decoration: InputDecoration(
                  labelText: _capturaPrecioConIgv
                      ? 'Precio unitario (con IGV)'
                      : 'Valor unitario (sin IGV)',
                  prefixIcon: const Icon(Icons.sell_outlined),
                ),
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [_formatoDecimal],
                validator: (valor) =>
                    _aNumero(valor) >= 0 ? null : 'No puede ser negativo',
              ),
              // El interruptor sólo tiene sentido cuando la línea lleva IGV.
              if (_afectacion.generaIgv || _afectacion.esGratuitaGravada)
                SwitchListTile(
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  value: _capturaPrecioConIgv,
                  onChanged: (activo) {
                    setState(() {
                      _capturaPrecioConIgv = activo;
                      _vistaPrevia = _calcular();
                    });
                  },
                  title: Text(
                    'Tecleo el precio con IGV incluido',
                    style: textos.bodyMedium,
                  ),
                ),
              const SizedBox(height: Espaciado.xs),

              DropdownButtonFormField<TipoAfectacionIgv>(
                initialValue: _afectacion,
                decoration: const InputDecoration(
                  labelText: 'Afectación del IGV',
                  prefixIcon: Icon(Icons.account_balance_outlined),
                ),
                isExpanded: true,
                items: [
                  for (final afectacion in _afectacionesDisponibles)
                    DropdownMenuItem(
                      value: afectacion,
                      child: Text(
                        afectacion.etiqueta,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                onChanged: (afectacion) {
                  if (afectacion == null) return;
                  setState(() {
                    _afectacion = afectacion;
                    // Sin IGV no hay precio con IGV que teclear.
                    if (!afectacion.generaIgv && !afectacion.esGratuitaGravada) {
                      _capturaPrecioConIgv = false;
                    }
                    _vistaPrevia = _calcular();
                  });
                },
              ),
              const SizedBox(height: Espaciado.md),

              Row(
                children: [
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'codigo',
                      decoration: const InputDecoration(
                        labelText: 'Código (opcional)',
                        prefixIcon: Icon(Icons.qr_code_2_rounded),
                      ),
                      textCapitalization: TextCapitalization.characters,
                    ),
                  ),
                  const SizedBox(width: Espaciado.sm),
                  Expanded(
                    child: FormBuilderTextField(
                      name: 'descuento',
                      decoration: const InputDecoration(
                        labelText: 'Descuento',
                        prefixIcon: Icon(Icons.percent_rounded),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: [_formatoDecimal],
                      validator: (valor) =>
                          _aNumero(valor) >= 0 ? null : 'No puede ser negativo',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Espaciado.md),

              _VistaPreviaLinea(linea: _vistaPrevia),
              const SizedBox(height: Espaciado.md),

              FilledButton.icon(
                onPressed: _confirmar,
                icon: Icon(esNuevo ? Icons.add_rounded : Icons.check_rounded),
                label: Text(esNuevo ? 'Agregar al comprobante' : 'Guardar cambios'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Sólo dígitos con un separador decimal: evita que se cuele un texto que
  /// después haya que adivinar cómo interpretar.
  static final _formatoDecimal =
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'));

  static String _textoCantidad(double valor) =>
      valor == valor.roundToDouble() ? valor.round().toString() : valor.toString();

  static String _textoImporte(double valor) =>
      importeParaSunat(valor, decimales: valor == valor.roundToDouble() ? 2 : 6)
          .replaceFirst(RegExp(r'(\.\d*?)0+$'), r'$1')
          .replaceFirst(RegExp(r'\.$'), '');
}

/// Resumen en vivo de la línea que se está capturando.
class _VistaPreviaLinea extends StatelessWidget {
  const _VistaPreviaLinea({required this.linea});

  final LineaCalculada linea;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;
    final esGratuita = linea.afectacion.esGratuita;

    return Container(
      padding: const EdgeInsets.all(Espaciado.sm),
      decoration: BoxDecoration(
        color: esquema.surfaceContainer,
        borderRadius: BorderRadius.circular(Radios.chico),
      ),
      child: Column(
        children: [
          _fila(context, 'Valor de venta', linea.baseImponible),
          if (linea.descuento > 0)
            _fila(context, 'Descuento aplicado', -linea.descuento),
          _fila(
            context,
            esGratuita ? 'IGV informativo' : 'IGV',
            linea.igv,
          ),
          const Divider(height: Espaciado.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                esGratuita ? 'Entrega gratuita' : 'Total de la línea',
                style: textos.titleSmall,
              ),
              Text(
                formatearImporte(linea.totalLinea),
                style: textos.titleMedium?.copyWith(
                  color: esquema.primary,
                  fontFeatures: const [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
          if (esGratuita)
            Padding(
              padding: const EdgeInsets.only(top: Espaciado.xxs),
              child: Text(
                'No suma al importe total del comprobante.',
                style: textos.bodySmall,
              ),
            ),
        ],
      ),
    );
  }

  Widget _fila(BuildContext context, String etiqueta, double valor) {
    final textos = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(etiqueta, style: textos.bodySmall),
          Text(
            formatearImporte(valor),
            style: textos.bodyMedium?.copyWith(
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
        ],
      ),
    );
  }
}
