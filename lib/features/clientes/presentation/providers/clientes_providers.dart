import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/nucleo_providers.dart';
import '../../data/cliente_repositorio.dart';
import '../../domain/entidades/cliente.dart';

part 'clientes_providers.g.dart';

@Riverpod(keepAlive: true)
ClienteRepositorio clienteRepositorio(Ref ref) =>
    ClienteRepositorio(ref.watch(appDatabaseProvider));

/// Texto del buscador de la pantalla de clientes.
@riverpod
class BusquedaClientes extends _$BusquedaClientes {
  @override
  String build() => '';

  void cambiar(String texto) => state = texto;
}

/// Clientes que coinciden con la búsqueda activa.
@riverpod
Stream<List<Cliente>> clientes(Ref ref) {
  final texto = ref.watch(busquedaClientesProvider);
  return ref.watch(clienteRepositorioProvider).observar(texto: texto);
}

@riverpod
Future<int> totalClientes(Ref ref) {
  // Se vuelve a contar cada vez que cambia el listado.
  ref.watch(clientesProvider);
  return ref.watch(clienteRepositorioProvider).contar();
}

@riverpod
class ControladorClientes extends _$ControladorClientes {
  @override
  void build() {}

  Future<int> guardar(Cliente cliente) =>
      ref.read(clienteRepositorioProvider).guardar(cliente);

  Future<void> eliminar(int id) =>
      ref.read(clienteRepositorioProvider).eliminar(id);
}
