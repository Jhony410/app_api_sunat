import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/database/tablas.dart';
import '../../../../core/providers/nucleo_providers.dart';
import '../../data/ajustes_repositorio.dart';
import '../../domain/entidades/ajustes.dart';

part 'ajustes_providers.g.dart';

@Riverpod(keepAlive: true)
AjustesRepositorio ajustesRepositorio(Ref ref) =>
    AjustesRepositorio(ref.watch(appDatabaseProvider));

/// Configuración vigente. Se re-emite sola cuando cambia cualquier ajuste.
@Riverpod(keepAlive: true)
Stream<Ajustes> ajustes(Ref ref) =>
    ref.watch(ajustesRepositorioProvider).observar();

/// Tema elegido por el usuario, con `system` mientras carga la configuración.
@Riverpod(keepAlive: true)
ThemeMode modoTema(Ref ref) =>
    ref.watch(ajustesProvider).value?.temaApp ?? ThemeMode.system;

/// Acciones sobre la configuración.
@riverpod
class ControladorAjustes extends _$ControladorAjustes {
  @override
  void build() {}

  AjustesRepositorio get _repo => ref.read(ajustesRepositorioProvider);

  Future<void> cambiarTema(ThemeMode modo) =>
      _repo.guardarValor(ClavesAjuste.temaApp, modo.name);

  Future<void> cambiarModoOperacion(ModoOperacion modo) =>
      _repo.guardarValor(ClavesAjuste.modoOperacion, modo.name);

  Future<void> guardarConexionLycet({required String url, required String token}) async {
    await _repo.guardarValor(ClavesAjuste.lycetUrl, url.trim());
    await _repo.guardarValor(ClavesAjuste.lycetToken, token.trim());
  }

  Future<void> guardarConsultaDocumentos({
    required String proveedor,
    required String token,
  }) async {
    await _repo.guardarValor(ClavesAjuste.proveedorConsulta, proveedor.trim());
    await _repo.guardarValor(ClavesAjuste.tokenConsulta, token.trim());
  }
}
