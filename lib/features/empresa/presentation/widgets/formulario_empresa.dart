import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../../../../core/constantes/catalogos_sunat.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/validadores_documento.dart';
import '../../domain/entidades/empresa.dart';

/// Campos de identificación del emisor (RUC, razón social, nombre comercial).
class CamposIdentificacionEmpresa extends StatelessWidget {
  const CamposIdentificacionEmpresa({this.accionConsultaRuc, super.key});

  /// Botón "Consultar" que aparece junto al RUC. Se inyecta desde fuera para
  /// que este formulario no dependa de la Fase 2.
  final Widget? accionConsultaRuc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormBuilderTextField(
          name: 'ruc',
          decoration: InputDecoration(
            labelText: 'RUC',
            // El ejemplo tiene que superar el módulo 11: si el usuario lo copia
            // tal cual, el campo no puede rechazárselo.
            hintText: '20123456786',
            prefixIcon: const Icon(Icons.badge_outlined),
            suffixIcon: accionConsultaRuc,
            counterText: '',
          ),
          keyboardType: TextInputType.number,
          maxLength: 11,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (valor) {
            final limpio = (valor ?? '').trim();
            if (limpio.isEmpty) return 'Ingresa el RUC de tu empresa';
            if (!rucEsValido(limpio)) {
              return 'RUC inválido: revisa los 11 dígitos y el dígito verificador';
            }
            return null;
          },
        ),
        const SizedBox(height: Espaciado.md),
        FormBuilderTextField(
          name: 'razonSocial',
          decoration: const InputDecoration(
            labelText: 'Razón social',
            hintText: 'MI EMPRESA S.A.C.',
            prefixIcon: Icon(Icons.business_outlined),
          ),
          textCapitalization: TextCapitalization.characters,
          validator: FormBuilderValidators.required(
            errorText: 'La razón social es obligatoria',
          ),
        ),
        const SizedBox(height: Espaciado.md),
        FormBuilderTextField(
          name: 'nombreComercial',
          decoration: const InputDecoration(
            labelText: 'Nombre comercial (opcional)',
            hintText: 'Cómo te conocen tus clientes',
            prefixIcon: Icon(Icons.storefront_outlined),
          ),
          textCapitalization: TextCapitalization.characters,
        ),
      ],
    );
  }
}

/// Campos de la dirección fiscal declarada ante SUNAT.
class CamposDireccionEmpresa extends StatelessWidget {
  const CamposDireccionEmpresa({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormBuilderTextField(
          name: 'direccion',
          decoration: const InputDecoration(
            labelText: 'Dirección fiscal',
            hintText: 'Av. Siempre Viva 742',
            prefixIcon: Icon(Icons.location_on_outlined),
          ),
          textCapitalization: TextCapitalization.characters,
          validator: FormBuilderValidators.required(
            errorText: 'La dirección fiscal es obligatoria',
          ),
        ),
        const SizedBox(height: Espaciado.md),
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                name: 'ubigeo',
                decoration: const InputDecoration(
                  labelText: 'Ubigeo',
                  hintText: '150101',
                  counterText: '',
                  helperText: 'Código INEI',
                ),
                keyboardType: TextInputType.number,
                maxLength: 6,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (valor) {
                  final limpio = (valor ?? '').trim();
                  if (limpio.isEmpty) return null;
                  return limpio.length == 6 ? null : 'El ubigeo tiene 6 dígitos';
                },
              ),
            ),
            const SizedBox(width: Espaciado.sm),
            Expanded(
              flex: 2,
              child: FormBuilderTextField(
                name: 'departamento',
                decoration: const InputDecoration(labelText: 'Departamento'),
                textCapitalization: TextCapitalization.characters,
              ),
            ),
          ],
        ),
        const SizedBox(height: Espaciado.md),
        Row(
          children: [
            Expanded(
              child: FormBuilderTextField(
                name: 'provincia',
                decoration: const InputDecoration(labelText: 'Provincia'),
                textCapitalization: TextCapitalization.characters,
              ),
            ),
            const SizedBox(width: Espaciado.sm),
            Expanded(
              child: FormBuilderTextField(
                name: 'distrito',
                decoration: const InputDecoration(labelText: 'Distrito'),
                textCapitalization: TextCapitalization.characters,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Campos de series habilitadas, una por tipo de comprobante.
class CamposSeriesEmpresa extends StatelessWidget {
  const CamposSeriesEmpresa({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        FormBuilderTextField(
          name: 'seriesFactura',
          decoration: const InputDecoration(
            labelText: 'Series de factura',
            hintText: 'F001, F002',
            prefixIcon: Icon(Icons.receipt_long_outlined),
            helperText: 'Separa varias series con comas. Empiezan con F.',
          ),
          textCapitalization: TextCapitalization.characters,
          validator: (valor) => _validarSeries(valor, TipoComprobante.factura),
        ),
        const SizedBox(height: Espaciado.md),
        FormBuilderTextField(
          name: 'seriesBoleta',
          decoration: const InputDecoration(
            labelText: 'Series de boleta',
            hintText: 'B001, B002',
            prefixIcon: Icon(Icons.receipt_outlined),
            helperText: 'Separa varias series con comas. Empiezan con B.',
          ),
          textCapitalization: TextCapitalization.characters,
          validator: (valor) => _validarSeries(valor, TipoComprobante.boleta),
        ),
      ],
    );
  }

  static String? _validarSeries(String? valor, TipoComprobante tipo) {
    final series = parsearSeries(valor);
    if (series.isEmpty) {
      return 'Declara al menos una serie de ${tipo.etiqueta.toLowerCase()}';
    }
    final invalidas = series.where((s) => !serieEsValida(s, tipo)).toList();
    if (invalidas.isNotEmpty) {
      return 'Serie inválida: ${invalidas.join(', ')}. '
          'Debe ser ${tipo.prefijoSerie} más tres dígitos.';
    }
    return null;
  }
}

/// Convierte `"F001, f002"` en `['F001', 'F002']`, sin vacíos ni repetidos.
List<String> parsearSeries(String? texto) {
  final series = (texto ?? '')
      .toUpperCase()
      .split(RegExp(r'[,;\s]+'))
      .map((s) => s.trim())
      .where((s) => s.isNotEmpty);
  return {...series}.toList();
}

/// Valores iniciales del formulario a partir de una empresa ya guardada.
Map<String, dynamic> valoresInicialesEmpresa(Empresa? empresa) => {
      'ruc': empresa?.ruc ?? '',
      'razonSocial': empresa?.razonSocial ?? '',
      'nombreComercial': empresa?.nombreComercial ?? '',
      'direccion': empresa?.direccion ?? '',
      'ubigeo': empresa?.ubigeo ?? '',
      'departamento': empresa?.departamento ?? '',
      'provincia': empresa?.provincia ?? '',
      'distrito': empresa?.distrito ?? '',
      'seriesFactura': (empresa?.seriesFactura ?? const ['F001']).join(', '),
      'seriesBoleta': (empresa?.seriesBoleta ?? const ['B001']).join(', '),
    };

/// Construye la entidad a partir de los valores del formulario.
Empresa empresaDesdeFormulario(Map<String, dynamic> valores, {Empresa? base}) {
  String texto(String clave) => (valores[clave] as String? ?? '').trim();

  return (base ?? const Empresa(ruc: '', razonSocial: '')).copyWith(
    ruc: texto('ruc'),
    razonSocial: texto('razonSocial'),
    nombreComercial: texto('nombreComercial'),
    direccion: texto('direccion'),
    ubigeo: texto('ubigeo'),
    departamento: texto('departamento'),
    provincia: texto('provincia'),
    distrito: texto('distrito'),
    seriesFactura: parsearSeries(texto('seriesFactura')),
    seriesBoleta: parsearSeries(texto('seriesBoleta')),
  );
}
