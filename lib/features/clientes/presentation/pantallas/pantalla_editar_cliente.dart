import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_theme.dart';
import '../../domain/entidades/cliente.dart';
import '../providers/clientes_providers.dart';
import '../widgets/formulario_cliente.dart';

/// Alta y edición de una ficha de cliente.
///
/// Al guardar devuelve el [Cliente] resultante con `Navigator.pop`, para que
/// quien la abrió desde el formulario de comprobante pueda usarlo de inmediato.
class PantallaEditarCliente extends ConsumerStatefulWidget {
  const PantallaEditarCliente({this.clienteId, super.key});

  /// `null` para crear uno nuevo.
  final int? clienteId;

  @override
  ConsumerState<PantallaEditarCliente> createState() => _PantallaEditarClienteState();
}

class _PantallaEditarClienteState extends ConsumerState<PantallaEditarCliente> {
  final _claveFormulario = GlobalKey<EstadoFormularioCliente>();

  Cliente? _clienteCargado;
  bool _cargando = true;
  bool _guardando = false;

  @override
  void initState() {
    super.initState();
    _cargar();
  }

  Future<void> _cargar() async {
    if (widget.clienteId == null) {
      setState(() => _cargando = false);
      return;
    }

    final cliente =
        await ref.read(clienteRepositorioProvider).obtenerPorId(widget.clienteId!);
    if (!mounted) return;
    setState(() {
      _clienteCargado = cliente;
      _cargando = false;
    });
  }

  Future<void> _guardar() async {
    final cliente = _claveFormulario.currentState?.leerSiEsValido();
    if (cliente == null) return;

    setState(() => _guardando = true);
    try {
      final id = await ref.read(controladorClientesProvider.notifier).guardar(cliente);
      if (!mounted) return;
      Navigator.pop(context, cliente.copyWith(id: id));
    } catch (error) {
      if (!mounted) return;
      setState(() => _guardando = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('No se pudo guardar el cliente: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final esNuevo = widget.clienteId == null;

    return Scaffold(
      appBar: AppBar(title: Text(esNuevo ? 'Nuevo cliente' : 'Editar cliente')),
      body: _cargando
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(Espaciado.md),
              child: FormularioCliente(
                key: _claveFormulario,
                inicial: _clienteCargado,
              ),
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Espaciado.md),
          child: FilledButton.icon(
            onPressed: _cargando || _guardando ? null : _guardar,
            icon: _guardando
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.save_outlined),
            label: Text(esNuevo ? 'Guardar cliente' : 'Guardar cambios'),
          ),
        ),
      ),
    );
  }
}
