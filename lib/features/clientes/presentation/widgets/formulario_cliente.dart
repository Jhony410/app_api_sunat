import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/validadores_documento.dart';
import '../../domain/entidades/cliente.dart';

/// Formulario reutilizable de cliente.
///
/// Se usa en la pantalla de ficha y también dentro del formulario de
/// comprobante, por eso expone su estado ([EstadoFormularioCliente]) en lugar
/// de guardar por su cuenta.
class FormularioCliente extends StatefulWidget {
  const FormularioCliente({
    this.inicial,
    this.soloRuc = false,
    this.accionConsulta,
    super.key,
  });

  final Cliente? inicial;

  /// Fuerza el tipo de documento a RUC (necesario al emitir una factura).
  final bool soloRuc;

  /// Botón "Consultar" que se inyecta desde la Fase 2.
  final Widget Function(BuildContext context, EstadoFormularioCliente estado)?
      accionConsulta;

  @override
  State<FormularioCliente> createState() => EstadoFormularioCliente();
}

class EstadoFormularioCliente extends State<FormularioCliente> {
  final _formKey = GlobalKey<FormBuilderState>();

  late TipoDocumentoIdentidad _tipoDocumento =
      widget.soloRuc ? TipoDocumentoIdentidad.ruc
          : (widget.inicial?.tipoDocumento ?? TipoDocumentoIdentidad.dni);

  /// Tipo de documento seleccionado ahora mismo.
  TipoDocumentoIdentidad get tipoDocumento => _tipoDocumento;

  /// Número tecleado, aunque el formulario todavía no sea válido.
  String get numeroDocumento =>
      (_formKey.currentState?.fields['numeroDocumento']?.value as String? ?? '').trim();

  /// Valida y devuelve el cliente, o `null` si hay errores.
  Cliente? leerSiEsValido() {
    final estado = _formKey.currentState;
    if (estado == null || !estado.saveAndValidate()) return null;

    final valores = estado.value;
    String? texto(String clave) {
      final valor = (valores[clave] as String? ?? '').trim();
      return valor.isEmpty ? null : valor;
    }

    return Cliente(
      id: widget.inicial?.id,
      tipoDocumento: _tipoDocumento,
      numeroDocumento: (valores['numeroDocumento'] as String? ?? '').trim(),
      razonSocialONombres: (valores['razonSocial'] as String? ?? '').trim(),
      direccion: texto('direccion'),
      telefono: texto('telefono'),
      email: texto('email'),
    );
  }

  /// Rellena los campos con lo que devolvió la consulta de RUC/DNI.
  void autocompletar({
    required String razonSocial,
    String? direccion,
  }) {
    _formKey.currentState?.patchValue({
      'razonSocial': razonSocial,
      if (direccion != null && direccion.isNotEmpty) 'direccion': direccion,
    });
  }

  @override
  Widget build(BuildContext context) {
    final tiposDisponibles = widget.soloRuc
        ? [TipoDocumentoIdentidad.ruc]
        : TipoDocumentoIdentidad.values;

    return FormBuilder(
      key: _formKey,
      initialValue: {
        'numeroDocumento': widget.inicial?.numeroDocumento ?? '',
        'razonSocial': widget.inicial?.razonSocialONombres ?? '',
        'direccion': widget.inicial?.direccion ?? '',
        'telefono': widget.inicial?.telefono ?? '',
        'email': widget.inicial?.email ?? '',
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Selector de tipo de documento como segmentos, no como desplegable:
          // son pocas opciones y se eligen de un toque.
          if (tiposDisponibles.length > 1)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  for (final tipo in tiposDisponibles)
                    Padding(
                      padding: const EdgeInsets.only(right: Espaciado.xs),
                      child: ChoiceChip(
                        label: Text(tipo.etiqueta),
                        selected: _tipoDocumento == tipo,
                        showCheckmark: false,
                        onSelected: (_) => setState(() => _tipoDocumento = tipo),
                      ),
                    ),
                ],
              ),
            ),
          if (tiposDisponibles.length > 1) const SizedBox(height: Espaciado.md),

          FormBuilderTextField(
            name: 'numeroDocumento',
            decoration: InputDecoration(
              labelText: 'N.º de ${_tipoDocumento.etiqueta}',
              prefixIcon: const Icon(Icons.badge_outlined),
              suffixIcon: widget.accionConsulta?.call(context, this),
              counterText: '',
            ),
            keyboardType: _tipoDocumento == TipoDocumentoIdentidad.ruc ||
                    _tipoDocumento == TipoDocumentoIdentidad.dni
                ? TextInputType.number
                : TextInputType.text,
            maxLength: _tipoDocumento.longitudMaxima,
            inputFormatters: _tipoDocumento == TipoDocumentoIdentidad.ruc ||
                    _tipoDocumento == TipoDocumentoIdentidad.dni
                ? [FilteringTextInputFormatter.digitsOnly]
                : null,
            validator: (valor) => mensajeErrorDocumento(_tipoDocumento, valor),
          ),
          const SizedBox(height: Espaciado.md),

          FormBuilderTextField(
            name: 'razonSocial',
            decoration: InputDecoration(
              labelText: _tipoDocumento == TipoDocumentoIdentidad.ruc
                  ? 'Razón social'
                  : 'Nombres y apellidos',
              prefixIcon: const Icon(Icons.person_outline_rounded),
            ),
            textCapitalization: TextCapitalization.characters,
            validator: FormBuilderValidators.required(
              errorText: 'Este dato es obligatorio',
            ),
          ),
          const SizedBox(height: Espaciado.md),

          FormBuilderTextField(
            name: 'direccion',
            decoration: const InputDecoration(
              labelText: 'Dirección (opcional)',
              prefixIcon: Icon(Icons.location_on_outlined),
            ),
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: Espaciado.md),

          Row(
            children: [
              Expanded(
                child: FormBuilderTextField(
                  name: 'telefono',
                  decoration: const InputDecoration(
                    labelText: 'Teléfono',
                    prefixIcon: Icon(Icons.phone_outlined),
                  ),
                  keyboardType: TextInputType.phone,
                ),
              ),
              const SizedBox(width: Espaciado.sm),
              Expanded(
                child: FormBuilderTextField(
                  name: 'email',
                  decoration: const InputDecoration(
                    labelText: 'Correo',
                    prefixIcon: Icon(Icons.alternate_email_rounded),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: FormBuilderValidators.compose([
                    (valor) => (valor == null || valor.trim().isEmpty)
                        ? null
                        : FormBuilderValidators.email(
                            errorText: 'Correo inválido',
                          )(valor),
                  ]),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
