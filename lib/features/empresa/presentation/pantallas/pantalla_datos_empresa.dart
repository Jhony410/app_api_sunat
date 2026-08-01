import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/esqueletos.dart';
import '../../../../core/widgets/seccion.dart';
import '../../domain/entidades/empresa.dart';
import '../providers/empresa_providers.dart';
import '../widgets/formulario_empresa.dart';

/// Edición de los datos del emisor una vez pasado el onboarding.
///
/// Reutiliza los mismos bloques de campos que la configuración inicial, pero
/// todos a la vez: aquí el usuario viene a corregir un dato concreto, no a
/// recorrer un asistente.
class PantallaDatosEmpresa extends ConsumerStatefulWidget {
  const PantallaDatosEmpresa({super.key});

  @override
  ConsumerState<PantallaDatosEmpresa> createState() => _PantallaDatosEmpresaState();
}

class _PantallaDatosEmpresaState extends ConsumerState<PantallaDatosEmpresa> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _guardando = false;

  Future<void> _guardar(Empresa? actual) async {
    final estado = _formKey.currentState;
    if (estado == null || !estado.saveAndValidate()) return;

    setState(() => _guardando = true);
    try {
      await ref.read(controladorEmpresaProvider.notifier).guardar(
            empresaDesdeFormulario(estado.value, base: actual),
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Datos del emisor actualizados')),
      );
      Navigator.pop(context);
    } catch (error) {
      if (!mounted) return;
      setState(() => _guardando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo guardar: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final empresa = ref.watch(empresaProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Datos de la empresa')),
      body: switch (empresa) {
        AsyncData(:final value) => FormBuilder(
            key: _formKey,
            initialValue: valoresInicialesEmpresa(value),
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                Espaciado.md,
                0,
                Espaciado.md,
                Espaciado.md,
              ),
              children: const [
                Seccion(
                  titulo: 'Identificación',
                  icono: Icons.badge_outlined,
                  subtitulo: 'Aparece como emisor en cada comprobante.',
                  hijo: CamposIdentificacionEmpresa(),
                ),
                SizedBox(height: Espaciado.sm),
                Seccion(
                  titulo: 'Dirección fiscal',
                  icono: Icons.location_on_outlined,
                  subtitulo: 'Tal como figura en tu ficha RUC.',
                  hijo: CamposDireccionEmpresa(),
                ),
                SizedBox(height: Espaciado.sm),
                Seccion(
                  titulo: 'Series',
                  icono: Icons.tag_rounded,
                  subtitulo:
                      'Quitar una serie no borra los comprobantes ya emitidos con ella.',
                  hijo: CamposSeriesEmpresa(),
                ),
              ],
            ),
          ),
        AsyncError(:final error) => Center(
            child: Padding(
              padding: const EdgeInsets.all(Espaciado.lg),
              child: Text(
                'No se pudieron cargar los datos.\n$error',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        _ => const EsqueletoLista(filas: 5),
      },
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Espaciado.md),
          child: FilledButton.icon(
            onPressed: _guardando || !empresa.hasValue
                ? null
                : () => _guardar(empresa.value),
            icon: _guardando
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
            label: const Text('Guardar cambios'),
          ),
        ),
      ),
    );
  }
}
