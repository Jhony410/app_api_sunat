/// Catálogos oficiales de SUNAT usados por la aplicación.
///
/// Las referencias corresponden a los anexos del Reglamento de Comprobantes de
/// Pago electrónicos (UBL 2.1). Sólo se modelan los catálogos que la app
/// necesita; cada `enum` guarda el código literal que viaja en el XML.
library;

/// Tasa vigente del IGV en Perú (18 % = 16 % IGV + 2 % IPM).
const double kTasaIgv = 0.18;

/// Cantidad de decimales con la que se expresan los importes en el XML.
const int kDecimalesImporte = 2;

/// Catálogo N.° 01 — Tipo de documento (comprobante de pago).
enum TipoComprobante {
  factura('01', 'Factura', 'FACTURA ELECTRÓNICA', 'F'),
  boleta('03', 'Boleta de venta', 'BOLETA DE VENTA ELECTRÓNICA', 'B'),
  notaCredito('07', 'Nota de crédito', 'NOTA DE CRÉDITO ELECTRÓNICA', 'F'),
  notaDebito('08', 'Nota de débito', 'NOTA DE DÉBITO ELECTRÓNICA', 'F');

  const TipoComprobante(this.codigo, this.etiqueta, this.tituloRide, this.prefijoSerie);

  /// Código SUNAT de dos dígitos (`cbc:InvoiceTypeCode`).
  final String codigo;

  /// Nombre corto para listas y filtros.
  final String etiqueta;

  /// Encabezado que se imprime en la representación impresa (RIDE).
  final String tituloRide;

  /// Letra inicial que deben tener las series de este tipo.
  final String prefijoSerie;

  static TipoComprobante desdeCodigo(String codigo) => TipoComprobante.values
      .firstWhere((t) => t.codigo == codigo, orElse: () => TipoComprobante.factura);
}

/// Catálogo N.° 06 — Tipo de documento de identidad del receptor.
enum TipoDocumentoIdentidad {
  dni('1', 'DNI', 8),
  carnetExtranjeria('4', 'Carnet de extranjería', 12),
  ruc('6', 'RUC', 11),
  pasaporte('7', 'Pasaporte', 12),
  sinDocumento('0', 'Sin documento', 15);

  const TipoDocumentoIdentidad(this.codigo, this.etiqueta, this.longitudMaxima);

  final String codigo;
  final String etiqueta;
  final int longitudMaxima;

  static TipoDocumentoIdentidad desdeCodigo(String codigo) =>
      TipoDocumentoIdentidad.values.firstWhere(
        (t) => t.codigo == codigo,
        orElse: () => TipoDocumentoIdentidad.dni,
      );
}

/// Catálogo N.° 07 — Tipo de afectación del IGV.
///
/// El `grupo` determina en qué casilla de los totales acumula la línea y el
/// `codigoTributo` / `nombreTributo` son los que se escriben en `cac:TaxScheme`.
enum TipoAfectacionIgv {
  gravado('10', 'Gravado - Operación onerosa', GrupoAfectacion.gravado),
  gravadoRetiroPremio('11', 'Gravado - Retiro por premio', GrupoAfectacion.gratuito),
  gravadoRetiroDonacion('12', 'Gravado - Retiro por donación', GrupoAfectacion.gratuito),
  gravadoRetiro('13', 'Gravado - Retiro', GrupoAfectacion.gratuito),
  gravadoRetiroPublicidad('14', 'Gravado - Retiro por publicidad', GrupoAfectacion.gratuito),
  gravadoBonificacion('15', 'Gravado - Bonificación', GrupoAfectacion.gratuito),
  gravadoRetiroTrabajadores('16', 'Gravado - Retiro por entrega a trabajadores', GrupoAfectacion.gratuito),
  exonerado('20', 'Exonerado - Operación onerosa', GrupoAfectacion.exonerado),
  exoneradoTransferenciaGratuita('21', 'Exonerado - Transferencia gratuita', GrupoAfectacion.gratuito),
  inafecto('30', 'Inafecto - Operación onerosa', GrupoAfectacion.inafecto),
  inafectoRetiroBonificacion('31', 'Inafecto - Retiro por bonificación', GrupoAfectacion.gratuito),
  inafectoRetiro('32', 'Inafecto - Retiro', GrupoAfectacion.gratuito),
  inafectoMuestrasMedicas('33', 'Inafecto - Retiro por muestras médicas', GrupoAfectacion.gratuito),
  inafectoConvenioColectivo('34', 'Inafecto - Retiro por convenio colectivo', GrupoAfectacion.gratuito),
  inafectoRetiroPremio('35', 'Inafecto - Retiro por premio', GrupoAfectacion.gratuito),
  inafectoRetiroPublicidad('36', 'Inafecto - Retiro por publicidad', GrupoAfectacion.gratuito),
  inafectoTransferenciaGratuita('37', 'Inafecto - Transferencia gratuita', GrupoAfectacion.gratuito),
  exportacion('40', 'Exportación de bienes o servicios', GrupoAfectacion.exportacion);

  const TipoAfectacionIgv(this.codigo, this.etiqueta, this.grupo);

  final String codigo;
  final String etiqueta;
  final GrupoAfectacion grupo;

  /// `true` cuando la línea genera IGV a pagar por el adquiriente.
  bool get generaIgv => grupo == GrupoAfectacion.gravado;

  /// `true` para entregas a título gratuito (no forman parte del importe total).
  bool get esGratuita => grupo == GrupoAfectacion.gratuito;

  /// Entrega gratuita cuya operación de fondo sí está gravada (códigos 11 al 16).
  ///
  /// Sobre estas se calcula un IGV que SUNAT exige informar, pero que no se
  /// cobra al adquiriente ni suma al importe total del comprobante.
  bool get esGratuitaGravada => esGratuita && codigo.startsWith('1');

  /// Código del tributo en `cac:TaxScheme/cbc:ID` (catálogo N.° 05).
  String get codigoTributo => switch (grupo) {
        GrupoAfectacion.gravado => '1000',
        GrupoAfectacion.exonerado => '9997',
        GrupoAfectacion.inafecto => '9998',
        GrupoAfectacion.exportacion => '9995',
        GrupoAfectacion.gratuito => '9996',
      };

  /// Nombre del tributo en `cac:TaxScheme/cbc:Name`.
  String get nombreTributo => switch (grupo) {
        GrupoAfectacion.gravado => 'IGV',
        GrupoAfectacion.exonerado => 'EXO',
        GrupoAfectacion.inafecto => 'INA',
        GrupoAfectacion.exportacion => 'EXP',
        GrupoAfectacion.gratuito => 'GRA',
      };

  /// Código internacional del tipo de tributo (`cbc:TaxTypeCode`).
  String get tipoTributo =>
      grupo == GrupoAfectacion.gravado || grupo == GrupoAfectacion.exonerado ? 'VAT' : 'FRE';

  /// Categoría UN/ECE 5305 usada en `cac:TaxCategory/cbc:ID`.
  String get categoriaUnece => switch (grupo) {
        GrupoAfectacion.gravado => 'S',
        GrupoAfectacion.exonerado => 'E',
        GrupoAfectacion.inafecto => 'O',
        GrupoAfectacion.exportacion => 'Z',
        GrupoAfectacion.gratuito => 'Z',
      };

  static TipoAfectacionIgv desdeCodigo(String codigo) => TipoAfectacionIgv.values
      .firstWhere((t) => t.codigo == codigo, orElse: () => TipoAfectacionIgv.gravado);

  /// Opciones que se ofrecen en el formulario de ítems (las más habituales).
  static const List<TipoAfectacionIgv> opcionesFrecuentes = [
    gravado,
    exonerado,
    inafecto,
    exportacion,
    gravadoBonificacion,
  ];
}

/// Agrupación de la afectación para el cálculo de totales.
enum GrupoAfectacion { gravado, exonerado, inafecto, exportacion, gratuito }

/// Catálogo N.° 02 — Moneda (ISO 4217).
enum Moneda {
  soles('PEN', 'Soles', 'S/'),
  dolares('USD', 'Dólares americanos', r'US$'),
  euros('EUR', 'Euros', '€');

  const Moneda(this.codigo, this.etiqueta, this.simbolo);

  final String codigo;
  final String etiqueta;
  final String simbolo;

  /// Palabra usada al escribir el total en letras (ej. "... CON 00/100 SOLES").
  String get nombrePlural => switch (this) {
        Moneda.soles => 'SOLES',
        Moneda.dolares => 'DÓLARES AMERICANOS',
        Moneda.euros => 'EUROS',
      };

  static Moneda desdeCodigo(String codigo) =>
      Moneda.values.firstWhere((m) => m.codigo == codigo, orElse: () => Moneda.soles);
}

/// Catálogo N.° 03 — Unidades de medida comerciales (subconjunto usado).
enum UnidadMedida {
  unidad('NIU', 'Unidad (bienes)'),
  servicio('ZZ', 'Unidad (servicios)'),
  kilogramo('KGM', 'Kilogramo'),
  gramo('GRM', 'Gramo'),
  litro('LTR', 'Litro'),
  metro('MTR', 'Metro'),
  metroCuadrado('MTK', 'Metro cuadrado'),
  metroCubico('MTQ', 'Metro cúbico'),
  caja('BX', 'Caja'),
  paquete('PK', 'Paquete'),
  docena('DZN', 'Docena'),
  hora('HUR', 'Hora'),
  dia('DAY', 'Día'),
  mes('MON', 'Mes');

  const UnidadMedida(this.codigo, this.etiqueta);

  final String codigo;
  final String etiqueta;

  static UnidadMedida desdeCodigo(String codigo) => UnidadMedida.values
      .firstWhere((u) => u.codigo == codigo, orElse: () => UnidadMedida.unidad);
}

/// Forma de pago del comprobante (Resolución 193-2020/SUNAT).
enum FormaPago {
  contado('Contado'),
  credito('Credito');

  const FormaPago(this.codigo);

  /// Valor que espera SUNAT en `cac:PaymentTerms/cbc:PaymentMeansID`.
  final String codigo;

  String get etiqueta => this == FormaPago.contado ? 'Contado' : 'Crédito';

  static FormaPago desdeCodigo(String codigo) =>
      codigo == 'Credito' ? FormaPago.credito : FormaPago.contado;
}

/// Catálogo N.° 09 — Motivos de nota de crédito (subconjunto usado).
enum MotivoNotaCredito {
  anulacionOperacion('01', 'Anulación de la operación'),
  anulacionRucErrado('02', 'Anulación por error en el RUC'),
  correccionDescripcion('03', 'Corrección por error en la descripción'),
  descuentoGlobal('04', 'Descuento global'),
  descuentoPorItem('05', 'Descuento por ítem'),
  devolucionTotal('06', 'Devolución total'),
  devolucionPorItem('07', 'Devolución por ítem'),
  bonificacion('08', 'Bonificación'),
  disminucionValor('09', 'Disminución en el valor');

  const MotivoNotaCredito(this.codigo, this.etiqueta);

  final String codigo;
  final String etiqueta;

  static MotivoNotaCredito desdeCodigo(String codigo) => MotivoNotaCredito.values
      .firstWhere((m) => m.codigo == codigo, orElse: () => MotivoNotaCredito.anulacionOperacion);
}

/// Estado del comprobante frente a SUNAT.
enum EstadoSunat {
  simulado('Simulado'),
  pendienteEnvio('Pendiente de envío'),
  enviado('Enviado'),
  aceptado('Aceptado'),
  rechazado('Rechazado'),
  observado('Observado');

  const EstadoSunat(this.etiqueta);

  final String etiqueta;

  /// `true` si el comprobante ya no admite reintento de envío.
  bool get esFinal => this == EstadoSunat.aceptado || this == EstadoSunat.rechazado;

  static EstadoSunat desdeNombre(String nombre) => EstadoSunat.values
      .firstWhere((e) => e.name == nombre, orElse: () => EstadoSunat.simulado);
}
