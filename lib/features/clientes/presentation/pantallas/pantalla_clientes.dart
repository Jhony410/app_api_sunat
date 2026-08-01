import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/rutas.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/widgets/estado_vacio.dart';
import '../../../../core/widgets/esqueletos.dart';
import '../../domain/entidades/cliente.dart';
import '../providers/clientes_providers.dart';

/// Agenda de clientes con buscador y acceso a la ficha de cada uno.
class PantallaClientes extends ConsumerStatefulWidget {
  const PantallaClientes({this.modoSeleccion = false, super.key});

  /// En modo selección la pantalla se abre desde el formulario de comprobante
  /// y devuelve el cliente elegido en lugar de navegar a su ficha.
  final bool modoSeleccion;

  @override
  ConsumerState<PantallaClientes> createState() => _PantallaClientesState();
}

class _PantallaClientesState extends ConsumerState<PantallaClientes> {
  late final TextEditingController _buscador;

  @override
  void initState() {
    super.initState();
    _buscador = TextEditingController(text: ref.read(busquedaClientesProvider));
  }

  @override
  void dispose() {
    _buscador.dispose();
    super.dispose();
  }

  Future<void> _confirmarEliminacion(Cliente cliente) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('¿Eliminar cliente?'),
        content: Text(
          'Se quitará "${cliente.razonSocialONombres}" de tu agenda. '
          'Los comprobantes ya emitidos a este cliente no se modifican.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );

    if (confirmado == true && cliente.id != null) {
      await ref.read(controladorClientesProvider.notifier).eliminar(cliente.id!);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cliente eliminado')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientes = ref.watch(clientesProvider);
    final busqueda = ref.watch(busquedaClientesProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.modoSeleccion ? 'Elegir cliente' : 'Clientes'),
        leading: widget.modoSeleccion
            ? IconButton(
                icon: const Icon(Icons.close_rounded),
                onPressed: () => Navigator.pop(context),
              )
            : null,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              Espaciado.md,
              0,
              Espaciado.md,
              Espaciado.xs,
            ),
            child: TextField(
              controller: _buscador,
              onChanged: ref.read(busquedaClientesProvider.notifier).cambiar,
              decoration: InputDecoration(
                hintText: 'Buscar por nombre o documento',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: busqueda.isEmpty
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.close_rounded),
                        onPressed: () {
                          _buscador.clear();
                          ref.read(busquedaClientesProvider.notifier).cambiar('');
                        },
                      ),
              ),
            ),
          ),
          Expanded(
            child: switch (clientes) {
              AsyncData(:final value) when value.isEmpty => EstadoVacio(
                  icono: busqueda.isEmpty
                      ? Icons.people_outline_rounded
                      : Icons.person_search_outlined,
                  titulo: busqueda.isEmpty
                      ? 'Tu agenda está vacía'
                      : 'Sin coincidencias',
                  mensaje: busqueda.isEmpty
                      ? 'Guarda a tus clientes frecuentes para no volver a teclear sus datos en cada comprobante.'
                      : 'Ningún cliente coincide con "$busqueda".',
                  etiquetaAccion: busqueda.isEmpty ? 'Agregar cliente' : null,
                  onAccion: busqueda.isEmpty
                      ? () => context.push(Rutas.nuevoCliente)
                      : null,
                ),
              AsyncData(:final value) => ListView.separated(
                  padding: const EdgeInsets.fromLTRB(
                    Espaciado.md,
                    Espaciado.xs,
                    Espaciado.md,
                    Espaciado.xxl + Espaciado.lg,
                  ),
                  itemCount: value.length,
                  separatorBuilder: (_, _) => const SizedBox(height: Espaciado.xs),
                  itemBuilder: (context, indice) {
                    final cliente = value[indice];
                    return _FilaCliente(
                      cliente: cliente,
                      onTap: () {
                        if (widget.modoSeleccion) {
                          Navigator.pop(context, cliente);
                        } else {
                          context.push(Rutas.editarClienteDe(cliente.id!));
                        }
                      },
                      onEliminar: widget.modoSeleccion
                          ? null
                          : () => _confirmarEliminacion(cliente),
                    );
                  },
                ),
              AsyncError(:final error) => Center(
                  child: Padding(
                    padding: const EdgeInsets.all(Espaciado.lg),
                    child: Text('No se pudo cargar la agenda.\n$error',
                        textAlign: TextAlign.center),
                  ),
                ),
              _ => const EsqueletoLista(),
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final creado = await context.push<Cliente>(Rutas.nuevoCliente);
          if (creado != null && widget.modoSeleccion && context.mounted) {
            Navigator.pop(context, creado);
          }
        },
        icon: const Icon(Icons.person_add_alt_1_rounded),
        label: const Text('Nuevo'),
      ),
    );
  }
}

class _FilaCliente extends StatelessWidget {
  const _FilaCliente({
    required this.cliente,
    required this.onTap,
    this.onEliminar,
  });

  final Cliente cliente;
  final VoidCallback onTap;
  final VoidCallback? onEliminar;

  @override
  Widget build(BuildContext context) {
    final esquema = Theme.of(context).colorScheme;
    final textos = Theme.of(context).textTheme;

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(Radios.medio),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(Espaciado.sm),
          child: Row(
            children: [
              CircleAvatar(
                radius: 21,
                backgroundColor: esquema.primaryContainer,
                child: Text(
                  cliente.iniciales,
                  style: textos.titleSmall
                      ?.copyWith(color: esquema.onPrimaryContainer),
                ),
              ),
              const SizedBox(width: Espaciado.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cliente.razonSocialONombres,
                      style: textos.titleSmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      cliente.documentoFormateado,
                      style: textos.bodySmall,
                    ),
                  ],
                ),
              ),
              if (onEliminar != null)
                IconButton(
                  tooltip: 'Eliminar cliente',
                  icon: const Icon(Icons.delete_outline_rounded),
                  onPressed: onEliminar,
                )
              else
                const Icon(Icons.chevron_right_rounded),
            ],
          ),
        ),
      ),
    );
  }
}
