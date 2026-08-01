import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/nucleo_providers.dart';
import '../../data/empresa_repositorio.dart';
import '../../domain/entidades/empresa.dart';

part 'empresa_providers.g.dart';

@Riverpod(keepAlive: true)
EmpresaRepositorio empresaRepositorio(Ref ref) =>
    EmpresaRepositorio(ref.watch(appDatabaseProvider));

/// Empresa emisora configurada, o `null` si aún no se completó el onboarding.
@Riverpod(keepAlive: true)
Stream<Empresa?> empresa(Ref ref) =>
    ref.watch(empresaRepositorioProvider).observar();

/// `true` mientras falte configurar el emisor: el router lo usa para forzar
/// el onboarding antes de dejar entrar a cualquier otra pantalla.
@Riverpod(keepAlive: true)
bool requiereConfiguracionInicial(Ref ref) {
  final estado = ref.watch(empresaProvider);
  // Mientras carga no se redirige a ningún lado, para no parpadear.
  if (!estado.hasValue) return false;
  final empresa = estado.value;
  return empresa == null || !empresa.estaConfigurada;
}

@riverpod
class ControladorEmpresa extends _$ControladorEmpresa {
  @override
  void build() {}

  Future<void> guardar(Empresa empresa) =>
      ref.read(empresaRepositorioProvider).guardar(empresa);
}
