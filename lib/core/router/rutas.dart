/// Nombres y rutas de la aplicación en un solo lugar, para no repartir cadenas
/// mágicas por las pantallas.
abstract final class Rutas {
  static const onboarding = '/configuracion-inicial';

  static const inicio = '/';
  static const historial = '/historial';
  static const clientes = '/clientes';
  static const configuracion = '/configuracion';

  static const nuevoComprobante = '/comprobantes/nuevo';
  static const detalleComprobante = '/comprobantes/:id';
  static const nuevoCliente = '/clientes/nuevo';
  static const editarCliente = '/clientes/:id';
  static const consultaDocumento = '/consulta';

  /// Edición del emisor desde Configuración (el onboarding usa su propia ruta).
  static const datosEmpresa = '/configuracion/empresa';

  static String detalleDe(int id) => '/comprobantes/$id';
  static String editarClienteDe(int id) => '/clientes/$id';
}

/// Nombres simbólicos de las rutas (`context.goNamed`).
abstract final class NombresRuta {
  static const onboarding = 'onboarding';
  static const inicio = 'inicio';
  static const historial = 'historial';
  static const clientes = 'clientes';
  static const configuracion = 'configuracion';
  static const nuevoComprobante = 'nuevoComprobante';
  static const detalleComprobante = 'detalleComprobante';
  static const nuevoCliente = 'nuevoCliente';
  static const editarCliente = 'editarCliente';
  static const consultaDocumento = 'consultaDocumento';
  static const datosEmpresa = 'datosEmpresa';
}
