import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/rutas.dart';
import '../../../../core/theme/app_theme.dart';
import '../providers/empresa_providers.dart';
import '../widgets/formulario_empresa.dart';

/// Configuración inicial: captura los datos del emisor la primera vez que se
/// abre la app, en tres pasos cortos para no enfrentar al usuario con un
/// formulario de veinte campos.
class PantallaOnboarding extends ConsumerStatefulWidget {
  const PantallaOnboarding({super.key});

  @override
  ConsumerState<PantallaOnboarding> createState() => _PantallaOnboardingState();
}

class _PantallaOnboardingState extends ConsumerState<PantallaOnboarding> {
  final _formKey = GlobalKey<FormBuilderState>();
  final _controladorPaginas = PageController();

  int _paso = 0;
  bool _guardando = false;

  static const _pasos = [
    (
      titulo: 'Tu empresa',
      descripcion: 'Estos datos aparecerán como emisor en cada comprobante.',
      icono: Icons.apartment_rounded,
    ),
    (
      titulo: 'Dirección fiscal',
      descripcion: 'La dirección declarada ante SUNAT, tal como figura en tu ficha RUC.',
      icono: Icons.location_on_rounded,
    ),
    (
      titulo: 'Series',
      descripcion: 'Las series con las que numerarás tus facturas y boletas.',
      icono: Icons.tag_rounded,
    ),
  ];

  @override
  void dispose() {
    _controladorPaginas.dispose();
    super.dispose();
  }

  /// Campos que deben ser válidos para poder avanzar desde cada paso.
  static const _camposPorPaso = [
    ['ruc', 'razonSocial', 'nombreComercial'],
    ['direccion', 'ubigeo', 'departamento', 'provincia', 'distrito'],
    ['seriesFactura', 'seriesBoleta'],
  ];

  bool _pasoActualEsValido() {
    final estado = _formKey.currentState;
    if (estado == null) return false;

    var valido = true;
    for (final campo in _camposPorPaso[_paso]) {
      final control = estado.fields[campo];
      if (control != null && !control.validate()) valido = false;
    }
    return valido;
  }

  Future<void> _avanzar() async {
    if (!_pasoActualEsValido()) return;

    if (_paso < _pasos.length - 1) {
      setState(() => _paso++);
      await _controladorPaginas.animateToPage(
        _paso,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
      return;
    }

    await _guardar();
  }

  Future<void> _retroceder() async {
    if (_paso == 0) return;
    setState(() => _paso--);
    await _controladorPaginas.animateToPage(
      _paso,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOutCubic,
    );
  }

  Future<void> _guardar() async {
    final estado = _formKey.currentState;
    if (estado == null || !estado.saveAndValidate()) return;

    setState(() => _guardando = true);
    try {
      await ref
          .read(controladorEmpresaProvider.notifier)
          .guardar(empresaDesdeFormulario(estado.value));
      if (mounted) context.go(Rutas.inicio);
    } catch (error) {
      if (!mounted) return;
      setState(() => _guardando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo guardar la configuración: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;
    final pasoActual = _pasos[_paso];
    final esUltimo = _paso == _pasos.length - 1;

    return Scaffold(
      body: SafeArea(
        child: FormBuilder(
          key: _formKey,
          initialValue: valoresInicialesEmpresa(null),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  Espaciado.lg,
                  Espaciado.lg,
                  Espaciado.lg,
                  Espaciado.md,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(Espaciado.sm),
                          decoration: BoxDecoration(
                            color: esquema.primaryContainer,
                            borderRadius: BorderRadius.circular(Radios.chico),
                          ),
                          child: Icon(
                            pasoActual.icono,
                            color: esquema.onPrimaryContainer,
                          ),
                        ),
                        const SizedBox(width: Espaciado.sm),
                        Text(
                          'Paso ${_paso + 1} de ${_pasos.length}',
                          style: textos.labelMedium
                              ?.copyWith(color: esquema.onSurfaceVariant),
                        ),
                      ],
                    ),
                    const SizedBox(height: Espaciado.md),
                    Text(pasoActual.titulo, style: textos.headlineMedium),
                    const SizedBox(height: Espaciado.xxs),
                    Text(
                      pasoActual.descripcion,
                      style: textos.bodyMedium
                          ?.copyWith(color: esquema.onSurfaceVariant),
                    ),
                    const SizedBox(height: Espaciado.md),
                    // Barra de progreso segmentada, un tramo por paso.
                    Row(
                      children: List.generate(_pasos.length, (indice) {
                        final completado = indice <= _paso;
                        return Expanded(
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 280),
                            height: 4,
                            margin: EdgeInsets.only(
                              right: indice == _pasos.length - 1 ? 0 : Espaciado.xxs,
                            ),
                            decoration: BoxDecoration(
                              color: completado
                                  ? esquema.primary
                                  : esquema.surfaceContainerHighest,
                              borderRadius: BorderRadius.circular(Radios.completo),
                            ),
                          ),
                        );
                      }),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  controller: _controladorPaginas,
                  physics: const NeverScrollableScrollPhysics(),
                  children: const [
                    _PaginaPaso(child: CamposIdentificacionEmpresa()),
                    _PaginaPaso(child: CamposDireccionEmpresa()),
                    _PaginaPaso(child: CamposSeriesEmpresa()),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(Espaciado.lg),
                child: Row(
                  children: [
                    if (_paso > 0)
                      Expanded(
                        child: OutlinedButton(
                          onPressed: _guardando ? null : _retroceder,
                          child: const Text('Atrás'),
                        ),
                      ),
                    if (_paso > 0) const SizedBox(width: Espaciado.sm),
                    Expanded(
                      flex: 2,
                      child: FilledButton(
                        onPressed: _guardando ? null : _avanzar,
                        child: _guardando
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : Text(esUltimo ? 'Empezar a facturar' : 'Continuar'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PaginaPaso extends StatelessWidget {
  const _PaginaPaso({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: Espaciado.lg),
      child: child,
    );
  }
}
