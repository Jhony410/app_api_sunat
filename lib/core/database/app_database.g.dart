// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $EmpresasTablaTable extends EmpresasTabla
    with TableInfo<$EmpresasTablaTable, EmpresaRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EmpresasTablaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _rucMeta = const VerificationMeta('ruc');
  @override
  late final GeneratedColumn<String> ruc = GeneratedColumn<String>(
    'ruc',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 11,
      maxTextLength: 11,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _razonSocialMeta = const VerificationMeta(
    'razonSocial',
  );
  @override
  late final GeneratedColumn<String> razonSocial = GeneratedColumn<String>(
    'razon_social',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreComercialMeta = const VerificationMeta(
    'nombreComercial',
  );
  @override
  late final GeneratedColumn<String> nombreComercial = GeneratedColumn<String>(
    'nombre_comercial',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _ubigeoMeta = const VerificationMeta('ubigeo');
  @override
  late final GeneratedColumn<String> ubigeo = GeneratedColumn<String>(
    'ubigeo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _departamentoMeta = const VerificationMeta(
    'departamento',
  );
  @override
  late final GeneratedColumn<String> departamento = GeneratedColumn<String>(
    'departamento',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _provinciaMeta = const VerificationMeta(
    'provincia',
  );
  @override
  late final GeneratedColumn<String> provincia = GeneratedColumn<String>(
    'provincia',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _distritoMeta = const VerificationMeta(
    'distrito',
  );
  @override
  late final GeneratedColumn<String> distrito = GeneratedColumn<String>(
    'distrito',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _direccionMeta = const VerificationMeta(
    'direccion',
  );
  @override
  late final GeneratedColumn<String> direccion = GeneratedColumn<String>(
    'direccion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _logoPathMeta = const VerificationMeta(
    'logoPath',
  );
  @override
  late final GeneratedColumn<String> logoPath = GeneratedColumn<String>(
    'logo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  seriesFactura = GeneratedColumn<String>(
    'series_factura',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('["F001"]'),
  ).withConverter<List<String>>($EmpresasTablaTable.$converterseriesFactura);
  @override
  late final GeneratedColumnWithTypeConverter<List<String>, String>
  seriesBoleta = GeneratedColumn<String>(
    'series_boleta',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('["B001"]'),
  ).withConverter<List<String>>($EmpresasTablaTable.$converterseriesBoleta);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ruc,
    razonSocial,
    nombreComercial,
    ubigeo,
    departamento,
    provincia,
    distrito,
    direccion,
    logoPath,
    seriesFactura,
    seriesBoleta,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'empresas';
  @override
  VerificationContext validateIntegrity(
    Insertable<EmpresaRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('ruc')) {
      context.handle(
        _rucMeta,
        ruc.isAcceptableOrUnknown(data['ruc']!, _rucMeta),
      );
    } else if (isInserting) {
      context.missing(_rucMeta);
    }
    if (data.containsKey('razon_social')) {
      context.handle(
        _razonSocialMeta,
        razonSocial.isAcceptableOrUnknown(
          data['razon_social']!,
          _razonSocialMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_razonSocialMeta);
    }
    if (data.containsKey('nombre_comercial')) {
      context.handle(
        _nombreComercialMeta,
        nombreComercial.isAcceptableOrUnknown(
          data['nombre_comercial']!,
          _nombreComercialMeta,
        ),
      );
    }
    if (data.containsKey('ubigeo')) {
      context.handle(
        _ubigeoMeta,
        ubigeo.isAcceptableOrUnknown(data['ubigeo']!, _ubigeoMeta),
      );
    }
    if (data.containsKey('departamento')) {
      context.handle(
        _departamentoMeta,
        departamento.isAcceptableOrUnknown(
          data['departamento']!,
          _departamentoMeta,
        ),
      );
    }
    if (data.containsKey('provincia')) {
      context.handle(
        _provinciaMeta,
        provincia.isAcceptableOrUnknown(data['provincia']!, _provinciaMeta),
      );
    }
    if (data.containsKey('distrito')) {
      context.handle(
        _distritoMeta,
        distrito.isAcceptableOrUnknown(data['distrito']!, _distritoMeta),
      );
    }
    if (data.containsKey('direccion')) {
      context.handle(
        _direccionMeta,
        direccion.isAcceptableOrUnknown(data['direccion']!, _direccionMeta),
      );
    }
    if (data.containsKey('logo_path')) {
      context.handle(
        _logoPathMeta,
        logoPath.isAcceptableOrUnknown(data['logo_path']!, _logoPathMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EmpresaRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EmpresaRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ruc: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ruc'],
      )!,
      razonSocial: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}razon_social'],
      )!,
      nombreComercial: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_comercial'],
      )!,
      ubigeo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ubigeo'],
      )!,
      departamento: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}departamento'],
      )!,
      provincia: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provincia'],
      )!,
      distrito: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}distrito'],
      )!,
      direccion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direccion'],
      )!,
      logoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}logo_path'],
      ),
      seriesFactura: $EmpresasTablaTable.$converterseriesFactura.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}series_factura'],
        )!,
      ),
      seriesBoleta: $EmpresasTablaTable.$converterseriesBoleta.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}series_boleta'],
        )!,
      ),
    );
  }

  @override
  $EmpresasTablaTable createAlias(String alias) {
    return $EmpresasTablaTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<List<String>, String, String>
  $converterseriesFactura = const ListaTextoConverter();
  static JsonTypeConverter2<List<String>, String, String>
  $converterseriesBoleta = const ListaTextoConverter();
}

class EmpresaRow extends DataClass implements Insertable<EmpresaRow> {
  final int id;
  final String ruc;
  final String razonSocial;
  final String nombreComercial;
  final String ubigeo;
  final String departamento;
  final String provincia;
  final String distrito;
  final String direccion;
  final String? logoPath;
  final List<String> seriesFactura;
  final List<String> seriesBoleta;
  const EmpresaRow({
    required this.id,
    required this.ruc,
    required this.razonSocial,
    required this.nombreComercial,
    required this.ubigeo,
    required this.departamento,
    required this.provincia,
    required this.distrito,
    required this.direccion,
    this.logoPath,
    required this.seriesFactura,
    required this.seriesBoleta,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['ruc'] = Variable<String>(ruc);
    map['razon_social'] = Variable<String>(razonSocial);
    map['nombre_comercial'] = Variable<String>(nombreComercial);
    map['ubigeo'] = Variable<String>(ubigeo);
    map['departamento'] = Variable<String>(departamento);
    map['provincia'] = Variable<String>(provincia);
    map['distrito'] = Variable<String>(distrito);
    map['direccion'] = Variable<String>(direccion);
    if (!nullToAbsent || logoPath != null) {
      map['logo_path'] = Variable<String>(logoPath);
    }
    {
      map['series_factura'] = Variable<String>(
        $EmpresasTablaTable.$converterseriesFactura.toSql(seriesFactura),
      );
    }
    {
      map['series_boleta'] = Variable<String>(
        $EmpresasTablaTable.$converterseriesBoleta.toSql(seriesBoleta),
      );
    }
    return map;
  }

  EmpresasTablaCompanion toCompanion(bool nullToAbsent) {
    return EmpresasTablaCompanion(
      id: Value(id),
      ruc: Value(ruc),
      razonSocial: Value(razonSocial),
      nombreComercial: Value(nombreComercial),
      ubigeo: Value(ubigeo),
      departamento: Value(departamento),
      provincia: Value(provincia),
      distrito: Value(distrito),
      direccion: Value(direccion),
      logoPath: logoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(logoPath),
      seriesFactura: Value(seriesFactura),
      seriesBoleta: Value(seriesBoleta),
    );
  }

  factory EmpresaRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EmpresaRow(
      id: serializer.fromJson<int>(json['id']),
      ruc: serializer.fromJson<String>(json['ruc']),
      razonSocial: serializer.fromJson<String>(json['razonSocial']),
      nombreComercial: serializer.fromJson<String>(json['nombreComercial']),
      ubigeo: serializer.fromJson<String>(json['ubigeo']),
      departamento: serializer.fromJson<String>(json['departamento']),
      provincia: serializer.fromJson<String>(json['provincia']),
      distrito: serializer.fromJson<String>(json['distrito']),
      direccion: serializer.fromJson<String>(json['direccion']),
      logoPath: serializer.fromJson<String?>(json['logoPath']),
      seriesFactura: $EmpresasTablaTable.$converterseriesFactura.fromJson(
        serializer.fromJson<String>(json['seriesFactura']),
      ),
      seriesBoleta: $EmpresasTablaTable.$converterseriesBoleta.fromJson(
        serializer.fromJson<String>(json['seriesBoleta']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ruc': serializer.toJson<String>(ruc),
      'razonSocial': serializer.toJson<String>(razonSocial),
      'nombreComercial': serializer.toJson<String>(nombreComercial),
      'ubigeo': serializer.toJson<String>(ubigeo),
      'departamento': serializer.toJson<String>(departamento),
      'provincia': serializer.toJson<String>(provincia),
      'distrito': serializer.toJson<String>(distrito),
      'direccion': serializer.toJson<String>(direccion),
      'logoPath': serializer.toJson<String?>(logoPath),
      'seriesFactura': serializer.toJson<String>(
        $EmpresasTablaTable.$converterseriesFactura.toJson(seriesFactura),
      ),
      'seriesBoleta': serializer.toJson<String>(
        $EmpresasTablaTable.$converterseriesBoleta.toJson(seriesBoleta),
      ),
    };
  }

  EmpresaRow copyWith({
    int? id,
    String? ruc,
    String? razonSocial,
    String? nombreComercial,
    String? ubigeo,
    String? departamento,
    String? provincia,
    String? distrito,
    String? direccion,
    Value<String?> logoPath = const Value.absent(),
    List<String>? seriesFactura,
    List<String>? seriesBoleta,
  }) => EmpresaRow(
    id: id ?? this.id,
    ruc: ruc ?? this.ruc,
    razonSocial: razonSocial ?? this.razonSocial,
    nombreComercial: nombreComercial ?? this.nombreComercial,
    ubigeo: ubigeo ?? this.ubigeo,
    departamento: departamento ?? this.departamento,
    provincia: provincia ?? this.provincia,
    distrito: distrito ?? this.distrito,
    direccion: direccion ?? this.direccion,
    logoPath: logoPath.present ? logoPath.value : this.logoPath,
    seriesFactura: seriesFactura ?? this.seriesFactura,
    seriesBoleta: seriesBoleta ?? this.seriesBoleta,
  );
  EmpresaRow copyWithCompanion(EmpresasTablaCompanion data) {
    return EmpresaRow(
      id: data.id.present ? data.id.value : this.id,
      ruc: data.ruc.present ? data.ruc.value : this.ruc,
      razonSocial: data.razonSocial.present
          ? data.razonSocial.value
          : this.razonSocial,
      nombreComercial: data.nombreComercial.present
          ? data.nombreComercial.value
          : this.nombreComercial,
      ubigeo: data.ubigeo.present ? data.ubigeo.value : this.ubigeo,
      departamento: data.departamento.present
          ? data.departamento.value
          : this.departamento,
      provincia: data.provincia.present ? data.provincia.value : this.provincia,
      distrito: data.distrito.present ? data.distrito.value : this.distrito,
      direccion: data.direccion.present ? data.direccion.value : this.direccion,
      logoPath: data.logoPath.present ? data.logoPath.value : this.logoPath,
      seriesFactura: data.seriesFactura.present
          ? data.seriesFactura.value
          : this.seriesFactura,
      seriesBoleta: data.seriesBoleta.present
          ? data.seriesBoleta.value
          : this.seriesBoleta,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EmpresaRow(')
          ..write('id: $id, ')
          ..write('ruc: $ruc, ')
          ..write('razonSocial: $razonSocial, ')
          ..write('nombreComercial: $nombreComercial, ')
          ..write('ubigeo: $ubigeo, ')
          ..write('departamento: $departamento, ')
          ..write('provincia: $provincia, ')
          ..write('distrito: $distrito, ')
          ..write('direccion: $direccion, ')
          ..write('logoPath: $logoPath, ')
          ..write('seriesFactura: $seriesFactura, ')
          ..write('seriesBoleta: $seriesBoleta')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    ruc,
    razonSocial,
    nombreComercial,
    ubigeo,
    departamento,
    provincia,
    distrito,
    direccion,
    logoPath,
    seriesFactura,
    seriesBoleta,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EmpresaRow &&
          other.id == this.id &&
          other.ruc == this.ruc &&
          other.razonSocial == this.razonSocial &&
          other.nombreComercial == this.nombreComercial &&
          other.ubigeo == this.ubigeo &&
          other.departamento == this.departamento &&
          other.provincia == this.provincia &&
          other.distrito == this.distrito &&
          other.direccion == this.direccion &&
          other.logoPath == this.logoPath &&
          other.seriesFactura == this.seriesFactura &&
          other.seriesBoleta == this.seriesBoleta);
}

class EmpresasTablaCompanion extends UpdateCompanion<EmpresaRow> {
  final Value<int> id;
  final Value<String> ruc;
  final Value<String> razonSocial;
  final Value<String> nombreComercial;
  final Value<String> ubigeo;
  final Value<String> departamento;
  final Value<String> provincia;
  final Value<String> distrito;
  final Value<String> direccion;
  final Value<String?> logoPath;
  final Value<List<String>> seriesFactura;
  final Value<List<String>> seriesBoleta;
  const EmpresasTablaCompanion({
    this.id = const Value.absent(),
    this.ruc = const Value.absent(),
    this.razonSocial = const Value.absent(),
    this.nombreComercial = const Value.absent(),
    this.ubigeo = const Value.absent(),
    this.departamento = const Value.absent(),
    this.provincia = const Value.absent(),
    this.distrito = const Value.absent(),
    this.direccion = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.seriesFactura = const Value.absent(),
    this.seriesBoleta = const Value.absent(),
  });
  EmpresasTablaCompanion.insert({
    this.id = const Value.absent(),
    required String ruc,
    required String razonSocial,
    this.nombreComercial = const Value.absent(),
    this.ubigeo = const Value.absent(),
    this.departamento = const Value.absent(),
    this.provincia = const Value.absent(),
    this.distrito = const Value.absent(),
    this.direccion = const Value.absent(),
    this.logoPath = const Value.absent(),
    this.seriesFactura = const Value.absent(),
    this.seriesBoleta = const Value.absent(),
  }) : ruc = Value(ruc),
       razonSocial = Value(razonSocial);
  static Insertable<EmpresaRow> custom({
    Expression<int>? id,
    Expression<String>? ruc,
    Expression<String>? razonSocial,
    Expression<String>? nombreComercial,
    Expression<String>? ubigeo,
    Expression<String>? departamento,
    Expression<String>? provincia,
    Expression<String>? distrito,
    Expression<String>? direccion,
    Expression<String>? logoPath,
    Expression<String>? seriesFactura,
    Expression<String>? seriesBoleta,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ruc != null) 'ruc': ruc,
      if (razonSocial != null) 'razon_social': razonSocial,
      if (nombreComercial != null) 'nombre_comercial': nombreComercial,
      if (ubigeo != null) 'ubigeo': ubigeo,
      if (departamento != null) 'departamento': departamento,
      if (provincia != null) 'provincia': provincia,
      if (distrito != null) 'distrito': distrito,
      if (direccion != null) 'direccion': direccion,
      if (logoPath != null) 'logo_path': logoPath,
      if (seriesFactura != null) 'series_factura': seriesFactura,
      if (seriesBoleta != null) 'series_boleta': seriesBoleta,
    });
  }

  EmpresasTablaCompanion copyWith({
    Value<int>? id,
    Value<String>? ruc,
    Value<String>? razonSocial,
    Value<String>? nombreComercial,
    Value<String>? ubigeo,
    Value<String>? departamento,
    Value<String>? provincia,
    Value<String>? distrito,
    Value<String>? direccion,
    Value<String?>? logoPath,
    Value<List<String>>? seriesFactura,
    Value<List<String>>? seriesBoleta,
  }) {
    return EmpresasTablaCompanion(
      id: id ?? this.id,
      ruc: ruc ?? this.ruc,
      razonSocial: razonSocial ?? this.razonSocial,
      nombreComercial: nombreComercial ?? this.nombreComercial,
      ubigeo: ubigeo ?? this.ubigeo,
      departamento: departamento ?? this.departamento,
      provincia: provincia ?? this.provincia,
      distrito: distrito ?? this.distrito,
      direccion: direccion ?? this.direccion,
      logoPath: logoPath ?? this.logoPath,
      seriesFactura: seriesFactura ?? this.seriesFactura,
      seriesBoleta: seriesBoleta ?? this.seriesBoleta,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ruc.present) {
      map['ruc'] = Variable<String>(ruc.value);
    }
    if (razonSocial.present) {
      map['razon_social'] = Variable<String>(razonSocial.value);
    }
    if (nombreComercial.present) {
      map['nombre_comercial'] = Variable<String>(nombreComercial.value);
    }
    if (ubigeo.present) {
      map['ubigeo'] = Variable<String>(ubigeo.value);
    }
    if (departamento.present) {
      map['departamento'] = Variable<String>(departamento.value);
    }
    if (provincia.present) {
      map['provincia'] = Variable<String>(provincia.value);
    }
    if (distrito.present) {
      map['distrito'] = Variable<String>(distrito.value);
    }
    if (direccion.present) {
      map['direccion'] = Variable<String>(direccion.value);
    }
    if (logoPath.present) {
      map['logo_path'] = Variable<String>(logoPath.value);
    }
    if (seriesFactura.present) {
      map['series_factura'] = Variable<String>(
        $EmpresasTablaTable.$converterseriesFactura.toSql(seriesFactura.value),
      );
    }
    if (seriesBoleta.present) {
      map['series_boleta'] = Variable<String>(
        $EmpresasTablaTable.$converterseriesBoleta.toSql(seriesBoleta.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EmpresasTablaCompanion(')
          ..write('id: $id, ')
          ..write('ruc: $ruc, ')
          ..write('razonSocial: $razonSocial, ')
          ..write('nombreComercial: $nombreComercial, ')
          ..write('ubigeo: $ubigeo, ')
          ..write('departamento: $departamento, ')
          ..write('provincia: $provincia, ')
          ..write('distrito: $distrito, ')
          ..write('direccion: $direccion, ')
          ..write('logoPath: $logoPath, ')
          ..write('seriesFactura: $seriesFactura, ')
          ..write('seriesBoleta: $seriesBoleta')
          ..write(')'))
        .toString();
  }
}

class $ClientesTablaTable extends ClientesTabla
    with TableInfo<$ClientesTablaTable, ClienteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesTablaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TipoDocumentoIdentidad, String>
  tipoDocumento =
      GeneratedColumn<String>(
        'tipo_documento',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TipoDocumentoIdentidad>(
        $ClientesTablaTable.$convertertipoDocumento,
      );
  static const VerificationMeta _numeroDocumentoMeta = const VerificationMeta(
    'numeroDocumento',
  );
  @override
  late final GeneratedColumn<String> numeroDocumento = GeneratedColumn<String>(
    'numero_documento',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _razonSocialONombresMeta =
      const VerificationMeta('razonSocialONombres');
  @override
  late final GeneratedColumn<String> razonSocialONombres =
      GeneratedColumn<String>(
        'razon_social_o_nombres',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _direccionMeta = const VerificationMeta(
    'direccion',
  );
  @override
  late final GeneratedColumn<String> direccion = GeneratedColumn<String>(
    'direccion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tipoDocumento,
    numeroDocumento,
    razonSocialONombres,
    direccion,
    telefono,
    email,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clientes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ClienteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('numero_documento')) {
      context.handle(
        _numeroDocumentoMeta,
        numeroDocumento.isAcceptableOrUnknown(
          data['numero_documento']!,
          _numeroDocumentoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_numeroDocumentoMeta);
    }
    if (data.containsKey('razon_social_o_nombres')) {
      context.handle(
        _razonSocialONombresMeta,
        razonSocialONombres.isAcceptableOrUnknown(
          data['razon_social_o_nombres']!,
          _razonSocialONombresMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_razonSocialONombresMeta);
    }
    if (data.containsKey('direccion')) {
      context.handle(
        _direccionMeta,
        direccion.isAcceptableOrUnknown(data['direccion']!, _direccionMeta),
      );
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {tipoDocumento, numeroDocumento},
  ];
  @override
  ClienteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ClienteRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tipoDocumento: $ClientesTablaTable.$convertertipoDocumento.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tipo_documento'],
        )!,
      ),
      numeroDocumento: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numero_documento'],
      )!,
      razonSocialONombres: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}razon_social_o_nombres'],
      )!,
      direccion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}direccion'],
      ),
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      ),
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $ClientesTablaTable createAlias(String alias) {
    return $ClientesTablaTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TipoDocumentoIdentidad, String, String>
  $convertertipoDocumento = const TipoDocumentoIdentidadConverter();
}

class ClienteRow extends DataClass implements Insertable<ClienteRow> {
  final int id;
  final TipoDocumentoIdentidad tipoDocumento;
  final String numeroDocumento;
  final String razonSocialONombres;
  final String? direccion;
  final String? telefono;
  final String? email;
  final DateTime creadoEn;
  const ClienteRow({
    required this.id,
    required this.tipoDocumento,
    required this.numeroDocumento,
    required this.razonSocialONombres,
    this.direccion,
    this.telefono,
    this.email,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['tipo_documento'] = Variable<String>(
        $ClientesTablaTable.$convertertipoDocumento.toSql(tipoDocumento),
      );
    }
    map['numero_documento'] = Variable<String>(numeroDocumento);
    map['razon_social_o_nombres'] = Variable<String>(razonSocialONombres);
    if (!nullToAbsent || direccion != null) {
      map['direccion'] = Variable<String>(direccion);
    }
    if (!nullToAbsent || telefono != null) {
      map['telefono'] = Variable<String>(telefono);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  ClientesTablaCompanion toCompanion(bool nullToAbsent) {
    return ClientesTablaCompanion(
      id: Value(id),
      tipoDocumento: Value(tipoDocumento),
      numeroDocumento: Value(numeroDocumento),
      razonSocialONombres: Value(razonSocialONombres),
      direccion: direccion == null && nullToAbsent
          ? const Value.absent()
          : Value(direccion),
      telefono: telefono == null && nullToAbsent
          ? const Value.absent()
          : Value(telefono),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      creadoEn: Value(creadoEn),
    );
  }

  factory ClienteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ClienteRow(
      id: serializer.fromJson<int>(json['id']),
      tipoDocumento: $ClientesTablaTable.$convertertipoDocumento.fromJson(
        serializer.fromJson<String>(json['tipoDocumento']),
      ),
      numeroDocumento: serializer.fromJson<String>(json['numeroDocumento']),
      razonSocialONombres: serializer.fromJson<String>(
        json['razonSocialONombres'],
      ),
      direccion: serializer.fromJson<String?>(json['direccion']),
      telefono: serializer.fromJson<String?>(json['telefono']),
      email: serializer.fromJson<String?>(json['email']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipoDocumento': serializer.toJson<String>(
        $ClientesTablaTable.$convertertipoDocumento.toJson(tipoDocumento),
      ),
      'numeroDocumento': serializer.toJson<String>(numeroDocumento),
      'razonSocialONombres': serializer.toJson<String>(razonSocialONombres),
      'direccion': serializer.toJson<String?>(direccion),
      'telefono': serializer.toJson<String?>(telefono),
      'email': serializer.toJson<String?>(email),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  ClienteRow copyWith({
    int? id,
    TipoDocumentoIdentidad? tipoDocumento,
    String? numeroDocumento,
    String? razonSocialONombres,
    Value<String?> direccion = const Value.absent(),
    Value<String?> telefono = const Value.absent(),
    Value<String?> email = const Value.absent(),
    DateTime? creadoEn,
  }) => ClienteRow(
    id: id ?? this.id,
    tipoDocumento: tipoDocumento ?? this.tipoDocumento,
    numeroDocumento: numeroDocumento ?? this.numeroDocumento,
    razonSocialONombres: razonSocialONombres ?? this.razonSocialONombres,
    direccion: direccion.present ? direccion.value : this.direccion,
    telefono: telefono.present ? telefono.value : this.telefono,
    email: email.present ? email.value : this.email,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  ClienteRow copyWithCompanion(ClientesTablaCompanion data) {
    return ClienteRow(
      id: data.id.present ? data.id.value : this.id,
      tipoDocumento: data.tipoDocumento.present
          ? data.tipoDocumento.value
          : this.tipoDocumento,
      numeroDocumento: data.numeroDocumento.present
          ? data.numeroDocumento.value
          : this.numeroDocumento,
      razonSocialONombres: data.razonSocialONombres.present
          ? data.razonSocialONombres.value
          : this.razonSocialONombres,
      direccion: data.direccion.present ? data.direccion.value : this.direccion,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
      email: data.email.present ? data.email.value : this.email,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ClienteRow(')
          ..write('id: $id, ')
          ..write('tipoDocumento: $tipoDocumento, ')
          ..write('numeroDocumento: $numeroDocumento, ')
          ..write('razonSocialONombres: $razonSocialONombres, ')
          ..write('direccion: $direccion, ')
          ..write('telefono: $telefono, ')
          ..write('email: $email, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    tipoDocumento,
    numeroDocumento,
    razonSocialONombres,
    direccion,
    telefono,
    email,
    creadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ClienteRow &&
          other.id == this.id &&
          other.tipoDocumento == this.tipoDocumento &&
          other.numeroDocumento == this.numeroDocumento &&
          other.razonSocialONombres == this.razonSocialONombres &&
          other.direccion == this.direccion &&
          other.telefono == this.telefono &&
          other.email == this.email &&
          other.creadoEn == this.creadoEn);
}

class ClientesTablaCompanion extends UpdateCompanion<ClienteRow> {
  final Value<int> id;
  final Value<TipoDocumentoIdentidad> tipoDocumento;
  final Value<String> numeroDocumento;
  final Value<String> razonSocialONombres;
  final Value<String?> direccion;
  final Value<String?> telefono;
  final Value<String?> email;
  final Value<DateTime> creadoEn;
  const ClientesTablaCompanion({
    this.id = const Value.absent(),
    this.tipoDocumento = const Value.absent(),
    this.numeroDocumento = const Value.absent(),
    this.razonSocialONombres = const Value.absent(),
    this.direccion = const Value.absent(),
    this.telefono = const Value.absent(),
    this.email = const Value.absent(),
    this.creadoEn = const Value.absent(),
  });
  ClientesTablaCompanion.insert({
    this.id = const Value.absent(),
    required TipoDocumentoIdentidad tipoDocumento,
    required String numeroDocumento,
    required String razonSocialONombres,
    this.direccion = const Value.absent(),
    this.telefono = const Value.absent(),
    this.email = const Value.absent(),
    this.creadoEn = const Value.absent(),
  }) : tipoDocumento = Value(tipoDocumento),
       numeroDocumento = Value(numeroDocumento),
       razonSocialONombres = Value(razonSocialONombres);
  static Insertable<ClienteRow> custom({
    Expression<int>? id,
    Expression<String>? tipoDocumento,
    Expression<String>? numeroDocumento,
    Expression<String>? razonSocialONombres,
    Expression<String>? direccion,
    Expression<String>? telefono,
    Expression<String>? email,
    Expression<DateTime>? creadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipoDocumento != null) 'tipo_documento': tipoDocumento,
      if (numeroDocumento != null) 'numero_documento': numeroDocumento,
      if (razonSocialONombres != null)
        'razon_social_o_nombres': razonSocialONombres,
      if (direccion != null) 'direccion': direccion,
      if (telefono != null) 'telefono': telefono,
      if (email != null) 'email': email,
      if (creadoEn != null) 'creado_en': creadoEn,
    });
  }

  ClientesTablaCompanion copyWith({
    Value<int>? id,
    Value<TipoDocumentoIdentidad>? tipoDocumento,
    Value<String>? numeroDocumento,
    Value<String>? razonSocialONombres,
    Value<String?>? direccion,
    Value<String?>? telefono,
    Value<String?>? email,
    Value<DateTime>? creadoEn,
  }) {
    return ClientesTablaCompanion(
      id: id ?? this.id,
      tipoDocumento: tipoDocumento ?? this.tipoDocumento,
      numeroDocumento: numeroDocumento ?? this.numeroDocumento,
      razonSocialONombres: razonSocialONombres ?? this.razonSocialONombres,
      direccion: direccion ?? this.direccion,
      telefono: telefono ?? this.telefono,
      email: email ?? this.email,
      creadoEn: creadoEn ?? this.creadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipoDocumento.present) {
      map['tipo_documento'] = Variable<String>(
        $ClientesTablaTable.$convertertipoDocumento.toSql(tipoDocumento.value),
      );
    }
    if (numeroDocumento.present) {
      map['numero_documento'] = Variable<String>(numeroDocumento.value);
    }
    if (razonSocialONombres.present) {
      map['razon_social_o_nombres'] = Variable<String>(
        razonSocialONombres.value,
      );
    }
    if (direccion.present) {
      map['direccion'] = Variable<String>(direccion.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientesTablaCompanion(')
          ..write('id: $id, ')
          ..write('tipoDocumento: $tipoDocumento, ')
          ..write('numeroDocumento: $numeroDocumento, ')
          ..write('razonSocialONombres: $razonSocialONombres, ')
          ..write('direccion: $direccion, ')
          ..write('telefono: $telefono, ')
          ..write('email: $email, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }
}

class $ComprobantesTablaTable extends ComprobantesTabla
    with TableInfo<$ComprobantesTablaTable, ComprobanteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ComprobantesTablaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TipoComprobante, String> tipo =
      GeneratedColumn<String>(
        'tipo',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TipoComprobante>($ComprobantesTablaTable.$convertertipo);
  static const VerificationMeta _serieMeta = const VerificationMeta('serie');
  @override
  late final GeneratedColumn<String> serie = GeneratedColumn<String>(
    'serie',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 4,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _correlativoMeta = const VerificationMeta(
    'correlativo',
  );
  @override
  late final GeneratedColumn<int> correlativo = GeneratedColumn<int>(
    'correlativo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaEmisionMeta = const VerificationMeta(
    'fechaEmision',
  );
  @override
  late final GeneratedColumn<DateTime> fechaEmision = GeneratedColumn<DateTime>(
    'fecha_emision',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaVencimientoMeta = const VerificationMeta(
    'fechaVencimiento',
  );
  @override
  late final GeneratedColumn<DateTime> fechaVencimiento =
      GeneratedColumn<DateTime>(
        'fecha_vencimiento',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<Moneda, String> moneda =
      GeneratedColumn<String>(
        'moneda',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Moneda>($ComprobantesTablaTable.$convertermoneda);
  @override
  late final GeneratedColumnWithTypeConverter<FormaPago, String> formaPago =
      GeneratedColumn<String>(
        'forma_pago',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<FormaPago>($ComprobantesTablaTable.$converterformaPago);
  static const VerificationMeta _clienteIdMeta = const VerificationMeta(
    'clienteId',
  );
  @override
  late final GeneratedColumn<int> clienteId = GeneratedColumn<int>(
    'cliente_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clientes (id) ON DELETE SET NULL',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TipoDocumentoIdentidad, String>
  clienteTipoDocumento =
      GeneratedColumn<String>(
        'cliente_tipo_documento',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TipoDocumentoIdentidad>(
        $ComprobantesTablaTable.$converterclienteTipoDocumento,
      );
  static const VerificationMeta _clienteNumeroDocumentoMeta =
      const VerificationMeta('clienteNumeroDocumento');
  @override
  late final GeneratedColumn<String> clienteNumeroDocumento =
      GeneratedColumn<String>(
        'cliente_numero_documento',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _clienteRazonSocialMeta =
      const VerificationMeta('clienteRazonSocial');
  @override
  late final GeneratedColumn<String> clienteRazonSocial =
      GeneratedColumn<String>(
        'cliente_razon_social',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _clienteDireccionMeta = const VerificationMeta(
    'clienteDireccion',
  );
  @override
  late final GeneratedColumn<String> clienteDireccion = GeneratedColumn<String>(
    'cliente_direccion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clienteTelefonoMeta = const VerificationMeta(
    'clienteTelefono',
  );
  @override
  late final GeneratedColumn<String> clienteTelefono = GeneratedColumn<String>(
    'cliente_telefono',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _clienteEmailMeta = const VerificationMeta(
    'clienteEmail',
  );
  @override
  late final GeneratedColumn<String> clienteEmail = GeneratedColumn<String>(
    'cliente_email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _observacionesMeta = const VerificationMeta(
    'observaciones',
  );
  @override
  late final GeneratedColumn<String> observaciones = GeneratedColumn<String>(
    'observaciones',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<EstadoSunat, String> estadoSunat =
      GeneratedColumn<String>(
        'estado_sunat',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<EstadoSunat>(
        $ComprobantesTablaTable.$converterestadoSunat,
      );
  static const VerificationMeta _mensajeSunatMeta = const VerificationMeta(
    'mensajeSunat',
  );
  @override
  late final GeneratedColumn<String> mensajeSunat = GeneratedColumn<String>(
    'mensaje_sunat',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _xmlGeneradoMeta = const VerificationMeta(
    'xmlGenerado',
  );
  @override
  late final GeneratedColumn<String> xmlGenerado = GeneratedColumn<String>(
    'xml_generado',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _cdrRecibidoMeta = const VerificationMeta(
    'cdrRecibido',
  );
  @override
  late final GeneratedColumn<String> cdrRecibido = GeneratedColumn<String>(
    'cdr_recibido',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _hashCodigoMeta = const VerificationMeta(
    'hashCodigo',
  );
  @override
  late final GeneratedColumn<String> hashCodigo = GeneratedColumn<String>(
    'hash_codigo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ticketMeta = const VerificationMeta('ticket');
  @override
  late final GeneratedColumn<String> ticket = GeneratedColumn<String>(
    'ticket',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MotivoNotaCredito?, String>
  motivoNota =
      GeneratedColumn<String>(
        'motivo_nota',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<MotivoNotaCredito?>(
        $ComprobantesTablaTable.$convertermotivoNotan,
      );
  static const VerificationMeta _documentoAfectadoMeta = const VerificationMeta(
    'documentoAfectado',
  );
  @override
  late final GeneratedColumn<String> documentoAfectado =
      GeneratedColumn<String>(
        'documento_afectado',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  @override
  late final GeneratedColumnWithTypeConverter<TipoComprobante?, String>
  tipoDocumentoAfectado =
      GeneratedColumn<String>(
        'tipo_documento_afectado',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<TipoComprobante?>(
        $ComprobantesTablaTable.$convertertipoDocumentoAfectadon,
      );
  static const VerificationMeta _importeTotalMeta = const VerificationMeta(
    'importeTotal',
  );
  @override
  late final GeneratedColumn<double> importeTotal = GeneratedColumn<double>(
    'importe_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _actualizadoEnMeta = const VerificationMeta(
    'actualizadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> actualizadoEn =
      GeneratedColumn<DateTime>(
        'actualizado_en',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    tipo,
    serie,
    correlativo,
    fechaEmision,
    fechaVencimiento,
    moneda,
    formaPago,
    clienteId,
    clienteTipoDocumento,
    clienteNumeroDocumento,
    clienteRazonSocial,
    clienteDireccion,
    clienteTelefono,
    clienteEmail,
    observaciones,
    estadoSunat,
    mensajeSunat,
    xmlGenerado,
    cdrRecibido,
    hashCodigo,
    ticket,
    motivoNota,
    documentoAfectado,
    tipoDocumentoAfectado,
    importeTotal,
    creadoEn,
    actualizadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'comprobantes';
  @override
  VerificationContext validateIntegrity(
    Insertable<ComprobanteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('serie')) {
      context.handle(
        _serieMeta,
        serie.isAcceptableOrUnknown(data['serie']!, _serieMeta),
      );
    } else if (isInserting) {
      context.missing(_serieMeta);
    }
    if (data.containsKey('correlativo')) {
      context.handle(
        _correlativoMeta,
        correlativo.isAcceptableOrUnknown(
          data['correlativo']!,
          _correlativoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_correlativoMeta);
    }
    if (data.containsKey('fecha_emision')) {
      context.handle(
        _fechaEmisionMeta,
        fechaEmision.isAcceptableOrUnknown(
          data['fecha_emision']!,
          _fechaEmisionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fechaEmisionMeta);
    }
    if (data.containsKey('fecha_vencimiento')) {
      context.handle(
        _fechaVencimientoMeta,
        fechaVencimiento.isAcceptableOrUnknown(
          data['fecha_vencimiento']!,
          _fechaVencimientoMeta,
        ),
      );
    }
    if (data.containsKey('cliente_id')) {
      context.handle(
        _clienteIdMeta,
        clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta),
      );
    }
    if (data.containsKey('cliente_numero_documento')) {
      context.handle(
        _clienteNumeroDocumentoMeta,
        clienteNumeroDocumento.isAcceptableOrUnknown(
          data['cliente_numero_documento']!,
          _clienteNumeroDocumentoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clienteNumeroDocumentoMeta);
    }
    if (data.containsKey('cliente_razon_social')) {
      context.handle(
        _clienteRazonSocialMeta,
        clienteRazonSocial.isAcceptableOrUnknown(
          data['cliente_razon_social']!,
          _clienteRazonSocialMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_clienteRazonSocialMeta);
    }
    if (data.containsKey('cliente_direccion')) {
      context.handle(
        _clienteDireccionMeta,
        clienteDireccion.isAcceptableOrUnknown(
          data['cliente_direccion']!,
          _clienteDireccionMeta,
        ),
      );
    }
    if (data.containsKey('cliente_telefono')) {
      context.handle(
        _clienteTelefonoMeta,
        clienteTelefono.isAcceptableOrUnknown(
          data['cliente_telefono']!,
          _clienteTelefonoMeta,
        ),
      );
    }
    if (data.containsKey('cliente_email')) {
      context.handle(
        _clienteEmailMeta,
        clienteEmail.isAcceptableOrUnknown(
          data['cliente_email']!,
          _clienteEmailMeta,
        ),
      );
    }
    if (data.containsKey('observaciones')) {
      context.handle(
        _observacionesMeta,
        observaciones.isAcceptableOrUnknown(
          data['observaciones']!,
          _observacionesMeta,
        ),
      );
    }
    if (data.containsKey('mensaje_sunat')) {
      context.handle(
        _mensajeSunatMeta,
        mensajeSunat.isAcceptableOrUnknown(
          data['mensaje_sunat']!,
          _mensajeSunatMeta,
        ),
      );
    }
    if (data.containsKey('xml_generado')) {
      context.handle(
        _xmlGeneradoMeta,
        xmlGenerado.isAcceptableOrUnknown(
          data['xml_generado']!,
          _xmlGeneradoMeta,
        ),
      );
    }
    if (data.containsKey('cdr_recibido')) {
      context.handle(
        _cdrRecibidoMeta,
        cdrRecibido.isAcceptableOrUnknown(
          data['cdr_recibido']!,
          _cdrRecibidoMeta,
        ),
      );
    }
    if (data.containsKey('hash_codigo')) {
      context.handle(
        _hashCodigoMeta,
        hashCodigo.isAcceptableOrUnknown(data['hash_codigo']!, _hashCodigoMeta),
      );
    }
    if (data.containsKey('ticket')) {
      context.handle(
        _ticketMeta,
        ticket.isAcceptableOrUnknown(data['ticket']!, _ticketMeta),
      );
    }
    if (data.containsKey('documento_afectado')) {
      context.handle(
        _documentoAfectadoMeta,
        documentoAfectado.isAcceptableOrUnknown(
          data['documento_afectado']!,
          _documentoAfectadoMeta,
        ),
      );
    }
    if (data.containsKey('importe_total')) {
      context.handle(
        _importeTotalMeta,
        importeTotal.isAcceptableOrUnknown(
          data['importe_total']!,
          _importeTotalMeta,
        ),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    }
    if (data.containsKey('actualizado_en')) {
      context.handle(
        _actualizadoEnMeta,
        actualizadoEn.isAcceptableOrUnknown(
          data['actualizado_en']!,
          _actualizadoEnMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {serie, correlativo},
  ];
  @override
  ComprobanteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ComprobanteRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      tipo: $ComprobantesTablaTable.$convertertipo.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tipo'],
        )!,
      ),
      serie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serie'],
      )!,
      correlativo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}correlativo'],
      )!,
      fechaEmision: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_emision'],
      )!,
      fechaVencimiento: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_vencimiento'],
      ),
      moneda: $ComprobantesTablaTable.$convertermoneda.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}moneda'],
        )!,
      ),
      formaPago: $ComprobantesTablaTable.$converterformaPago.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}forma_pago'],
        )!,
      ),
      clienteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cliente_id'],
      ),
      clienteTipoDocumento: $ComprobantesTablaTable
          .$converterclienteTipoDocumento
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}cliente_tipo_documento'],
            )!,
          ),
      clienteNumeroDocumento: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente_numero_documento'],
      )!,
      clienteRazonSocial: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente_razon_social'],
      )!,
      clienteDireccion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente_direccion'],
      ),
      clienteTelefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente_telefono'],
      ),
      clienteEmail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cliente_email'],
      ),
      observaciones: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observaciones'],
      ),
      estadoSunat: $ComprobantesTablaTable.$converterestadoSunat.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}estado_sunat'],
        )!,
      ),
      mensajeSunat: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mensaje_sunat'],
      ),
      xmlGenerado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}xml_generado'],
      ),
      cdrRecibido: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cdr_recibido'],
      ),
      hashCodigo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hash_codigo'],
      ),
      ticket: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ticket'],
      ),
      motivoNota: $ComprobantesTablaTable.$convertermotivoNotan.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}motivo_nota'],
        ),
      ),
      documentoAfectado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}documento_afectado'],
      ),
      tipoDocumentoAfectado: $ComprobantesTablaTable
          .$convertertipoDocumentoAfectadon
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}tipo_documento_afectado'],
            ),
          ),
      importeTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}importe_total'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
      actualizadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}actualizado_en'],
      )!,
    );
  }

  @override
  $ComprobantesTablaTable createAlias(String alias) {
    return $ComprobantesTablaTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TipoComprobante, String, String> $convertertipo =
      const TipoComprobanteConverter();
  static JsonTypeConverter2<Moneda, String, String> $convertermoneda =
      const MonedaConverter();
  static JsonTypeConverter2<FormaPago, String, String> $converterformaPago =
      const FormaPagoConverter();
  static JsonTypeConverter2<TipoDocumentoIdentidad, String, String>
  $converterclienteTipoDocumento = const TipoDocumentoIdentidadConverter();
  static JsonTypeConverter2<EstadoSunat, String, String> $converterestadoSunat =
      const EstadoSunatConverter();
  static JsonTypeConverter2<MotivoNotaCredito, String, String>
  $convertermotivoNota = const MotivoNotaCreditoConverter();
  static JsonTypeConverter2<MotivoNotaCredito?, String?, String?>
  $convertermotivoNotan = JsonTypeConverter2.asNullable($convertermotivoNota);
  static JsonTypeConverter2<TipoComprobante, String, String>
  $convertertipoDocumentoAfectado = const TipoComprobanteConverter();
  static JsonTypeConverter2<TipoComprobante?, String?, String?>
  $convertertipoDocumentoAfectadon = JsonTypeConverter2.asNullable(
    $convertertipoDocumentoAfectado,
  );
}

class ComprobanteRow extends DataClass implements Insertable<ComprobanteRow> {
  final int id;
  final TipoComprobante tipo;
  final String serie;
  final int correlativo;
  final DateTime fechaEmision;
  final DateTime? fechaVencimiento;
  final Moneda moneda;
  final FormaPago formaPago;
  final int? clienteId;
  final TipoDocumentoIdentidad clienteTipoDocumento;
  final String clienteNumeroDocumento;
  final String clienteRazonSocial;
  final String? clienteDireccion;
  final String? clienteTelefono;
  final String? clienteEmail;
  final String? observaciones;
  final EstadoSunat estadoSunat;
  final String? mensajeSunat;
  final String? xmlGenerado;
  final String? cdrRecibido;
  final String? hashCodigo;
  final String? ticket;
  final MotivoNotaCredito? motivoNota;
  final String? documentoAfectado;
  final TipoComprobante? tipoDocumentoAfectado;

  /// Importe total denormalizado. Existe sólo para poder filtrar y sumar en SQL
  /// sin cargar los ítems; la verdad sigue siendo el cálculo sobre los ítems.
  final double importeTotal;
  final DateTime creadoEn;
  final DateTime actualizadoEn;
  const ComprobanteRow({
    required this.id,
    required this.tipo,
    required this.serie,
    required this.correlativo,
    required this.fechaEmision,
    this.fechaVencimiento,
    required this.moneda,
    required this.formaPago,
    this.clienteId,
    required this.clienteTipoDocumento,
    required this.clienteNumeroDocumento,
    required this.clienteRazonSocial,
    this.clienteDireccion,
    this.clienteTelefono,
    this.clienteEmail,
    this.observaciones,
    required this.estadoSunat,
    this.mensajeSunat,
    this.xmlGenerado,
    this.cdrRecibido,
    this.hashCodigo,
    this.ticket,
    this.motivoNota,
    this.documentoAfectado,
    this.tipoDocumentoAfectado,
    required this.importeTotal,
    required this.creadoEn,
    required this.actualizadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    {
      map['tipo'] = Variable<String>(
        $ComprobantesTablaTable.$convertertipo.toSql(tipo),
      );
    }
    map['serie'] = Variable<String>(serie);
    map['correlativo'] = Variable<int>(correlativo);
    map['fecha_emision'] = Variable<DateTime>(fechaEmision);
    if (!nullToAbsent || fechaVencimiento != null) {
      map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento);
    }
    {
      map['moneda'] = Variable<String>(
        $ComprobantesTablaTable.$convertermoneda.toSql(moneda),
      );
    }
    {
      map['forma_pago'] = Variable<String>(
        $ComprobantesTablaTable.$converterformaPago.toSql(formaPago),
      );
    }
    if (!nullToAbsent || clienteId != null) {
      map['cliente_id'] = Variable<int>(clienteId);
    }
    {
      map['cliente_tipo_documento'] = Variable<String>(
        $ComprobantesTablaTable.$converterclienteTipoDocumento.toSql(
          clienteTipoDocumento,
        ),
      );
    }
    map['cliente_numero_documento'] = Variable<String>(clienteNumeroDocumento);
    map['cliente_razon_social'] = Variable<String>(clienteRazonSocial);
    if (!nullToAbsent || clienteDireccion != null) {
      map['cliente_direccion'] = Variable<String>(clienteDireccion);
    }
    if (!nullToAbsent || clienteTelefono != null) {
      map['cliente_telefono'] = Variable<String>(clienteTelefono);
    }
    if (!nullToAbsent || clienteEmail != null) {
      map['cliente_email'] = Variable<String>(clienteEmail);
    }
    if (!nullToAbsent || observaciones != null) {
      map['observaciones'] = Variable<String>(observaciones);
    }
    {
      map['estado_sunat'] = Variable<String>(
        $ComprobantesTablaTable.$converterestadoSunat.toSql(estadoSunat),
      );
    }
    if (!nullToAbsent || mensajeSunat != null) {
      map['mensaje_sunat'] = Variable<String>(mensajeSunat);
    }
    if (!nullToAbsent || xmlGenerado != null) {
      map['xml_generado'] = Variable<String>(xmlGenerado);
    }
    if (!nullToAbsent || cdrRecibido != null) {
      map['cdr_recibido'] = Variable<String>(cdrRecibido);
    }
    if (!nullToAbsent || hashCodigo != null) {
      map['hash_codigo'] = Variable<String>(hashCodigo);
    }
    if (!nullToAbsent || ticket != null) {
      map['ticket'] = Variable<String>(ticket);
    }
    if (!nullToAbsent || motivoNota != null) {
      map['motivo_nota'] = Variable<String>(
        $ComprobantesTablaTable.$convertermotivoNotan.toSql(motivoNota),
      );
    }
    if (!nullToAbsent || documentoAfectado != null) {
      map['documento_afectado'] = Variable<String>(documentoAfectado);
    }
    if (!nullToAbsent || tipoDocumentoAfectado != null) {
      map['tipo_documento_afectado'] = Variable<String>(
        $ComprobantesTablaTable.$convertertipoDocumentoAfectadon.toSql(
          tipoDocumentoAfectado,
        ),
      );
    }
    map['importe_total'] = Variable<double>(importeTotal);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    map['actualizado_en'] = Variable<DateTime>(actualizadoEn);
    return map;
  }

  ComprobantesTablaCompanion toCompanion(bool nullToAbsent) {
    return ComprobantesTablaCompanion(
      id: Value(id),
      tipo: Value(tipo),
      serie: Value(serie),
      correlativo: Value(correlativo),
      fechaEmision: Value(fechaEmision),
      fechaVencimiento: fechaVencimiento == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaVencimiento),
      moneda: Value(moneda),
      formaPago: Value(formaPago),
      clienteId: clienteId == null && nullToAbsent
          ? const Value.absent()
          : Value(clienteId),
      clienteTipoDocumento: Value(clienteTipoDocumento),
      clienteNumeroDocumento: Value(clienteNumeroDocumento),
      clienteRazonSocial: Value(clienteRazonSocial),
      clienteDireccion: clienteDireccion == null && nullToAbsent
          ? const Value.absent()
          : Value(clienteDireccion),
      clienteTelefono: clienteTelefono == null && nullToAbsent
          ? const Value.absent()
          : Value(clienteTelefono),
      clienteEmail: clienteEmail == null && nullToAbsent
          ? const Value.absent()
          : Value(clienteEmail),
      observaciones: observaciones == null && nullToAbsent
          ? const Value.absent()
          : Value(observaciones),
      estadoSunat: Value(estadoSunat),
      mensajeSunat: mensajeSunat == null && nullToAbsent
          ? const Value.absent()
          : Value(mensajeSunat),
      xmlGenerado: xmlGenerado == null && nullToAbsent
          ? const Value.absent()
          : Value(xmlGenerado),
      cdrRecibido: cdrRecibido == null && nullToAbsent
          ? const Value.absent()
          : Value(cdrRecibido),
      hashCodigo: hashCodigo == null && nullToAbsent
          ? const Value.absent()
          : Value(hashCodigo),
      ticket: ticket == null && nullToAbsent
          ? const Value.absent()
          : Value(ticket),
      motivoNota: motivoNota == null && nullToAbsent
          ? const Value.absent()
          : Value(motivoNota),
      documentoAfectado: documentoAfectado == null && nullToAbsent
          ? const Value.absent()
          : Value(documentoAfectado),
      tipoDocumentoAfectado: tipoDocumentoAfectado == null && nullToAbsent
          ? const Value.absent()
          : Value(tipoDocumentoAfectado),
      importeTotal: Value(importeTotal),
      creadoEn: Value(creadoEn),
      actualizadoEn: Value(actualizadoEn),
    );
  }

  factory ComprobanteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ComprobanteRow(
      id: serializer.fromJson<int>(json['id']),
      tipo: $ComprobantesTablaTable.$convertertipo.fromJson(
        serializer.fromJson<String>(json['tipo']),
      ),
      serie: serializer.fromJson<String>(json['serie']),
      correlativo: serializer.fromJson<int>(json['correlativo']),
      fechaEmision: serializer.fromJson<DateTime>(json['fechaEmision']),
      fechaVencimiento: serializer.fromJson<DateTime?>(
        json['fechaVencimiento'],
      ),
      moneda: $ComprobantesTablaTable.$convertermoneda.fromJson(
        serializer.fromJson<String>(json['moneda']),
      ),
      formaPago: $ComprobantesTablaTable.$converterformaPago.fromJson(
        serializer.fromJson<String>(json['formaPago']),
      ),
      clienteId: serializer.fromJson<int?>(json['clienteId']),
      clienteTipoDocumento: $ComprobantesTablaTable
          .$converterclienteTipoDocumento
          .fromJson(serializer.fromJson<String>(json['clienteTipoDocumento'])),
      clienteNumeroDocumento: serializer.fromJson<String>(
        json['clienteNumeroDocumento'],
      ),
      clienteRazonSocial: serializer.fromJson<String>(
        json['clienteRazonSocial'],
      ),
      clienteDireccion: serializer.fromJson<String?>(json['clienteDireccion']),
      clienteTelefono: serializer.fromJson<String?>(json['clienteTelefono']),
      clienteEmail: serializer.fromJson<String?>(json['clienteEmail']),
      observaciones: serializer.fromJson<String?>(json['observaciones']),
      estadoSunat: $ComprobantesTablaTable.$converterestadoSunat.fromJson(
        serializer.fromJson<String>(json['estadoSunat']),
      ),
      mensajeSunat: serializer.fromJson<String?>(json['mensajeSunat']),
      xmlGenerado: serializer.fromJson<String?>(json['xmlGenerado']),
      cdrRecibido: serializer.fromJson<String?>(json['cdrRecibido']),
      hashCodigo: serializer.fromJson<String?>(json['hashCodigo']),
      ticket: serializer.fromJson<String?>(json['ticket']),
      motivoNota: $ComprobantesTablaTable.$convertermotivoNotan.fromJson(
        serializer.fromJson<String?>(json['motivoNota']),
      ),
      documentoAfectado: serializer.fromJson<String?>(
        json['documentoAfectado'],
      ),
      tipoDocumentoAfectado: $ComprobantesTablaTable
          .$convertertipoDocumentoAfectadon
          .fromJson(
            serializer.fromJson<String?>(json['tipoDocumentoAfectado']),
          ),
      importeTotal: serializer.fromJson<double>(json['importeTotal']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
      actualizadoEn: serializer.fromJson<DateTime>(json['actualizadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tipo': serializer.toJson<String>(
        $ComprobantesTablaTable.$convertertipo.toJson(tipo),
      ),
      'serie': serializer.toJson<String>(serie),
      'correlativo': serializer.toJson<int>(correlativo),
      'fechaEmision': serializer.toJson<DateTime>(fechaEmision),
      'fechaVencimiento': serializer.toJson<DateTime?>(fechaVencimiento),
      'moneda': serializer.toJson<String>(
        $ComprobantesTablaTable.$convertermoneda.toJson(moneda),
      ),
      'formaPago': serializer.toJson<String>(
        $ComprobantesTablaTable.$converterformaPago.toJson(formaPago),
      ),
      'clienteId': serializer.toJson<int?>(clienteId),
      'clienteTipoDocumento': serializer.toJson<String>(
        $ComprobantesTablaTable.$converterclienteTipoDocumento.toJson(
          clienteTipoDocumento,
        ),
      ),
      'clienteNumeroDocumento': serializer.toJson<String>(
        clienteNumeroDocumento,
      ),
      'clienteRazonSocial': serializer.toJson<String>(clienteRazonSocial),
      'clienteDireccion': serializer.toJson<String?>(clienteDireccion),
      'clienteTelefono': serializer.toJson<String?>(clienteTelefono),
      'clienteEmail': serializer.toJson<String?>(clienteEmail),
      'observaciones': serializer.toJson<String?>(observaciones),
      'estadoSunat': serializer.toJson<String>(
        $ComprobantesTablaTable.$converterestadoSunat.toJson(estadoSunat),
      ),
      'mensajeSunat': serializer.toJson<String?>(mensajeSunat),
      'xmlGenerado': serializer.toJson<String?>(xmlGenerado),
      'cdrRecibido': serializer.toJson<String?>(cdrRecibido),
      'hashCodigo': serializer.toJson<String?>(hashCodigo),
      'ticket': serializer.toJson<String?>(ticket),
      'motivoNota': serializer.toJson<String?>(
        $ComprobantesTablaTable.$convertermotivoNotan.toJson(motivoNota),
      ),
      'documentoAfectado': serializer.toJson<String?>(documentoAfectado),
      'tipoDocumentoAfectado': serializer.toJson<String?>(
        $ComprobantesTablaTable.$convertertipoDocumentoAfectadon.toJson(
          tipoDocumentoAfectado,
        ),
      ),
      'importeTotal': serializer.toJson<double>(importeTotal),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
      'actualizadoEn': serializer.toJson<DateTime>(actualizadoEn),
    };
  }

  ComprobanteRow copyWith({
    int? id,
    TipoComprobante? tipo,
    String? serie,
    int? correlativo,
    DateTime? fechaEmision,
    Value<DateTime?> fechaVencimiento = const Value.absent(),
    Moneda? moneda,
    FormaPago? formaPago,
    Value<int?> clienteId = const Value.absent(),
    TipoDocumentoIdentidad? clienteTipoDocumento,
    String? clienteNumeroDocumento,
    String? clienteRazonSocial,
    Value<String?> clienteDireccion = const Value.absent(),
    Value<String?> clienteTelefono = const Value.absent(),
    Value<String?> clienteEmail = const Value.absent(),
    Value<String?> observaciones = const Value.absent(),
    EstadoSunat? estadoSunat,
    Value<String?> mensajeSunat = const Value.absent(),
    Value<String?> xmlGenerado = const Value.absent(),
    Value<String?> cdrRecibido = const Value.absent(),
    Value<String?> hashCodigo = const Value.absent(),
    Value<String?> ticket = const Value.absent(),
    Value<MotivoNotaCredito?> motivoNota = const Value.absent(),
    Value<String?> documentoAfectado = const Value.absent(),
    Value<TipoComprobante?> tipoDocumentoAfectado = const Value.absent(),
    double? importeTotal,
    DateTime? creadoEn,
    DateTime? actualizadoEn,
  }) => ComprobanteRow(
    id: id ?? this.id,
    tipo: tipo ?? this.tipo,
    serie: serie ?? this.serie,
    correlativo: correlativo ?? this.correlativo,
    fechaEmision: fechaEmision ?? this.fechaEmision,
    fechaVencimiento: fechaVencimiento.present
        ? fechaVencimiento.value
        : this.fechaVencimiento,
    moneda: moneda ?? this.moneda,
    formaPago: formaPago ?? this.formaPago,
    clienteId: clienteId.present ? clienteId.value : this.clienteId,
    clienteTipoDocumento: clienteTipoDocumento ?? this.clienteTipoDocumento,
    clienteNumeroDocumento:
        clienteNumeroDocumento ?? this.clienteNumeroDocumento,
    clienteRazonSocial: clienteRazonSocial ?? this.clienteRazonSocial,
    clienteDireccion: clienteDireccion.present
        ? clienteDireccion.value
        : this.clienteDireccion,
    clienteTelefono: clienteTelefono.present
        ? clienteTelefono.value
        : this.clienteTelefono,
    clienteEmail: clienteEmail.present ? clienteEmail.value : this.clienteEmail,
    observaciones: observaciones.present
        ? observaciones.value
        : this.observaciones,
    estadoSunat: estadoSunat ?? this.estadoSunat,
    mensajeSunat: mensajeSunat.present ? mensajeSunat.value : this.mensajeSunat,
    xmlGenerado: xmlGenerado.present ? xmlGenerado.value : this.xmlGenerado,
    cdrRecibido: cdrRecibido.present ? cdrRecibido.value : this.cdrRecibido,
    hashCodigo: hashCodigo.present ? hashCodigo.value : this.hashCodigo,
    ticket: ticket.present ? ticket.value : this.ticket,
    motivoNota: motivoNota.present ? motivoNota.value : this.motivoNota,
    documentoAfectado: documentoAfectado.present
        ? documentoAfectado.value
        : this.documentoAfectado,
    tipoDocumentoAfectado: tipoDocumentoAfectado.present
        ? tipoDocumentoAfectado.value
        : this.tipoDocumentoAfectado,
    importeTotal: importeTotal ?? this.importeTotal,
    creadoEn: creadoEn ?? this.creadoEn,
    actualizadoEn: actualizadoEn ?? this.actualizadoEn,
  );
  ComprobanteRow copyWithCompanion(ComprobantesTablaCompanion data) {
    return ComprobanteRow(
      id: data.id.present ? data.id.value : this.id,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      serie: data.serie.present ? data.serie.value : this.serie,
      correlativo: data.correlativo.present
          ? data.correlativo.value
          : this.correlativo,
      fechaEmision: data.fechaEmision.present
          ? data.fechaEmision.value
          : this.fechaEmision,
      fechaVencimiento: data.fechaVencimiento.present
          ? data.fechaVencimiento.value
          : this.fechaVencimiento,
      moneda: data.moneda.present ? data.moneda.value : this.moneda,
      formaPago: data.formaPago.present ? data.formaPago.value : this.formaPago,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      clienteTipoDocumento: data.clienteTipoDocumento.present
          ? data.clienteTipoDocumento.value
          : this.clienteTipoDocumento,
      clienteNumeroDocumento: data.clienteNumeroDocumento.present
          ? data.clienteNumeroDocumento.value
          : this.clienteNumeroDocumento,
      clienteRazonSocial: data.clienteRazonSocial.present
          ? data.clienteRazonSocial.value
          : this.clienteRazonSocial,
      clienteDireccion: data.clienteDireccion.present
          ? data.clienteDireccion.value
          : this.clienteDireccion,
      clienteTelefono: data.clienteTelefono.present
          ? data.clienteTelefono.value
          : this.clienteTelefono,
      clienteEmail: data.clienteEmail.present
          ? data.clienteEmail.value
          : this.clienteEmail,
      observaciones: data.observaciones.present
          ? data.observaciones.value
          : this.observaciones,
      estadoSunat: data.estadoSunat.present
          ? data.estadoSunat.value
          : this.estadoSunat,
      mensajeSunat: data.mensajeSunat.present
          ? data.mensajeSunat.value
          : this.mensajeSunat,
      xmlGenerado: data.xmlGenerado.present
          ? data.xmlGenerado.value
          : this.xmlGenerado,
      cdrRecibido: data.cdrRecibido.present
          ? data.cdrRecibido.value
          : this.cdrRecibido,
      hashCodigo: data.hashCodigo.present
          ? data.hashCodigo.value
          : this.hashCodigo,
      ticket: data.ticket.present ? data.ticket.value : this.ticket,
      motivoNota: data.motivoNota.present
          ? data.motivoNota.value
          : this.motivoNota,
      documentoAfectado: data.documentoAfectado.present
          ? data.documentoAfectado.value
          : this.documentoAfectado,
      tipoDocumentoAfectado: data.tipoDocumentoAfectado.present
          ? data.tipoDocumentoAfectado.value
          : this.tipoDocumentoAfectado,
      importeTotal: data.importeTotal.present
          ? data.importeTotal.value
          : this.importeTotal,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
      actualizadoEn: data.actualizadoEn.present
          ? data.actualizadoEn.value
          : this.actualizadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ComprobanteRow(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('serie: $serie, ')
          ..write('correlativo: $correlativo, ')
          ..write('fechaEmision: $fechaEmision, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('moneda: $moneda, ')
          ..write('formaPago: $formaPago, ')
          ..write('clienteId: $clienteId, ')
          ..write('clienteTipoDocumento: $clienteTipoDocumento, ')
          ..write('clienteNumeroDocumento: $clienteNumeroDocumento, ')
          ..write('clienteRazonSocial: $clienteRazonSocial, ')
          ..write('clienteDireccion: $clienteDireccion, ')
          ..write('clienteTelefono: $clienteTelefono, ')
          ..write('clienteEmail: $clienteEmail, ')
          ..write('observaciones: $observaciones, ')
          ..write('estadoSunat: $estadoSunat, ')
          ..write('mensajeSunat: $mensajeSunat, ')
          ..write('xmlGenerado: $xmlGenerado, ')
          ..write('cdrRecibido: $cdrRecibido, ')
          ..write('hashCodigo: $hashCodigo, ')
          ..write('ticket: $ticket, ')
          ..write('motivoNota: $motivoNota, ')
          ..write('documentoAfectado: $documentoAfectado, ')
          ..write('tipoDocumentoAfectado: $tipoDocumentoAfectado, ')
          ..write('importeTotal: $importeTotal, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hashAll([
    id,
    tipo,
    serie,
    correlativo,
    fechaEmision,
    fechaVencimiento,
    moneda,
    formaPago,
    clienteId,
    clienteTipoDocumento,
    clienteNumeroDocumento,
    clienteRazonSocial,
    clienteDireccion,
    clienteTelefono,
    clienteEmail,
    observaciones,
    estadoSunat,
    mensajeSunat,
    xmlGenerado,
    cdrRecibido,
    hashCodigo,
    ticket,
    motivoNota,
    documentoAfectado,
    tipoDocumentoAfectado,
    importeTotal,
    creadoEn,
    actualizadoEn,
  ]);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ComprobanteRow &&
          other.id == this.id &&
          other.tipo == this.tipo &&
          other.serie == this.serie &&
          other.correlativo == this.correlativo &&
          other.fechaEmision == this.fechaEmision &&
          other.fechaVencimiento == this.fechaVencimiento &&
          other.moneda == this.moneda &&
          other.formaPago == this.formaPago &&
          other.clienteId == this.clienteId &&
          other.clienteTipoDocumento == this.clienteTipoDocumento &&
          other.clienteNumeroDocumento == this.clienteNumeroDocumento &&
          other.clienteRazonSocial == this.clienteRazonSocial &&
          other.clienteDireccion == this.clienteDireccion &&
          other.clienteTelefono == this.clienteTelefono &&
          other.clienteEmail == this.clienteEmail &&
          other.observaciones == this.observaciones &&
          other.estadoSunat == this.estadoSunat &&
          other.mensajeSunat == this.mensajeSunat &&
          other.xmlGenerado == this.xmlGenerado &&
          other.cdrRecibido == this.cdrRecibido &&
          other.hashCodigo == this.hashCodigo &&
          other.ticket == this.ticket &&
          other.motivoNota == this.motivoNota &&
          other.documentoAfectado == this.documentoAfectado &&
          other.tipoDocumentoAfectado == this.tipoDocumentoAfectado &&
          other.importeTotal == this.importeTotal &&
          other.creadoEn == this.creadoEn &&
          other.actualizadoEn == this.actualizadoEn);
}

class ComprobantesTablaCompanion extends UpdateCompanion<ComprobanteRow> {
  final Value<int> id;
  final Value<TipoComprobante> tipo;
  final Value<String> serie;
  final Value<int> correlativo;
  final Value<DateTime> fechaEmision;
  final Value<DateTime?> fechaVencimiento;
  final Value<Moneda> moneda;
  final Value<FormaPago> formaPago;
  final Value<int?> clienteId;
  final Value<TipoDocumentoIdentidad> clienteTipoDocumento;
  final Value<String> clienteNumeroDocumento;
  final Value<String> clienteRazonSocial;
  final Value<String?> clienteDireccion;
  final Value<String?> clienteTelefono;
  final Value<String?> clienteEmail;
  final Value<String?> observaciones;
  final Value<EstadoSunat> estadoSunat;
  final Value<String?> mensajeSunat;
  final Value<String?> xmlGenerado;
  final Value<String?> cdrRecibido;
  final Value<String?> hashCodigo;
  final Value<String?> ticket;
  final Value<MotivoNotaCredito?> motivoNota;
  final Value<String?> documentoAfectado;
  final Value<TipoComprobante?> tipoDocumentoAfectado;
  final Value<double> importeTotal;
  final Value<DateTime> creadoEn;
  final Value<DateTime> actualizadoEn;
  const ComprobantesTablaCompanion({
    this.id = const Value.absent(),
    this.tipo = const Value.absent(),
    this.serie = const Value.absent(),
    this.correlativo = const Value.absent(),
    this.fechaEmision = const Value.absent(),
    this.fechaVencimiento = const Value.absent(),
    this.moneda = const Value.absent(),
    this.formaPago = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.clienteTipoDocumento = const Value.absent(),
    this.clienteNumeroDocumento = const Value.absent(),
    this.clienteRazonSocial = const Value.absent(),
    this.clienteDireccion = const Value.absent(),
    this.clienteTelefono = const Value.absent(),
    this.clienteEmail = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.estadoSunat = const Value.absent(),
    this.mensajeSunat = const Value.absent(),
    this.xmlGenerado = const Value.absent(),
    this.cdrRecibido = const Value.absent(),
    this.hashCodigo = const Value.absent(),
    this.ticket = const Value.absent(),
    this.motivoNota = const Value.absent(),
    this.documentoAfectado = const Value.absent(),
    this.tipoDocumentoAfectado = const Value.absent(),
    this.importeTotal = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
  });
  ComprobantesTablaCompanion.insert({
    this.id = const Value.absent(),
    required TipoComprobante tipo,
    required String serie,
    required int correlativo,
    required DateTime fechaEmision,
    this.fechaVencimiento = const Value.absent(),
    required Moneda moneda,
    required FormaPago formaPago,
    this.clienteId = const Value.absent(),
    required TipoDocumentoIdentidad clienteTipoDocumento,
    required String clienteNumeroDocumento,
    required String clienteRazonSocial,
    this.clienteDireccion = const Value.absent(),
    this.clienteTelefono = const Value.absent(),
    this.clienteEmail = const Value.absent(),
    this.observaciones = const Value.absent(),
    required EstadoSunat estadoSunat,
    this.mensajeSunat = const Value.absent(),
    this.xmlGenerado = const Value.absent(),
    this.cdrRecibido = const Value.absent(),
    this.hashCodigo = const Value.absent(),
    this.ticket = const Value.absent(),
    this.motivoNota = const Value.absent(),
    this.documentoAfectado = const Value.absent(),
    this.tipoDocumentoAfectado = const Value.absent(),
    this.importeTotal = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
  }) : tipo = Value(tipo),
       serie = Value(serie),
       correlativo = Value(correlativo),
       fechaEmision = Value(fechaEmision),
       moneda = Value(moneda),
       formaPago = Value(formaPago),
       clienteTipoDocumento = Value(clienteTipoDocumento),
       clienteNumeroDocumento = Value(clienteNumeroDocumento),
       clienteRazonSocial = Value(clienteRazonSocial),
       estadoSunat = Value(estadoSunat);
  static Insertable<ComprobanteRow> custom({
    Expression<int>? id,
    Expression<String>? tipo,
    Expression<String>? serie,
    Expression<int>? correlativo,
    Expression<DateTime>? fechaEmision,
    Expression<DateTime>? fechaVencimiento,
    Expression<String>? moneda,
    Expression<String>? formaPago,
    Expression<int>? clienteId,
    Expression<String>? clienteTipoDocumento,
    Expression<String>? clienteNumeroDocumento,
    Expression<String>? clienteRazonSocial,
    Expression<String>? clienteDireccion,
    Expression<String>? clienteTelefono,
    Expression<String>? clienteEmail,
    Expression<String>? observaciones,
    Expression<String>? estadoSunat,
    Expression<String>? mensajeSunat,
    Expression<String>? xmlGenerado,
    Expression<String>? cdrRecibido,
    Expression<String>? hashCodigo,
    Expression<String>? ticket,
    Expression<String>? motivoNota,
    Expression<String>? documentoAfectado,
    Expression<String>? tipoDocumentoAfectado,
    Expression<double>? importeTotal,
    Expression<DateTime>? creadoEn,
    Expression<DateTime>? actualizadoEn,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tipo != null) 'tipo': tipo,
      if (serie != null) 'serie': serie,
      if (correlativo != null) 'correlativo': correlativo,
      if (fechaEmision != null) 'fecha_emision': fechaEmision,
      if (fechaVencimiento != null) 'fecha_vencimiento': fechaVencimiento,
      if (moneda != null) 'moneda': moneda,
      if (formaPago != null) 'forma_pago': formaPago,
      if (clienteId != null) 'cliente_id': clienteId,
      if (clienteTipoDocumento != null)
        'cliente_tipo_documento': clienteTipoDocumento,
      if (clienteNumeroDocumento != null)
        'cliente_numero_documento': clienteNumeroDocumento,
      if (clienteRazonSocial != null)
        'cliente_razon_social': clienteRazonSocial,
      if (clienteDireccion != null) 'cliente_direccion': clienteDireccion,
      if (clienteTelefono != null) 'cliente_telefono': clienteTelefono,
      if (clienteEmail != null) 'cliente_email': clienteEmail,
      if (observaciones != null) 'observaciones': observaciones,
      if (estadoSunat != null) 'estado_sunat': estadoSunat,
      if (mensajeSunat != null) 'mensaje_sunat': mensajeSunat,
      if (xmlGenerado != null) 'xml_generado': xmlGenerado,
      if (cdrRecibido != null) 'cdr_recibido': cdrRecibido,
      if (hashCodigo != null) 'hash_codigo': hashCodigo,
      if (ticket != null) 'ticket': ticket,
      if (motivoNota != null) 'motivo_nota': motivoNota,
      if (documentoAfectado != null) 'documento_afectado': documentoAfectado,
      if (tipoDocumentoAfectado != null)
        'tipo_documento_afectado': tipoDocumentoAfectado,
      if (importeTotal != null) 'importe_total': importeTotal,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (actualizadoEn != null) 'actualizado_en': actualizadoEn,
    });
  }

  ComprobantesTablaCompanion copyWith({
    Value<int>? id,
    Value<TipoComprobante>? tipo,
    Value<String>? serie,
    Value<int>? correlativo,
    Value<DateTime>? fechaEmision,
    Value<DateTime?>? fechaVencimiento,
    Value<Moneda>? moneda,
    Value<FormaPago>? formaPago,
    Value<int?>? clienteId,
    Value<TipoDocumentoIdentidad>? clienteTipoDocumento,
    Value<String>? clienteNumeroDocumento,
    Value<String>? clienteRazonSocial,
    Value<String?>? clienteDireccion,
    Value<String?>? clienteTelefono,
    Value<String?>? clienteEmail,
    Value<String?>? observaciones,
    Value<EstadoSunat>? estadoSunat,
    Value<String?>? mensajeSunat,
    Value<String?>? xmlGenerado,
    Value<String?>? cdrRecibido,
    Value<String?>? hashCodigo,
    Value<String?>? ticket,
    Value<MotivoNotaCredito?>? motivoNota,
    Value<String?>? documentoAfectado,
    Value<TipoComprobante?>? tipoDocumentoAfectado,
    Value<double>? importeTotal,
    Value<DateTime>? creadoEn,
    Value<DateTime>? actualizadoEn,
  }) {
    return ComprobantesTablaCompanion(
      id: id ?? this.id,
      tipo: tipo ?? this.tipo,
      serie: serie ?? this.serie,
      correlativo: correlativo ?? this.correlativo,
      fechaEmision: fechaEmision ?? this.fechaEmision,
      fechaVencimiento: fechaVencimiento ?? this.fechaVencimiento,
      moneda: moneda ?? this.moneda,
      formaPago: formaPago ?? this.formaPago,
      clienteId: clienteId ?? this.clienteId,
      clienteTipoDocumento: clienteTipoDocumento ?? this.clienteTipoDocumento,
      clienteNumeroDocumento:
          clienteNumeroDocumento ?? this.clienteNumeroDocumento,
      clienteRazonSocial: clienteRazonSocial ?? this.clienteRazonSocial,
      clienteDireccion: clienteDireccion ?? this.clienteDireccion,
      clienteTelefono: clienteTelefono ?? this.clienteTelefono,
      clienteEmail: clienteEmail ?? this.clienteEmail,
      observaciones: observaciones ?? this.observaciones,
      estadoSunat: estadoSunat ?? this.estadoSunat,
      mensajeSunat: mensajeSunat ?? this.mensajeSunat,
      xmlGenerado: xmlGenerado ?? this.xmlGenerado,
      cdrRecibido: cdrRecibido ?? this.cdrRecibido,
      hashCodigo: hashCodigo ?? this.hashCodigo,
      ticket: ticket ?? this.ticket,
      motivoNota: motivoNota ?? this.motivoNota,
      documentoAfectado: documentoAfectado ?? this.documentoAfectado,
      tipoDocumentoAfectado:
          tipoDocumentoAfectado ?? this.tipoDocumentoAfectado,
      importeTotal: importeTotal ?? this.importeTotal,
      creadoEn: creadoEn ?? this.creadoEn,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(
        $ComprobantesTablaTable.$convertertipo.toSql(tipo.value),
      );
    }
    if (serie.present) {
      map['serie'] = Variable<String>(serie.value);
    }
    if (correlativo.present) {
      map['correlativo'] = Variable<int>(correlativo.value);
    }
    if (fechaEmision.present) {
      map['fecha_emision'] = Variable<DateTime>(fechaEmision.value);
    }
    if (fechaVencimiento.present) {
      map['fecha_vencimiento'] = Variable<DateTime>(fechaVencimiento.value);
    }
    if (moneda.present) {
      map['moneda'] = Variable<String>(
        $ComprobantesTablaTable.$convertermoneda.toSql(moneda.value),
      );
    }
    if (formaPago.present) {
      map['forma_pago'] = Variable<String>(
        $ComprobantesTablaTable.$converterformaPago.toSql(formaPago.value),
      );
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<int>(clienteId.value);
    }
    if (clienteTipoDocumento.present) {
      map['cliente_tipo_documento'] = Variable<String>(
        $ComprobantesTablaTable.$converterclienteTipoDocumento.toSql(
          clienteTipoDocumento.value,
        ),
      );
    }
    if (clienteNumeroDocumento.present) {
      map['cliente_numero_documento'] = Variable<String>(
        clienteNumeroDocumento.value,
      );
    }
    if (clienteRazonSocial.present) {
      map['cliente_razon_social'] = Variable<String>(clienteRazonSocial.value);
    }
    if (clienteDireccion.present) {
      map['cliente_direccion'] = Variable<String>(clienteDireccion.value);
    }
    if (clienteTelefono.present) {
      map['cliente_telefono'] = Variable<String>(clienteTelefono.value);
    }
    if (clienteEmail.present) {
      map['cliente_email'] = Variable<String>(clienteEmail.value);
    }
    if (observaciones.present) {
      map['observaciones'] = Variable<String>(observaciones.value);
    }
    if (estadoSunat.present) {
      map['estado_sunat'] = Variable<String>(
        $ComprobantesTablaTable.$converterestadoSunat.toSql(estadoSunat.value),
      );
    }
    if (mensajeSunat.present) {
      map['mensaje_sunat'] = Variable<String>(mensajeSunat.value);
    }
    if (xmlGenerado.present) {
      map['xml_generado'] = Variable<String>(xmlGenerado.value);
    }
    if (cdrRecibido.present) {
      map['cdr_recibido'] = Variable<String>(cdrRecibido.value);
    }
    if (hashCodigo.present) {
      map['hash_codigo'] = Variable<String>(hashCodigo.value);
    }
    if (ticket.present) {
      map['ticket'] = Variable<String>(ticket.value);
    }
    if (motivoNota.present) {
      map['motivo_nota'] = Variable<String>(
        $ComprobantesTablaTable.$convertermotivoNotan.toSql(motivoNota.value),
      );
    }
    if (documentoAfectado.present) {
      map['documento_afectado'] = Variable<String>(documentoAfectado.value);
    }
    if (tipoDocumentoAfectado.present) {
      map['tipo_documento_afectado'] = Variable<String>(
        $ComprobantesTablaTable.$convertertipoDocumentoAfectadon.toSql(
          tipoDocumentoAfectado.value,
        ),
      );
    }
    if (importeTotal.present) {
      map['importe_total'] = Variable<double>(importeTotal.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (actualizadoEn.present) {
      map['actualizado_en'] = Variable<DateTime>(actualizadoEn.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ComprobantesTablaCompanion(')
          ..write('id: $id, ')
          ..write('tipo: $tipo, ')
          ..write('serie: $serie, ')
          ..write('correlativo: $correlativo, ')
          ..write('fechaEmision: $fechaEmision, ')
          ..write('fechaVencimiento: $fechaVencimiento, ')
          ..write('moneda: $moneda, ')
          ..write('formaPago: $formaPago, ')
          ..write('clienteId: $clienteId, ')
          ..write('clienteTipoDocumento: $clienteTipoDocumento, ')
          ..write('clienteNumeroDocumento: $clienteNumeroDocumento, ')
          ..write('clienteRazonSocial: $clienteRazonSocial, ')
          ..write('clienteDireccion: $clienteDireccion, ')
          ..write('clienteTelefono: $clienteTelefono, ')
          ..write('clienteEmail: $clienteEmail, ')
          ..write('observaciones: $observaciones, ')
          ..write('estadoSunat: $estadoSunat, ')
          ..write('mensajeSunat: $mensajeSunat, ')
          ..write('xmlGenerado: $xmlGenerado, ')
          ..write('cdrRecibido: $cdrRecibido, ')
          ..write('hashCodigo: $hashCodigo, ')
          ..write('ticket: $ticket, ')
          ..write('motivoNota: $motivoNota, ')
          ..write('documentoAfectado: $documentoAfectado, ')
          ..write('tipoDocumentoAfectado: $tipoDocumentoAfectado, ')
          ..write('importeTotal: $importeTotal, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }
}

class $ItemsComprobanteTablaTable extends ItemsComprobanteTabla
    with TableInfo<$ItemsComprobanteTablaTable, ItemComprobanteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ItemsComprobanteTablaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _comprobanteIdMeta = const VerificationMeta(
    'comprobanteId',
  );
  @override
  late final GeneratedColumn<int> comprobanteId = GeneratedColumn<int>(
    'comprobante_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES comprobantes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
    'orden',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
    'codigo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<UnidadMedida, String>
  unidadMedida =
      GeneratedColumn<String>(
        'unidad_medida',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<UnidadMedida>(
        $ItemsComprobanteTablaTable.$converterunidadMedida,
      );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<double> cantidad = GeneratedColumn<double>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valorUnitarioMeta = const VerificationMeta(
    'valorUnitario',
  );
  @override
  late final GeneratedColumn<double> valorUnitario = GeneratedColumn<double>(
    'valor_unitario',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TipoAfectacionIgv, String>
  tipoAfectacionIgv =
      GeneratedColumn<String>(
        'tipo_afectacion_igv',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TipoAfectacionIgv>(
        $ItemsComprobanteTablaTable.$convertertipoAfectacionIgv,
      );
  static const VerificationMeta _descuentoMeta = const VerificationMeta(
    'descuento',
  );
  @override
  late final GeneratedColumn<double> descuento = GeneratedColumn<double>(
    'descuento',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    comprobanteId,
    orden,
    codigo,
    descripcion,
    unidadMedida,
    cantidad,
    valorUnitario,
    tipoAfectacionIgv,
    descuento,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'items_comprobante';
  @override
  VerificationContext validateIntegrity(
    Insertable<ItemComprobanteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('comprobante_id')) {
      context.handle(
        _comprobanteIdMeta,
        comprobanteId.isAcceptableOrUnknown(
          data['comprobante_id']!,
          _comprobanteIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_comprobanteIdMeta);
    }
    if (data.containsKey('orden')) {
      context.handle(
        _ordenMeta,
        orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta),
      );
    } else if (isInserting) {
      context.missing(_ordenMeta);
    }
    if (data.containsKey('codigo')) {
      context.handle(
        _codigoMeta,
        codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta),
      );
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('valor_unitario')) {
      context.handle(
        _valorUnitarioMeta,
        valorUnitario.isAcceptableOrUnknown(
          data['valor_unitario']!,
          _valorUnitarioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_valorUnitarioMeta);
    }
    if (data.containsKey('descuento')) {
      context.handle(
        _descuentoMeta,
        descuento.isAcceptableOrUnknown(data['descuento']!, _descuentoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ItemComprobanteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ItemComprobanteRow(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      comprobanteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}comprobante_id'],
      )!,
      orden: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden'],
      )!,
      codigo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      unidadMedida: $ItemsComprobanteTablaTable.$converterunidadMedida.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}unidad_medida'],
        )!,
      ),
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cantidad'],
      )!,
      valorUnitario: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}valor_unitario'],
      )!,
      tipoAfectacionIgv: $ItemsComprobanteTablaTable.$convertertipoAfectacionIgv
          .fromSql(
            attachedDatabase.typeMapping.read(
              DriftSqlType.string,
              data['${effectivePrefix}tipo_afectacion_igv'],
            )!,
          ),
      descuento: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}descuento'],
      )!,
    );
  }

  @override
  $ItemsComprobanteTablaTable createAlias(String alias) {
    return $ItemsComprobanteTablaTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<UnidadMedida, String, String>
  $converterunidadMedida = const UnidadMedidaConverter();
  static JsonTypeConverter2<TipoAfectacionIgv, String, String>
  $convertertipoAfectacionIgv = const TipoAfectacionIgvConverter();
}

class ItemComprobanteRow extends DataClass
    implements Insertable<ItemComprobanteRow> {
  final int id;
  final int comprobanteId;
  final int orden;
  final String codigo;
  final String descripcion;
  final UnidadMedida unidadMedida;
  final double cantidad;
  final double valorUnitario;
  final TipoAfectacionIgv tipoAfectacionIgv;
  final double descuento;
  const ItemComprobanteRow({
    required this.id,
    required this.comprobanteId,
    required this.orden,
    required this.codigo,
    required this.descripcion,
    required this.unidadMedida,
    required this.cantidad,
    required this.valorUnitario,
    required this.tipoAfectacionIgv,
    required this.descuento,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['comprobante_id'] = Variable<int>(comprobanteId);
    map['orden'] = Variable<int>(orden);
    map['codigo'] = Variable<String>(codigo);
    map['descripcion'] = Variable<String>(descripcion);
    {
      map['unidad_medida'] = Variable<String>(
        $ItemsComprobanteTablaTable.$converterunidadMedida.toSql(unidadMedida),
      );
    }
    map['cantidad'] = Variable<double>(cantidad);
    map['valor_unitario'] = Variable<double>(valorUnitario);
    {
      map['tipo_afectacion_igv'] = Variable<String>(
        $ItemsComprobanteTablaTable.$convertertipoAfectacionIgv.toSql(
          tipoAfectacionIgv,
        ),
      );
    }
    map['descuento'] = Variable<double>(descuento);
    return map;
  }

  ItemsComprobanteTablaCompanion toCompanion(bool nullToAbsent) {
    return ItemsComprobanteTablaCompanion(
      id: Value(id),
      comprobanteId: Value(comprobanteId),
      orden: Value(orden),
      codigo: Value(codigo),
      descripcion: Value(descripcion),
      unidadMedida: Value(unidadMedida),
      cantidad: Value(cantidad),
      valorUnitario: Value(valorUnitario),
      tipoAfectacionIgv: Value(tipoAfectacionIgv),
      descuento: Value(descuento),
    );
  }

  factory ItemComprobanteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ItemComprobanteRow(
      id: serializer.fromJson<int>(json['id']),
      comprobanteId: serializer.fromJson<int>(json['comprobanteId']),
      orden: serializer.fromJson<int>(json['orden']),
      codigo: serializer.fromJson<String>(json['codigo']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      unidadMedida: $ItemsComprobanteTablaTable.$converterunidadMedida.fromJson(
        serializer.fromJson<String>(json['unidadMedida']),
      ),
      cantidad: serializer.fromJson<double>(json['cantidad']),
      valorUnitario: serializer.fromJson<double>(json['valorUnitario']),
      tipoAfectacionIgv: $ItemsComprobanteTablaTable.$convertertipoAfectacionIgv
          .fromJson(serializer.fromJson<String>(json['tipoAfectacionIgv'])),
      descuento: serializer.fromJson<double>(json['descuento']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'comprobanteId': serializer.toJson<int>(comprobanteId),
      'orden': serializer.toJson<int>(orden),
      'codigo': serializer.toJson<String>(codigo),
      'descripcion': serializer.toJson<String>(descripcion),
      'unidadMedida': serializer.toJson<String>(
        $ItemsComprobanteTablaTable.$converterunidadMedida.toJson(unidadMedida),
      ),
      'cantidad': serializer.toJson<double>(cantidad),
      'valorUnitario': serializer.toJson<double>(valorUnitario),
      'tipoAfectacionIgv': serializer.toJson<String>(
        $ItemsComprobanteTablaTable.$convertertipoAfectacionIgv.toJson(
          tipoAfectacionIgv,
        ),
      ),
      'descuento': serializer.toJson<double>(descuento),
    };
  }

  ItemComprobanteRow copyWith({
    int? id,
    int? comprobanteId,
    int? orden,
    String? codigo,
    String? descripcion,
    UnidadMedida? unidadMedida,
    double? cantidad,
    double? valorUnitario,
    TipoAfectacionIgv? tipoAfectacionIgv,
    double? descuento,
  }) => ItemComprobanteRow(
    id: id ?? this.id,
    comprobanteId: comprobanteId ?? this.comprobanteId,
    orden: orden ?? this.orden,
    codigo: codigo ?? this.codigo,
    descripcion: descripcion ?? this.descripcion,
    unidadMedida: unidadMedida ?? this.unidadMedida,
    cantidad: cantidad ?? this.cantidad,
    valorUnitario: valorUnitario ?? this.valorUnitario,
    tipoAfectacionIgv: tipoAfectacionIgv ?? this.tipoAfectacionIgv,
    descuento: descuento ?? this.descuento,
  );
  ItemComprobanteRow copyWithCompanion(ItemsComprobanteTablaCompanion data) {
    return ItemComprobanteRow(
      id: data.id.present ? data.id.value : this.id,
      comprobanteId: data.comprobanteId.present
          ? data.comprobanteId.value
          : this.comprobanteId,
      orden: data.orden.present ? data.orden.value : this.orden,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      unidadMedida: data.unidadMedida.present
          ? data.unidadMedida.value
          : this.unidadMedida,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      valorUnitario: data.valorUnitario.present
          ? data.valorUnitario.value
          : this.valorUnitario,
      tipoAfectacionIgv: data.tipoAfectacionIgv.present
          ? data.tipoAfectacionIgv.value
          : this.tipoAfectacionIgv,
      descuento: data.descuento.present ? data.descuento.value : this.descuento,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ItemComprobanteRow(')
          ..write('id: $id, ')
          ..write('comprobanteId: $comprobanteId, ')
          ..write('orden: $orden, ')
          ..write('codigo: $codigo, ')
          ..write('descripcion: $descripcion, ')
          ..write('unidadMedida: $unidadMedida, ')
          ..write('cantidad: $cantidad, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('tipoAfectacionIgv: $tipoAfectacionIgv, ')
          ..write('descuento: $descuento')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    comprobanteId,
    orden,
    codigo,
    descripcion,
    unidadMedida,
    cantidad,
    valorUnitario,
    tipoAfectacionIgv,
    descuento,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ItemComprobanteRow &&
          other.id == this.id &&
          other.comprobanteId == this.comprobanteId &&
          other.orden == this.orden &&
          other.codigo == this.codigo &&
          other.descripcion == this.descripcion &&
          other.unidadMedida == this.unidadMedida &&
          other.cantidad == this.cantidad &&
          other.valorUnitario == this.valorUnitario &&
          other.tipoAfectacionIgv == this.tipoAfectacionIgv &&
          other.descuento == this.descuento);
}

class ItemsComprobanteTablaCompanion
    extends UpdateCompanion<ItemComprobanteRow> {
  final Value<int> id;
  final Value<int> comprobanteId;
  final Value<int> orden;
  final Value<String> codigo;
  final Value<String> descripcion;
  final Value<UnidadMedida> unidadMedida;
  final Value<double> cantidad;
  final Value<double> valorUnitario;
  final Value<TipoAfectacionIgv> tipoAfectacionIgv;
  final Value<double> descuento;
  const ItemsComprobanteTablaCompanion({
    this.id = const Value.absent(),
    this.comprobanteId = const Value.absent(),
    this.orden = const Value.absent(),
    this.codigo = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.unidadMedida = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.valorUnitario = const Value.absent(),
    this.tipoAfectacionIgv = const Value.absent(),
    this.descuento = const Value.absent(),
  });
  ItemsComprobanteTablaCompanion.insert({
    this.id = const Value.absent(),
    required int comprobanteId,
    required int orden,
    this.codigo = const Value.absent(),
    required String descripcion,
    required UnidadMedida unidadMedida,
    required double cantidad,
    required double valorUnitario,
    required TipoAfectacionIgv tipoAfectacionIgv,
    this.descuento = const Value.absent(),
  }) : comprobanteId = Value(comprobanteId),
       orden = Value(orden),
       descripcion = Value(descripcion),
       unidadMedida = Value(unidadMedida),
       cantidad = Value(cantidad),
       valorUnitario = Value(valorUnitario),
       tipoAfectacionIgv = Value(tipoAfectacionIgv);
  static Insertable<ItemComprobanteRow> custom({
    Expression<int>? id,
    Expression<int>? comprobanteId,
    Expression<int>? orden,
    Expression<String>? codigo,
    Expression<String>? descripcion,
    Expression<String>? unidadMedida,
    Expression<double>? cantidad,
    Expression<double>? valorUnitario,
    Expression<String>? tipoAfectacionIgv,
    Expression<double>? descuento,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (comprobanteId != null) 'comprobante_id': comprobanteId,
      if (orden != null) 'orden': orden,
      if (codigo != null) 'codigo': codigo,
      if (descripcion != null) 'descripcion': descripcion,
      if (unidadMedida != null) 'unidad_medida': unidadMedida,
      if (cantidad != null) 'cantidad': cantidad,
      if (valorUnitario != null) 'valor_unitario': valorUnitario,
      if (tipoAfectacionIgv != null) 'tipo_afectacion_igv': tipoAfectacionIgv,
      if (descuento != null) 'descuento': descuento,
    });
  }

  ItemsComprobanteTablaCompanion copyWith({
    Value<int>? id,
    Value<int>? comprobanteId,
    Value<int>? orden,
    Value<String>? codigo,
    Value<String>? descripcion,
    Value<UnidadMedida>? unidadMedida,
    Value<double>? cantidad,
    Value<double>? valorUnitario,
    Value<TipoAfectacionIgv>? tipoAfectacionIgv,
    Value<double>? descuento,
  }) {
    return ItemsComprobanteTablaCompanion(
      id: id ?? this.id,
      comprobanteId: comprobanteId ?? this.comprobanteId,
      orden: orden ?? this.orden,
      codigo: codigo ?? this.codigo,
      descripcion: descripcion ?? this.descripcion,
      unidadMedida: unidadMedida ?? this.unidadMedida,
      cantidad: cantidad ?? this.cantidad,
      valorUnitario: valorUnitario ?? this.valorUnitario,
      tipoAfectacionIgv: tipoAfectacionIgv ?? this.tipoAfectacionIgv,
      descuento: descuento ?? this.descuento,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (comprobanteId.present) {
      map['comprobante_id'] = Variable<int>(comprobanteId.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (unidadMedida.present) {
      map['unidad_medida'] = Variable<String>(
        $ItemsComprobanteTablaTable.$converterunidadMedida.toSql(
          unidadMedida.value,
        ),
      );
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<double>(cantidad.value);
    }
    if (valorUnitario.present) {
      map['valor_unitario'] = Variable<double>(valorUnitario.value);
    }
    if (tipoAfectacionIgv.present) {
      map['tipo_afectacion_igv'] = Variable<String>(
        $ItemsComprobanteTablaTable.$convertertipoAfectacionIgv.toSql(
          tipoAfectacionIgv.value,
        ),
      );
    }
    if (descuento.present) {
      map['descuento'] = Variable<double>(descuento.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ItemsComprobanteTablaCompanion(')
          ..write('id: $id, ')
          ..write('comprobanteId: $comprobanteId, ')
          ..write('orden: $orden, ')
          ..write('codigo: $codigo, ')
          ..write('descripcion: $descripcion, ')
          ..write('unidadMedida: $unidadMedida, ')
          ..write('cantidad: $cantidad, ')
          ..write('valorUnitario: $valorUnitario, ')
          ..write('tipoAfectacionIgv: $tipoAfectacionIgv, ')
          ..write('descuento: $descuento')
          ..write(')'))
        .toString();
  }
}

class $CorrelativosTablaTable extends CorrelativosTabla
    with TableInfo<$CorrelativosTablaTable, CorrelativoRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CorrelativosTablaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _serieMeta = const VerificationMeta('serie');
  @override
  late final GeneratedColumn<String> serie = GeneratedColumn<String>(
    'serie',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 4,
      maxTextLength: 4,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TipoComprobante, String> tipo =
      GeneratedColumn<String>(
        'tipo',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TipoComprobante>($CorrelativosTablaTable.$convertertipo);
  static const VerificationMeta _ultimoCorrelativoMeta = const VerificationMeta(
    'ultimoCorrelativo',
  );
  @override
  late final GeneratedColumn<int> ultimoCorrelativo = GeneratedColumn<int>(
    'ultimo_correlativo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [serie, tipo, ultimoCorrelativo];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'correlativos';
  @override
  VerificationContext validateIntegrity(
    Insertable<CorrelativoRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('serie')) {
      context.handle(
        _serieMeta,
        serie.isAcceptableOrUnknown(data['serie']!, _serieMeta),
      );
    } else if (isInserting) {
      context.missing(_serieMeta);
    }
    if (data.containsKey('ultimo_correlativo')) {
      context.handle(
        _ultimoCorrelativoMeta,
        ultimoCorrelativo.isAcceptableOrUnknown(
          data['ultimo_correlativo']!,
          _ultimoCorrelativoMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {serie};
  @override
  CorrelativoRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CorrelativoRow(
      serie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}serie'],
      )!,
      tipo: $CorrelativosTablaTable.$convertertipo.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tipo'],
        )!,
      ),
      ultimoCorrelativo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ultimo_correlativo'],
      )!,
    );
  }

  @override
  $CorrelativosTablaTable createAlias(String alias) {
    return $CorrelativosTablaTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TipoComprobante, String, String> $convertertipo =
      const TipoComprobanteConverter();
}

class CorrelativoRow extends DataClass implements Insertable<CorrelativoRow> {
  final String serie;
  final TipoComprobante tipo;
  final int ultimoCorrelativo;
  const CorrelativoRow({
    required this.serie,
    required this.tipo,
    required this.ultimoCorrelativo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['serie'] = Variable<String>(serie);
    {
      map['tipo'] = Variable<String>(
        $CorrelativosTablaTable.$convertertipo.toSql(tipo),
      );
    }
    map['ultimo_correlativo'] = Variable<int>(ultimoCorrelativo);
    return map;
  }

  CorrelativosTablaCompanion toCompanion(bool nullToAbsent) {
    return CorrelativosTablaCompanion(
      serie: Value(serie),
      tipo: Value(tipo),
      ultimoCorrelativo: Value(ultimoCorrelativo),
    );
  }

  factory CorrelativoRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CorrelativoRow(
      serie: serializer.fromJson<String>(json['serie']),
      tipo: $CorrelativosTablaTable.$convertertipo.fromJson(
        serializer.fromJson<String>(json['tipo']),
      ),
      ultimoCorrelativo: serializer.fromJson<int>(json['ultimoCorrelativo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'serie': serializer.toJson<String>(serie),
      'tipo': serializer.toJson<String>(
        $CorrelativosTablaTable.$convertertipo.toJson(tipo),
      ),
      'ultimoCorrelativo': serializer.toJson<int>(ultimoCorrelativo),
    };
  }

  CorrelativoRow copyWith({
    String? serie,
    TipoComprobante? tipo,
    int? ultimoCorrelativo,
  }) => CorrelativoRow(
    serie: serie ?? this.serie,
    tipo: tipo ?? this.tipo,
    ultimoCorrelativo: ultimoCorrelativo ?? this.ultimoCorrelativo,
  );
  CorrelativoRow copyWithCompanion(CorrelativosTablaCompanion data) {
    return CorrelativoRow(
      serie: data.serie.present ? data.serie.value : this.serie,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      ultimoCorrelativo: data.ultimoCorrelativo.present
          ? data.ultimoCorrelativo.value
          : this.ultimoCorrelativo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CorrelativoRow(')
          ..write('serie: $serie, ')
          ..write('tipo: $tipo, ')
          ..write('ultimoCorrelativo: $ultimoCorrelativo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(serie, tipo, ultimoCorrelativo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CorrelativoRow &&
          other.serie == this.serie &&
          other.tipo == this.tipo &&
          other.ultimoCorrelativo == this.ultimoCorrelativo);
}

class CorrelativosTablaCompanion extends UpdateCompanion<CorrelativoRow> {
  final Value<String> serie;
  final Value<TipoComprobante> tipo;
  final Value<int> ultimoCorrelativo;
  final Value<int> rowid;
  const CorrelativosTablaCompanion({
    this.serie = const Value.absent(),
    this.tipo = const Value.absent(),
    this.ultimoCorrelativo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CorrelativosTablaCompanion.insert({
    required String serie,
    required TipoComprobante tipo,
    this.ultimoCorrelativo = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : serie = Value(serie),
       tipo = Value(tipo);
  static Insertable<CorrelativoRow> custom({
    Expression<String>? serie,
    Expression<String>? tipo,
    Expression<int>? ultimoCorrelativo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (serie != null) 'serie': serie,
      if (tipo != null) 'tipo': tipo,
      if (ultimoCorrelativo != null) 'ultimo_correlativo': ultimoCorrelativo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CorrelativosTablaCompanion copyWith({
    Value<String>? serie,
    Value<TipoComprobante>? tipo,
    Value<int>? ultimoCorrelativo,
    Value<int>? rowid,
  }) {
    return CorrelativosTablaCompanion(
      serie: serie ?? this.serie,
      tipo: tipo ?? this.tipo,
      ultimoCorrelativo: ultimoCorrelativo ?? this.ultimoCorrelativo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (serie.present) {
      map['serie'] = Variable<String>(serie.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(
        $CorrelativosTablaTable.$convertertipo.toSql(tipo.value),
      );
    }
    if (ultimoCorrelativo.present) {
      map['ultimo_correlativo'] = Variable<int>(ultimoCorrelativo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CorrelativosTablaCompanion(')
          ..write('serie: $serie, ')
          ..write('tipo: $tipo, ')
          ..write('ultimoCorrelativo: $ultimoCorrelativo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AjustesTablaTable extends AjustesTabla
    with TableInfo<$AjustesTablaTable, AjusteRow> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AjustesTablaTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _claveMeta = const VerificationMeta('clave');
  @override
  late final GeneratedColumn<String> clave = GeneratedColumn<String>(
    'clave',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<String> valor = GeneratedColumn<String>(
    'valor',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [clave, valor];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ajustes';
  @override
  VerificationContext validateIntegrity(
    Insertable<AjusteRow> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('clave')) {
      context.handle(
        _claveMeta,
        clave.isAcceptableOrUnknown(data['clave']!, _claveMeta),
      );
    } else if (isInserting) {
      context.missing(_claveMeta);
    }
    if (data.containsKey('valor')) {
      context.handle(
        _valorMeta,
        valor.isAcceptableOrUnknown(data['valor']!, _valorMeta),
      );
    } else if (isInserting) {
      context.missing(_valorMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {clave};
  @override
  AjusteRow map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AjusteRow(
      clave: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}clave'],
      )!,
      valor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valor'],
      )!,
    );
  }

  @override
  $AjustesTablaTable createAlias(String alias) {
    return $AjustesTablaTable(attachedDatabase, alias);
  }
}

class AjusteRow extends DataClass implements Insertable<AjusteRow> {
  final String clave;
  final String valor;
  const AjusteRow({required this.clave, required this.valor});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['clave'] = Variable<String>(clave);
    map['valor'] = Variable<String>(valor);
    return map;
  }

  AjustesTablaCompanion toCompanion(bool nullToAbsent) {
    return AjustesTablaCompanion(clave: Value(clave), valor: Value(valor));
  }

  factory AjusteRow.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AjusteRow(
      clave: serializer.fromJson<String>(json['clave']),
      valor: serializer.fromJson<String>(json['valor']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'clave': serializer.toJson<String>(clave),
      'valor': serializer.toJson<String>(valor),
    };
  }

  AjusteRow copyWith({String? clave, String? valor}) =>
      AjusteRow(clave: clave ?? this.clave, valor: valor ?? this.valor);
  AjusteRow copyWithCompanion(AjustesTablaCompanion data) {
    return AjusteRow(
      clave: data.clave.present ? data.clave.value : this.clave,
      valor: data.valor.present ? data.valor.value : this.valor,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AjusteRow(')
          ..write('clave: $clave, ')
          ..write('valor: $valor')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(clave, valor);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AjusteRow &&
          other.clave == this.clave &&
          other.valor == this.valor);
}

class AjustesTablaCompanion extends UpdateCompanion<AjusteRow> {
  final Value<String> clave;
  final Value<String> valor;
  final Value<int> rowid;
  const AjustesTablaCompanion({
    this.clave = const Value.absent(),
    this.valor = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AjustesTablaCompanion.insert({
    required String clave,
    required String valor,
    this.rowid = const Value.absent(),
  }) : clave = Value(clave),
       valor = Value(valor);
  static Insertable<AjusteRow> custom({
    Expression<String>? clave,
    Expression<String>? valor,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (clave != null) 'clave': clave,
      if (valor != null) 'valor': valor,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AjustesTablaCompanion copyWith({
    Value<String>? clave,
    Value<String>? valor,
    Value<int>? rowid,
  }) {
    return AjustesTablaCompanion(
      clave: clave ?? this.clave,
      valor: valor ?? this.valor,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (clave.present) {
      map['clave'] = Variable<String>(clave.value);
    }
    if (valor.present) {
      map['valor'] = Variable<String>(valor.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AjustesTablaCompanion(')
          ..write('clave: $clave, ')
          ..write('valor: $valor, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $EmpresasTablaTable empresasTabla = $EmpresasTablaTable(this);
  late final $ClientesTablaTable clientesTabla = $ClientesTablaTable(this);
  late final $ComprobantesTablaTable comprobantesTabla =
      $ComprobantesTablaTable(this);
  late final $ItemsComprobanteTablaTable itemsComprobanteTabla =
      $ItemsComprobanteTablaTable(this);
  late final $CorrelativosTablaTable correlativosTabla =
      $CorrelativosTablaTable(this);
  late final $AjustesTablaTable ajustesTabla = $AjustesTablaTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    empresasTabla,
    clientesTabla,
    comprobantesTabla,
    itemsComprobanteTabla,
    correlativosTabla,
    ajustesTabla,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'clientes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('comprobantes', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'comprobantes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('items_comprobante', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$EmpresasTablaTableCreateCompanionBuilder =
    EmpresasTablaCompanion Function({
      Value<int> id,
      required String ruc,
      required String razonSocial,
      Value<String> nombreComercial,
      Value<String> ubigeo,
      Value<String> departamento,
      Value<String> provincia,
      Value<String> distrito,
      Value<String> direccion,
      Value<String?> logoPath,
      Value<List<String>> seriesFactura,
      Value<List<String>> seriesBoleta,
    });
typedef $$EmpresasTablaTableUpdateCompanionBuilder =
    EmpresasTablaCompanion Function({
      Value<int> id,
      Value<String> ruc,
      Value<String> razonSocial,
      Value<String> nombreComercial,
      Value<String> ubigeo,
      Value<String> departamento,
      Value<String> provincia,
      Value<String> distrito,
      Value<String> direccion,
      Value<String?> logoPath,
      Value<List<String>> seriesFactura,
      Value<List<String>> seriesBoleta,
    });

class $$EmpresasTablaTableFilterComposer
    extends Composer<_$AppDatabase, $EmpresasTablaTable> {
  $$EmpresasTablaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ruc => $composableBuilder(
    column: $table.ruc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get razonSocial => $composableBuilder(
    column: $table.razonSocial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreComercial => $composableBuilder(
    column: $table.nombreComercial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ubigeo => $composableBuilder(
    column: $table.ubigeo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get departamento => $composableBuilder(
    column: $table.departamento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provincia => $composableBuilder(
    column: $table.provincia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get distrito => $composableBuilder(
    column: $table.distrito,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get seriesFactura => $composableBuilder(
    column: $table.seriesFactura,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnWithTypeConverterFilters<List<String>, List<String>, String>
  get seriesBoleta => $composableBuilder(
    column: $table.seriesBoleta,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );
}

class $$EmpresasTablaTableOrderingComposer
    extends Composer<_$AppDatabase, $EmpresasTablaTable> {
  $$EmpresasTablaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ruc => $composableBuilder(
    column: $table.ruc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get razonSocial => $composableBuilder(
    column: $table.razonSocial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreComercial => $composableBuilder(
    column: $table.nombreComercial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ubigeo => $composableBuilder(
    column: $table.ubigeo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get departamento => $composableBuilder(
    column: $table.departamento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provincia => $composableBuilder(
    column: $table.provincia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get distrito => $composableBuilder(
    column: $table.distrito,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get logoPath => $composableBuilder(
    column: $table.logoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seriesFactura => $composableBuilder(
    column: $table.seriesFactura,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get seriesBoleta => $composableBuilder(
    column: $table.seriesBoleta,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EmpresasTablaTableAnnotationComposer
    extends Composer<_$AppDatabase, $EmpresasTablaTable> {
  $$EmpresasTablaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get ruc =>
      $composableBuilder(column: $table.ruc, builder: (column) => column);

  GeneratedColumn<String> get razonSocial => $composableBuilder(
    column: $table.razonSocial,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nombreComercial => $composableBuilder(
    column: $table.nombreComercial,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ubigeo =>
      $composableBuilder(column: $table.ubigeo, builder: (column) => column);

  GeneratedColumn<String> get departamento => $composableBuilder(
    column: $table.departamento,
    builder: (column) => column,
  );

  GeneratedColumn<String> get provincia =>
      $composableBuilder(column: $table.provincia, builder: (column) => column);

  GeneratedColumn<String> get distrito =>
      $composableBuilder(column: $table.distrito, builder: (column) => column);

  GeneratedColumn<String> get direccion =>
      $composableBuilder(column: $table.direccion, builder: (column) => column);

  GeneratedColumn<String> get logoPath =>
      $composableBuilder(column: $table.logoPath, builder: (column) => column);

  GeneratedColumnWithTypeConverter<List<String>, String> get seriesFactura =>
      $composableBuilder(
        column: $table.seriesFactura,
        builder: (column) => column,
      );

  GeneratedColumnWithTypeConverter<List<String>, String> get seriesBoleta =>
      $composableBuilder(
        column: $table.seriesBoleta,
        builder: (column) => column,
      );
}

class $$EmpresasTablaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EmpresasTablaTable,
          EmpresaRow,
          $$EmpresasTablaTableFilterComposer,
          $$EmpresasTablaTableOrderingComposer,
          $$EmpresasTablaTableAnnotationComposer,
          $$EmpresasTablaTableCreateCompanionBuilder,
          $$EmpresasTablaTableUpdateCompanionBuilder,
          (
            EmpresaRow,
            BaseReferences<_$AppDatabase, $EmpresasTablaTable, EmpresaRow>,
          ),
          EmpresaRow,
          PrefetchHooks Function()
        > {
  $$EmpresasTablaTableTableManager(_$AppDatabase db, $EmpresasTablaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EmpresasTablaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EmpresasTablaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EmpresasTablaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> ruc = const Value.absent(),
                Value<String> razonSocial = const Value.absent(),
                Value<String> nombreComercial = const Value.absent(),
                Value<String> ubigeo = const Value.absent(),
                Value<String> departamento = const Value.absent(),
                Value<String> provincia = const Value.absent(),
                Value<String> distrito = const Value.absent(),
                Value<String> direccion = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<List<String>> seriesFactura = const Value.absent(),
                Value<List<String>> seriesBoleta = const Value.absent(),
              }) => EmpresasTablaCompanion(
                id: id,
                ruc: ruc,
                razonSocial: razonSocial,
                nombreComercial: nombreComercial,
                ubigeo: ubigeo,
                departamento: departamento,
                provincia: provincia,
                distrito: distrito,
                direccion: direccion,
                logoPath: logoPath,
                seriesFactura: seriesFactura,
                seriesBoleta: seriesBoleta,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String ruc,
                required String razonSocial,
                Value<String> nombreComercial = const Value.absent(),
                Value<String> ubigeo = const Value.absent(),
                Value<String> departamento = const Value.absent(),
                Value<String> provincia = const Value.absent(),
                Value<String> distrito = const Value.absent(),
                Value<String> direccion = const Value.absent(),
                Value<String?> logoPath = const Value.absent(),
                Value<List<String>> seriesFactura = const Value.absent(),
                Value<List<String>> seriesBoleta = const Value.absent(),
              }) => EmpresasTablaCompanion.insert(
                id: id,
                ruc: ruc,
                razonSocial: razonSocial,
                nombreComercial: nombreComercial,
                ubigeo: ubigeo,
                departamento: departamento,
                provincia: provincia,
                distrito: distrito,
                direccion: direccion,
                logoPath: logoPath,
                seriesFactura: seriesFactura,
                seriesBoleta: seriesBoleta,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$EmpresasTablaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EmpresasTablaTable,
      EmpresaRow,
      $$EmpresasTablaTableFilterComposer,
      $$EmpresasTablaTableOrderingComposer,
      $$EmpresasTablaTableAnnotationComposer,
      $$EmpresasTablaTableCreateCompanionBuilder,
      $$EmpresasTablaTableUpdateCompanionBuilder,
      (
        EmpresaRow,
        BaseReferences<_$AppDatabase, $EmpresasTablaTable, EmpresaRow>,
      ),
      EmpresaRow,
      PrefetchHooks Function()
    >;
typedef $$ClientesTablaTableCreateCompanionBuilder =
    ClientesTablaCompanion Function({
      Value<int> id,
      required TipoDocumentoIdentidad tipoDocumento,
      required String numeroDocumento,
      required String razonSocialONombres,
      Value<String?> direccion,
      Value<String?> telefono,
      Value<String?> email,
      Value<DateTime> creadoEn,
    });
typedef $$ClientesTablaTableUpdateCompanionBuilder =
    ClientesTablaCompanion Function({
      Value<int> id,
      Value<TipoDocumentoIdentidad> tipoDocumento,
      Value<String> numeroDocumento,
      Value<String> razonSocialONombres,
      Value<String?> direccion,
      Value<String?> telefono,
      Value<String?> email,
      Value<DateTime> creadoEn,
    });

final class $$ClientesTablaTableReferences
    extends BaseReferences<_$AppDatabase, $ClientesTablaTable, ClienteRow> {
  $$ClientesTablaTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$ComprobantesTablaTable, List<ComprobanteRow>>
  _comprobantesTablaRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.comprobantesTabla,
        aliasName: $_aliasNameGenerator(
          db.clientesTabla.id,
          db.comprobantesTabla.clienteId,
        ),
      );

  $$ComprobantesTablaTableProcessedTableManager get comprobantesTablaRefs {
    final manager = $$ComprobantesTablaTableTableManager(
      $_db,
      $_db.comprobantesTabla,
    ).filter((f) => f.clienteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _comprobantesTablaRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientesTablaTableFilterComposer
    extends Composer<_$AppDatabase, $ClientesTablaTable> {
  $$ClientesTablaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    TipoDocumentoIdentidad,
    TipoDocumentoIdentidad,
    String
  >
  get tipoDocumento => $composableBuilder(
    column: $table.tipoDocumento,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get numeroDocumento => $composableBuilder(
    column: $table.numeroDocumento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get razonSocialONombres => $composableBuilder(
    column: $table.razonSocialONombres,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> comprobantesTablaRefs(
    Expression<bool> Function($$ComprobantesTablaTableFilterComposer f) f,
  ) {
    final $$ComprobantesTablaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.comprobantesTabla,
      getReferencedColumn: (t) => t.clienteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComprobantesTablaTableFilterComposer(
            $db: $db,
            $table: $db.comprobantesTabla,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientesTablaTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientesTablaTable> {
  $$ClientesTablaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoDocumento => $composableBuilder(
    column: $table.tipoDocumento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numeroDocumento => $composableBuilder(
    column: $table.numeroDocumento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get razonSocialONombres => $composableBuilder(
    column: $table.razonSocialONombres,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get direccion => $composableBuilder(
    column: $table.direccion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientesTablaTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientesTablaTable> {
  $$ClientesTablaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoDocumentoIdentidad, String>
  get tipoDocumento => $composableBuilder(
    column: $table.tipoDocumento,
    builder: (column) => column,
  );

  GeneratedColumn<String> get numeroDocumento => $composableBuilder(
    column: $table.numeroDocumento,
    builder: (column) => column,
  );

  GeneratedColumn<String> get razonSocialONombres => $composableBuilder(
    column: $table.razonSocialONombres,
    builder: (column) => column,
  );

  GeneratedColumn<String> get direccion =>
      $composableBuilder(column: $table.direccion, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  Expression<T> comprobantesTablaRefs<T extends Object>(
    Expression<T> Function($$ComprobantesTablaTableAnnotationComposer a) f,
  ) {
    final $$ComprobantesTablaTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.comprobantesTabla,
          getReferencedColumn: (t) => t.clienteId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ComprobantesTablaTableAnnotationComposer(
                $db: $db,
                $table: $db.comprobantesTabla,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ClientesTablaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientesTablaTable,
          ClienteRow,
          $$ClientesTablaTableFilterComposer,
          $$ClientesTablaTableOrderingComposer,
          $$ClientesTablaTableAnnotationComposer,
          $$ClientesTablaTableCreateCompanionBuilder,
          $$ClientesTablaTableUpdateCompanionBuilder,
          (ClienteRow, $$ClientesTablaTableReferences),
          ClienteRow,
          PrefetchHooks Function({bool comprobantesTablaRefs})
        > {
  $$ClientesTablaTableTableManager(_$AppDatabase db, $ClientesTablaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientesTablaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientesTablaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientesTablaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<TipoDocumentoIdentidad> tipoDocumento =
                    const Value.absent(),
                Value<String> numeroDocumento = const Value.absent(),
                Value<String> razonSocialONombres = const Value.absent(),
                Value<String?> direccion = const Value.absent(),
                Value<String?> telefono = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
              }) => ClientesTablaCompanion(
                id: id,
                tipoDocumento: tipoDocumento,
                numeroDocumento: numeroDocumento,
                razonSocialONombres: razonSocialONombres,
                direccion: direccion,
                telefono: telefono,
                email: email,
                creadoEn: creadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required TipoDocumentoIdentidad tipoDocumento,
                required String numeroDocumento,
                required String razonSocialONombres,
                Value<String?> direccion = const Value.absent(),
                Value<String?> telefono = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
              }) => ClientesTablaCompanion.insert(
                id: id,
                tipoDocumento: tipoDocumento,
                numeroDocumento: numeroDocumento,
                razonSocialONombres: razonSocialONombres,
                direccion: direccion,
                telefono: telefono,
                email: email,
                creadoEn: creadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ClientesTablaTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({comprobantesTablaRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (comprobantesTablaRefs) db.comprobantesTabla,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (comprobantesTablaRefs)
                    await $_getPrefetchedData<
                      ClienteRow,
                      $ClientesTablaTable,
                      ComprobanteRow
                    >(
                      currentTable: table,
                      referencedTable: $$ClientesTablaTableReferences
                          ._comprobantesTablaRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ClientesTablaTableReferences(
                            db,
                            table,
                            p0,
                          ).comprobantesTablaRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.clienteId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ClientesTablaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientesTablaTable,
      ClienteRow,
      $$ClientesTablaTableFilterComposer,
      $$ClientesTablaTableOrderingComposer,
      $$ClientesTablaTableAnnotationComposer,
      $$ClientesTablaTableCreateCompanionBuilder,
      $$ClientesTablaTableUpdateCompanionBuilder,
      (ClienteRow, $$ClientesTablaTableReferences),
      ClienteRow,
      PrefetchHooks Function({bool comprobantesTablaRefs})
    >;
typedef $$ComprobantesTablaTableCreateCompanionBuilder =
    ComprobantesTablaCompanion Function({
      Value<int> id,
      required TipoComprobante tipo,
      required String serie,
      required int correlativo,
      required DateTime fechaEmision,
      Value<DateTime?> fechaVencimiento,
      required Moneda moneda,
      required FormaPago formaPago,
      Value<int?> clienteId,
      required TipoDocumentoIdentidad clienteTipoDocumento,
      required String clienteNumeroDocumento,
      required String clienteRazonSocial,
      Value<String?> clienteDireccion,
      Value<String?> clienteTelefono,
      Value<String?> clienteEmail,
      Value<String?> observaciones,
      required EstadoSunat estadoSunat,
      Value<String?> mensajeSunat,
      Value<String?> xmlGenerado,
      Value<String?> cdrRecibido,
      Value<String?> hashCodigo,
      Value<String?> ticket,
      Value<MotivoNotaCredito?> motivoNota,
      Value<String?> documentoAfectado,
      Value<TipoComprobante?> tipoDocumentoAfectado,
      Value<double> importeTotal,
      Value<DateTime> creadoEn,
      Value<DateTime> actualizadoEn,
    });
typedef $$ComprobantesTablaTableUpdateCompanionBuilder =
    ComprobantesTablaCompanion Function({
      Value<int> id,
      Value<TipoComprobante> tipo,
      Value<String> serie,
      Value<int> correlativo,
      Value<DateTime> fechaEmision,
      Value<DateTime?> fechaVencimiento,
      Value<Moneda> moneda,
      Value<FormaPago> formaPago,
      Value<int?> clienteId,
      Value<TipoDocumentoIdentidad> clienteTipoDocumento,
      Value<String> clienteNumeroDocumento,
      Value<String> clienteRazonSocial,
      Value<String?> clienteDireccion,
      Value<String?> clienteTelefono,
      Value<String?> clienteEmail,
      Value<String?> observaciones,
      Value<EstadoSunat> estadoSunat,
      Value<String?> mensajeSunat,
      Value<String?> xmlGenerado,
      Value<String?> cdrRecibido,
      Value<String?> hashCodigo,
      Value<String?> ticket,
      Value<MotivoNotaCredito?> motivoNota,
      Value<String?> documentoAfectado,
      Value<TipoComprobante?> tipoDocumentoAfectado,
      Value<double> importeTotal,
      Value<DateTime> creadoEn,
      Value<DateTime> actualizadoEn,
    });

final class $$ComprobantesTablaTableReferences
    extends
        BaseReferences<_$AppDatabase, $ComprobantesTablaTable, ComprobanteRow> {
  $$ComprobantesTablaTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ClientesTablaTable _clienteIdTable(_$AppDatabase db) =>
      db.clientesTabla.createAlias(
        $_aliasNameGenerator(
          db.comprobantesTabla.clienteId,
          db.clientesTabla.id,
        ),
      );

  $$ClientesTablaTableProcessedTableManager? get clienteId {
    final $_column = $_itemColumn<int>('cliente_id');
    if ($_column == null) return null;
    final manager = $$ClientesTablaTableTableManager(
      $_db,
      $_db.clientesTabla,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clienteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $ItemsComprobanteTablaTable,
    List<ItemComprobanteRow>
  >
  _itemsComprobanteTablaRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.itemsComprobanteTabla,
        aliasName: $_aliasNameGenerator(
          db.comprobantesTabla.id,
          db.itemsComprobanteTabla.comprobanteId,
        ),
      );

  $$ItemsComprobanteTablaTableProcessedTableManager
  get itemsComprobanteTablaRefs {
    final manager = $$ItemsComprobanteTablaTableTableManager(
      $_db,
      $_db.itemsComprobanteTabla,
    ).filter((f) => f.comprobanteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _itemsComprobanteTablaRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ComprobantesTablaTableFilterComposer
    extends Composer<_$AppDatabase, $ComprobantesTablaTable> {
  $$ComprobantesTablaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TipoComprobante, TipoComprobante, String>
  get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get serie => $composableBuilder(
    column: $table.serie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get correlativo => $composableBuilder(
    column: $table.correlativo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaEmision => $composableBuilder(
    column: $table.fechaEmision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaVencimiento => $composableBuilder(
    column: $table.fechaVencimiento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Moneda, Moneda, String> get moneda =>
      $composableBuilder(
        column: $table.moneda,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<FormaPago, FormaPago, String> get formaPago =>
      $composableBuilder(
        column: $table.formaPago,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<
    TipoDocumentoIdentidad,
    TipoDocumentoIdentidad,
    String
  >
  get clienteTipoDocumento => $composableBuilder(
    column: $table.clienteTipoDocumento,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get clienteNumeroDocumento => $composableBuilder(
    column: $table.clienteNumeroDocumento,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clienteRazonSocial => $composableBuilder(
    column: $table.clienteRazonSocial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clienteDireccion => $composableBuilder(
    column: $table.clienteDireccion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clienteTelefono => $composableBuilder(
    column: $table.clienteTelefono,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get clienteEmail => $composableBuilder(
    column: $table.clienteEmail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<EstadoSunat, EstadoSunat, String>
  get estadoSunat => $composableBuilder(
    column: $table.estadoSunat,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get mensajeSunat => $composableBuilder(
    column: $table.mensajeSunat,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get xmlGenerado => $composableBuilder(
    column: $table.xmlGenerado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cdrRecibido => $composableBuilder(
    column: $table.cdrRecibido,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hashCodigo => $composableBuilder(
    column: $table.hashCodigo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ticket => $composableBuilder(
    column: $table.ticket,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MotivoNotaCredito?, MotivoNotaCredito, String>
  get motivoNota => $composableBuilder(
    column: $table.motivoNota,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get documentoAfectado => $composableBuilder(
    column: $table.documentoAfectado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TipoComprobante?, TipoComprobante, String>
  get tipoDocumentoAfectado => $composableBuilder(
    column: $table.tipoDocumentoAfectado,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get importeTotal => $composableBuilder(
    column: $table.importeTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientesTablaTableFilterComposer get clienteId {
    final $$ClientesTablaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clienteId,
      referencedTable: $db.clientesTabla,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientesTablaTableFilterComposer(
            $db: $db,
            $table: $db.clientesTabla,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> itemsComprobanteTablaRefs(
    Expression<bool> Function($$ItemsComprobanteTablaTableFilterComposer f) f,
  ) {
    final $$ItemsComprobanteTablaTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.itemsComprobanteTabla,
          getReferencedColumn: (t) => t.comprobanteId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ItemsComprobanteTablaTableFilterComposer(
                $db: $db,
                $table: $db.itemsComprobanteTabla,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ComprobantesTablaTableOrderingComposer
    extends Composer<_$AppDatabase, $ComprobantesTablaTable> {
  $$ComprobantesTablaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get serie => $composableBuilder(
    column: $table.serie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get correlativo => $composableBuilder(
    column: $table.correlativo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaEmision => $composableBuilder(
    column: $table.fechaEmision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaVencimiento => $composableBuilder(
    column: $table.fechaVencimiento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get moneda => $composableBuilder(
    column: $table.moneda,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get formaPago => $composableBuilder(
    column: $table.formaPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clienteTipoDocumento => $composableBuilder(
    column: $table.clienteTipoDocumento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clienteNumeroDocumento => $composableBuilder(
    column: $table.clienteNumeroDocumento,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clienteRazonSocial => $composableBuilder(
    column: $table.clienteRazonSocial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clienteDireccion => $composableBuilder(
    column: $table.clienteDireccion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clienteTelefono => $composableBuilder(
    column: $table.clienteTelefono,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get clienteEmail => $composableBuilder(
    column: $table.clienteEmail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estadoSunat => $composableBuilder(
    column: $table.estadoSunat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mensajeSunat => $composableBuilder(
    column: $table.mensajeSunat,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get xmlGenerado => $composableBuilder(
    column: $table.xmlGenerado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cdrRecibido => $composableBuilder(
    column: $table.cdrRecibido,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hashCodigo => $composableBuilder(
    column: $table.hashCodigo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ticket => $composableBuilder(
    column: $table.ticket,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivoNota => $composableBuilder(
    column: $table.motivoNota,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get documentoAfectado => $composableBuilder(
    column: $table.documentoAfectado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoDocumentoAfectado => $composableBuilder(
    column: $table.tipoDocumentoAfectado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get importeTotal => $composableBuilder(
    column: $table.importeTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientesTablaTableOrderingComposer get clienteId {
    final $$ClientesTablaTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clienteId,
      referencedTable: $db.clientesTabla,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientesTablaTableOrderingComposer(
            $db: $db,
            $table: $db.clientesTabla,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ComprobantesTablaTableAnnotationComposer
    extends Composer<_$AppDatabase, $ComprobantesTablaTable> {
  $$ComprobantesTablaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoComprobante, String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get serie =>
      $composableBuilder(column: $table.serie, builder: (column) => column);

  GeneratedColumn<int> get correlativo => $composableBuilder(
    column: $table.correlativo,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaEmision => $composableBuilder(
    column: $table.fechaEmision,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaVencimiento => $composableBuilder(
    column: $table.fechaVencimiento,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<Moneda, String> get moneda =>
      $composableBuilder(column: $table.moneda, builder: (column) => column);

  GeneratedColumnWithTypeConverter<FormaPago, String> get formaPago =>
      $composableBuilder(column: $table.formaPago, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoDocumentoIdentidad, String>
  get clienteTipoDocumento => $composableBuilder(
    column: $table.clienteTipoDocumento,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clienteNumeroDocumento => $composableBuilder(
    column: $table.clienteNumeroDocumento,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clienteRazonSocial => $composableBuilder(
    column: $table.clienteRazonSocial,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clienteDireccion => $composableBuilder(
    column: $table.clienteDireccion,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clienteTelefono => $composableBuilder(
    column: $table.clienteTelefono,
    builder: (column) => column,
  );

  GeneratedColumn<String> get clienteEmail => $composableBuilder(
    column: $table.clienteEmail,
    builder: (column) => column,
  );

  GeneratedColumn<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<EstadoSunat, String> get estadoSunat =>
      $composableBuilder(
        column: $table.estadoSunat,
        builder: (column) => column,
      );

  GeneratedColumn<String> get mensajeSunat => $composableBuilder(
    column: $table.mensajeSunat,
    builder: (column) => column,
  );

  GeneratedColumn<String> get xmlGenerado => $composableBuilder(
    column: $table.xmlGenerado,
    builder: (column) => column,
  );

  GeneratedColumn<String> get cdrRecibido => $composableBuilder(
    column: $table.cdrRecibido,
    builder: (column) => column,
  );

  GeneratedColumn<String> get hashCodigo => $composableBuilder(
    column: $table.hashCodigo,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ticket =>
      $composableBuilder(column: $table.ticket, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MotivoNotaCredito?, String> get motivoNota =>
      $composableBuilder(
        column: $table.motivoNota,
        builder: (column) => column,
      );

  GeneratedColumn<String> get documentoAfectado => $composableBuilder(
    column: $table.documentoAfectado,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<TipoComprobante?, String>
  get tipoDocumentoAfectado => $composableBuilder(
    column: $table.tipoDocumentoAfectado,
    builder: (column) => column,
  );

  GeneratedColumn<double> get importeTotal => $composableBuilder(
    column: $table.importeTotal,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  GeneratedColumn<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => column,
  );

  $$ClientesTablaTableAnnotationComposer get clienteId {
    final $$ClientesTablaTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clienteId,
      referencedTable: $db.clientesTabla,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientesTablaTableAnnotationComposer(
            $db: $db,
            $table: $db.clientesTabla,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> itemsComprobanteTablaRefs<T extends Object>(
    Expression<T> Function($$ItemsComprobanteTablaTableAnnotationComposer a) f,
  ) {
    final $$ItemsComprobanteTablaTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.itemsComprobanteTabla,
          getReferencedColumn: (t) => t.comprobanteId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ItemsComprobanteTablaTableAnnotationComposer(
                $db: $db,
                $table: $db.itemsComprobanteTabla,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ComprobantesTablaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ComprobantesTablaTable,
          ComprobanteRow,
          $$ComprobantesTablaTableFilterComposer,
          $$ComprobantesTablaTableOrderingComposer,
          $$ComprobantesTablaTableAnnotationComposer,
          $$ComprobantesTablaTableCreateCompanionBuilder,
          $$ComprobantesTablaTableUpdateCompanionBuilder,
          (ComprobanteRow, $$ComprobantesTablaTableReferences),
          ComprobanteRow,
          PrefetchHooks Function({
            bool clienteId,
            bool itemsComprobanteTablaRefs,
          })
        > {
  $$ComprobantesTablaTableTableManager(
    _$AppDatabase db,
    $ComprobantesTablaTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ComprobantesTablaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ComprobantesTablaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ComprobantesTablaTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<TipoComprobante> tipo = const Value.absent(),
                Value<String> serie = const Value.absent(),
                Value<int> correlativo = const Value.absent(),
                Value<DateTime> fechaEmision = const Value.absent(),
                Value<DateTime?> fechaVencimiento = const Value.absent(),
                Value<Moneda> moneda = const Value.absent(),
                Value<FormaPago> formaPago = const Value.absent(),
                Value<int?> clienteId = const Value.absent(),
                Value<TipoDocumentoIdentidad> clienteTipoDocumento =
                    const Value.absent(),
                Value<String> clienteNumeroDocumento = const Value.absent(),
                Value<String> clienteRazonSocial = const Value.absent(),
                Value<String?> clienteDireccion = const Value.absent(),
                Value<String?> clienteTelefono = const Value.absent(),
                Value<String?> clienteEmail = const Value.absent(),
                Value<String?> observaciones = const Value.absent(),
                Value<EstadoSunat> estadoSunat = const Value.absent(),
                Value<String?> mensajeSunat = const Value.absent(),
                Value<String?> xmlGenerado = const Value.absent(),
                Value<String?> cdrRecibido = const Value.absent(),
                Value<String?> hashCodigo = const Value.absent(),
                Value<String?> ticket = const Value.absent(),
                Value<MotivoNotaCredito?> motivoNota = const Value.absent(),
                Value<String?> documentoAfectado = const Value.absent(),
                Value<TipoComprobante?> tipoDocumentoAfectado =
                    const Value.absent(),
                Value<double> importeTotal = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<DateTime> actualizadoEn = const Value.absent(),
              }) => ComprobantesTablaCompanion(
                id: id,
                tipo: tipo,
                serie: serie,
                correlativo: correlativo,
                fechaEmision: fechaEmision,
                fechaVencimiento: fechaVencimiento,
                moneda: moneda,
                formaPago: formaPago,
                clienteId: clienteId,
                clienteTipoDocumento: clienteTipoDocumento,
                clienteNumeroDocumento: clienteNumeroDocumento,
                clienteRazonSocial: clienteRazonSocial,
                clienteDireccion: clienteDireccion,
                clienteTelefono: clienteTelefono,
                clienteEmail: clienteEmail,
                observaciones: observaciones,
                estadoSunat: estadoSunat,
                mensajeSunat: mensajeSunat,
                xmlGenerado: xmlGenerado,
                cdrRecibido: cdrRecibido,
                hashCodigo: hashCodigo,
                ticket: ticket,
                motivoNota: motivoNota,
                documentoAfectado: documentoAfectado,
                tipoDocumentoAfectado: tipoDocumentoAfectado,
                importeTotal: importeTotal,
                creadoEn: creadoEn,
                actualizadoEn: actualizadoEn,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required TipoComprobante tipo,
                required String serie,
                required int correlativo,
                required DateTime fechaEmision,
                Value<DateTime?> fechaVencimiento = const Value.absent(),
                required Moneda moneda,
                required FormaPago formaPago,
                Value<int?> clienteId = const Value.absent(),
                required TipoDocumentoIdentidad clienteTipoDocumento,
                required String clienteNumeroDocumento,
                required String clienteRazonSocial,
                Value<String?> clienteDireccion = const Value.absent(),
                Value<String?> clienteTelefono = const Value.absent(),
                Value<String?> clienteEmail = const Value.absent(),
                Value<String?> observaciones = const Value.absent(),
                required EstadoSunat estadoSunat,
                Value<String?> mensajeSunat = const Value.absent(),
                Value<String?> xmlGenerado = const Value.absent(),
                Value<String?> cdrRecibido = const Value.absent(),
                Value<String?> hashCodigo = const Value.absent(),
                Value<String?> ticket = const Value.absent(),
                Value<MotivoNotaCredito?> motivoNota = const Value.absent(),
                Value<String?> documentoAfectado = const Value.absent(),
                Value<TipoComprobante?> tipoDocumentoAfectado =
                    const Value.absent(),
                Value<double> importeTotal = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<DateTime> actualizadoEn = const Value.absent(),
              }) => ComprobantesTablaCompanion.insert(
                id: id,
                tipo: tipo,
                serie: serie,
                correlativo: correlativo,
                fechaEmision: fechaEmision,
                fechaVencimiento: fechaVencimiento,
                moneda: moneda,
                formaPago: formaPago,
                clienteId: clienteId,
                clienteTipoDocumento: clienteTipoDocumento,
                clienteNumeroDocumento: clienteNumeroDocumento,
                clienteRazonSocial: clienteRazonSocial,
                clienteDireccion: clienteDireccion,
                clienteTelefono: clienteTelefono,
                clienteEmail: clienteEmail,
                observaciones: observaciones,
                estadoSunat: estadoSunat,
                mensajeSunat: mensajeSunat,
                xmlGenerado: xmlGenerado,
                cdrRecibido: cdrRecibido,
                hashCodigo: hashCodigo,
                ticket: ticket,
                motivoNota: motivoNota,
                documentoAfectado: documentoAfectado,
                tipoDocumentoAfectado: tipoDocumentoAfectado,
                importeTotal: importeTotal,
                creadoEn: creadoEn,
                actualizadoEn: actualizadoEn,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ComprobantesTablaTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({clienteId = false, itemsComprobanteTablaRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (itemsComprobanteTablaRefs) db.itemsComprobanteTabla,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (clienteId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.clienteId,
                                    referencedTable:
                                        $$ComprobantesTablaTableReferences
                                            ._clienteIdTable(db),
                                    referencedColumn:
                                        $$ComprobantesTablaTableReferences
                                            ._clienteIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (itemsComprobanteTablaRefs)
                        await $_getPrefetchedData<
                          ComprobanteRow,
                          $ComprobantesTablaTable,
                          ItemComprobanteRow
                        >(
                          currentTable: table,
                          referencedTable: $$ComprobantesTablaTableReferences
                              ._itemsComprobanteTablaRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ComprobantesTablaTableReferences(
                                db,
                                table,
                                p0,
                              ).itemsComprobanteTablaRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.comprobanteId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ComprobantesTablaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ComprobantesTablaTable,
      ComprobanteRow,
      $$ComprobantesTablaTableFilterComposer,
      $$ComprobantesTablaTableOrderingComposer,
      $$ComprobantesTablaTableAnnotationComposer,
      $$ComprobantesTablaTableCreateCompanionBuilder,
      $$ComprobantesTablaTableUpdateCompanionBuilder,
      (ComprobanteRow, $$ComprobantesTablaTableReferences),
      ComprobanteRow,
      PrefetchHooks Function({bool clienteId, bool itemsComprobanteTablaRefs})
    >;
typedef $$ItemsComprobanteTablaTableCreateCompanionBuilder =
    ItemsComprobanteTablaCompanion Function({
      Value<int> id,
      required int comprobanteId,
      required int orden,
      Value<String> codigo,
      required String descripcion,
      required UnidadMedida unidadMedida,
      required double cantidad,
      required double valorUnitario,
      required TipoAfectacionIgv tipoAfectacionIgv,
      Value<double> descuento,
    });
typedef $$ItemsComprobanteTablaTableUpdateCompanionBuilder =
    ItemsComprobanteTablaCompanion Function({
      Value<int> id,
      Value<int> comprobanteId,
      Value<int> orden,
      Value<String> codigo,
      Value<String> descripcion,
      Value<UnidadMedida> unidadMedida,
      Value<double> cantidad,
      Value<double> valorUnitario,
      Value<TipoAfectacionIgv> tipoAfectacionIgv,
      Value<double> descuento,
    });

final class $$ItemsComprobanteTablaTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ItemsComprobanteTablaTable,
          ItemComprobanteRow
        > {
  $$ItemsComprobanteTablaTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ComprobantesTablaTable _comprobanteIdTable(_$AppDatabase db) =>
      db.comprobantesTabla.createAlias(
        $_aliasNameGenerator(
          db.itemsComprobanteTabla.comprobanteId,
          db.comprobantesTabla.id,
        ),
      );

  $$ComprobantesTablaTableProcessedTableManager get comprobanteId {
    final $_column = $_itemColumn<int>('comprobante_id')!;

    final manager = $$ComprobantesTablaTableTableManager(
      $_db,
      $_db.comprobantesTabla,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_comprobanteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ItemsComprobanteTablaTableFilterComposer
    extends Composer<_$AppDatabase, $ItemsComprobanteTablaTable> {
  $$ItemsComprobanteTablaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<UnidadMedida, UnidadMedida, String>
  get unidadMedida => $composableBuilder(
    column: $table.unidadMedida,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get valorUnitario => $composableBuilder(
    column: $table.valorUnitario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TipoAfectacionIgv, TipoAfectacionIgv, String>
  get tipoAfectacionIgv => $composableBuilder(
    column: $table.tipoAfectacionIgv,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get descuento => $composableBuilder(
    column: $table.descuento,
    builder: (column) => ColumnFilters(column),
  );

  $$ComprobantesTablaTableFilterComposer get comprobanteId {
    final $$ComprobantesTablaTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.comprobanteId,
      referencedTable: $db.comprobantesTabla,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComprobantesTablaTableFilterComposer(
            $db: $db,
            $table: $db.comprobantesTabla,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemsComprobanteTablaTableOrderingComposer
    extends Composer<_$AppDatabase, $ItemsComprobanteTablaTable> {
  $$ItemsComprobanteTablaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unidadMedida => $composableBuilder(
    column: $table.unidadMedida,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get valorUnitario => $composableBuilder(
    column: $table.valorUnitario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipoAfectacionIgv => $composableBuilder(
    column: $table.tipoAfectacionIgv,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get descuento => $composableBuilder(
    column: $table.descuento,
    builder: (column) => ColumnOrderings(column),
  );

  $$ComprobantesTablaTableOrderingComposer get comprobanteId {
    final $$ComprobantesTablaTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.comprobanteId,
      referencedTable: $db.comprobantesTabla,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ComprobantesTablaTableOrderingComposer(
            $db: $db,
            $table: $db.comprobantesTabla,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ItemsComprobanteTablaTableAnnotationComposer
    extends Composer<_$AppDatabase, $ItemsComprobanteTablaTable> {
  $$ItemsComprobanteTablaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get orden =>
      $composableBuilder(column: $table.orden, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<UnidadMedida, String> get unidadMedida =>
      $composableBuilder(
        column: $table.unidadMedida,
        builder: (column) => column,
      );

  GeneratedColumn<double> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<double> get valorUnitario => $composableBuilder(
    column: $table.valorUnitario,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<TipoAfectacionIgv, String>
  get tipoAfectacionIgv => $composableBuilder(
    column: $table.tipoAfectacionIgv,
    builder: (column) => column,
  );

  GeneratedColumn<double> get descuento =>
      $composableBuilder(column: $table.descuento, builder: (column) => column);

  $$ComprobantesTablaTableAnnotationComposer get comprobanteId {
    final $$ComprobantesTablaTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.comprobanteId,
          referencedTable: $db.comprobantesTabla,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ComprobantesTablaTableAnnotationComposer(
                $db: $db,
                $table: $db.comprobantesTabla,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }
}

class $$ItemsComprobanteTablaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ItemsComprobanteTablaTable,
          ItemComprobanteRow,
          $$ItemsComprobanteTablaTableFilterComposer,
          $$ItemsComprobanteTablaTableOrderingComposer,
          $$ItemsComprobanteTablaTableAnnotationComposer,
          $$ItemsComprobanteTablaTableCreateCompanionBuilder,
          $$ItemsComprobanteTablaTableUpdateCompanionBuilder,
          (ItemComprobanteRow, $$ItemsComprobanteTablaTableReferences),
          ItemComprobanteRow,
          PrefetchHooks Function({bool comprobanteId})
        > {
  $$ItemsComprobanteTablaTableTableManager(
    _$AppDatabase db,
    $ItemsComprobanteTablaTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ItemsComprobanteTablaTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ItemsComprobanteTablaTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ItemsComprobanteTablaTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> comprobanteId = const Value.absent(),
                Value<int> orden = const Value.absent(),
                Value<String> codigo = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<UnidadMedida> unidadMedida = const Value.absent(),
                Value<double> cantidad = const Value.absent(),
                Value<double> valorUnitario = const Value.absent(),
                Value<TipoAfectacionIgv> tipoAfectacionIgv =
                    const Value.absent(),
                Value<double> descuento = const Value.absent(),
              }) => ItemsComprobanteTablaCompanion(
                id: id,
                comprobanteId: comprobanteId,
                orden: orden,
                codigo: codigo,
                descripcion: descripcion,
                unidadMedida: unidadMedida,
                cantidad: cantidad,
                valorUnitario: valorUnitario,
                tipoAfectacionIgv: tipoAfectacionIgv,
                descuento: descuento,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int comprobanteId,
                required int orden,
                Value<String> codigo = const Value.absent(),
                required String descripcion,
                required UnidadMedida unidadMedida,
                required double cantidad,
                required double valorUnitario,
                required TipoAfectacionIgv tipoAfectacionIgv,
                Value<double> descuento = const Value.absent(),
              }) => ItemsComprobanteTablaCompanion.insert(
                id: id,
                comprobanteId: comprobanteId,
                orden: orden,
                codigo: codigo,
                descripcion: descripcion,
                unidadMedida: unidadMedida,
                cantidad: cantidad,
                valorUnitario: valorUnitario,
                tipoAfectacionIgv: tipoAfectacionIgv,
                descuento: descuento,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ItemsComprobanteTablaTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({comprobanteId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (comprobanteId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.comprobanteId,
                                referencedTable:
                                    $$ItemsComprobanteTablaTableReferences
                                        ._comprobanteIdTable(db),
                                referencedColumn:
                                    $$ItemsComprobanteTablaTableReferences
                                        ._comprobanteIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ItemsComprobanteTablaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ItemsComprobanteTablaTable,
      ItemComprobanteRow,
      $$ItemsComprobanteTablaTableFilterComposer,
      $$ItemsComprobanteTablaTableOrderingComposer,
      $$ItemsComprobanteTablaTableAnnotationComposer,
      $$ItemsComprobanteTablaTableCreateCompanionBuilder,
      $$ItemsComprobanteTablaTableUpdateCompanionBuilder,
      (ItemComprobanteRow, $$ItemsComprobanteTablaTableReferences),
      ItemComprobanteRow,
      PrefetchHooks Function({bool comprobanteId})
    >;
typedef $$CorrelativosTablaTableCreateCompanionBuilder =
    CorrelativosTablaCompanion Function({
      required String serie,
      required TipoComprobante tipo,
      Value<int> ultimoCorrelativo,
      Value<int> rowid,
    });
typedef $$CorrelativosTablaTableUpdateCompanionBuilder =
    CorrelativosTablaCompanion Function({
      Value<String> serie,
      Value<TipoComprobante> tipo,
      Value<int> ultimoCorrelativo,
      Value<int> rowid,
    });

class $$CorrelativosTablaTableFilterComposer
    extends Composer<_$AppDatabase, $CorrelativosTablaTable> {
  $$CorrelativosTablaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get serie => $composableBuilder(
    column: $table.serie,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TipoComprobante, TipoComprobante, String>
  get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get ultimoCorrelativo => $composableBuilder(
    column: $table.ultimoCorrelativo,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CorrelativosTablaTableOrderingComposer
    extends Composer<_$AppDatabase, $CorrelativosTablaTable> {
  $$CorrelativosTablaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get serie => $composableBuilder(
    column: $table.serie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ultimoCorrelativo => $composableBuilder(
    column: $table.ultimoCorrelativo,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CorrelativosTablaTableAnnotationComposer
    extends Composer<_$AppDatabase, $CorrelativosTablaTable> {
  $$CorrelativosTablaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get serie =>
      $composableBuilder(column: $table.serie, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TipoComprobante, String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<int> get ultimoCorrelativo => $composableBuilder(
    column: $table.ultimoCorrelativo,
    builder: (column) => column,
  );
}

class $$CorrelativosTablaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CorrelativosTablaTable,
          CorrelativoRow,
          $$CorrelativosTablaTableFilterComposer,
          $$CorrelativosTablaTableOrderingComposer,
          $$CorrelativosTablaTableAnnotationComposer,
          $$CorrelativosTablaTableCreateCompanionBuilder,
          $$CorrelativosTablaTableUpdateCompanionBuilder,
          (
            CorrelativoRow,
            BaseReferences<
              _$AppDatabase,
              $CorrelativosTablaTable,
              CorrelativoRow
            >,
          ),
          CorrelativoRow,
          PrefetchHooks Function()
        > {
  $$CorrelativosTablaTableTableManager(
    _$AppDatabase db,
    $CorrelativosTablaTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CorrelativosTablaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CorrelativosTablaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CorrelativosTablaTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> serie = const Value.absent(),
                Value<TipoComprobante> tipo = const Value.absent(),
                Value<int> ultimoCorrelativo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CorrelativosTablaCompanion(
                serie: serie,
                tipo: tipo,
                ultimoCorrelativo: ultimoCorrelativo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String serie,
                required TipoComprobante tipo,
                Value<int> ultimoCorrelativo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CorrelativosTablaCompanion.insert(
                serie: serie,
                tipo: tipo,
                ultimoCorrelativo: ultimoCorrelativo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CorrelativosTablaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CorrelativosTablaTable,
      CorrelativoRow,
      $$CorrelativosTablaTableFilterComposer,
      $$CorrelativosTablaTableOrderingComposer,
      $$CorrelativosTablaTableAnnotationComposer,
      $$CorrelativosTablaTableCreateCompanionBuilder,
      $$CorrelativosTablaTableUpdateCompanionBuilder,
      (
        CorrelativoRow,
        BaseReferences<_$AppDatabase, $CorrelativosTablaTable, CorrelativoRow>,
      ),
      CorrelativoRow,
      PrefetchHooks Function()
    >;
typedef $$AjustesTablaTableCreateCompanionBuilder =
    AjustesTablaCompanion Function({
      required String clave,
      required String valor,
      Value<int> rowid,
    });
typedef $$AjustesTablaTableUpdateCompanionBuilder =
    AjustesTablaCompanion Function({
      Value<String> clave,
      Value<String> valor,
      Value<int> rowid,
    });

class $$AjustesTablaTableFilterComposer
    extends Composer<_$AppDatabase, $AjustesTablaTable> {
  $$AjustesTablaTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get clave => $composableBuilder(
    column: $table.clave,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AjustesTablaTableOrderingComposer
    extends Composer<_$AppDatabase, $AjustesTablaTable> {
  $$AjustesTablaTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get clave => $composableBuilder(
    column: $table.clave,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AjustesTablaTableAnnotationComposer
    extends Composer<_$AppDatabase, $AjustesTablaTable> {
  $$AjustesTablaTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get clave =>
      $composableBuilder(column: $table.clave, builder: (column) => column);

  GeneratedColumn<String> get valor =>
      $composableBuilder(column: $table.valor, builder: (column) => column);
}

class $$AjustesTablaTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AjustesTablaTable,
          AjusteRow,
          $$AjustesTablaTableFilterComposer,
          $$AjustesTablaTableOrderingComposer,
          $$AjustesTablaTableAnnotationComposer,
          $$AjustesTablaTableCreateCompanionBuilder,
          $$AjustesTablaTableUpdateCompanionBuilder,
          (
            AjusteRow,
            BaseReferences<_$AppDatabase, $AjustesTablaTable, AjusteRow>,
          ),
          AjusteRow,
          PrefetchHooks Function()
        > {
  $$AjustesTablaTableTableManager(_$AppDatabase db, $AjustesTablaTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AjustesTablaTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AjustesTablaTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AjustesTablaTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> clave = const Value.absent(),
                Value<String> valor = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AjustesTablaCompanion(
                clave: clave,
                valor: valor,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String clave,
                required String valor,
                Value<int> rowid = const Value.absent(),
              }) => AjustesTablaCompanion.insert(
                clave: clave,
                valor: valor,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AjustesTablaTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AjustesTablaTable,
      AjusteRow,
      $$AjustesTablaTableFilterComposer,
      $$AjustesTablaTableOrderingComposer,
      $$AjustesTablaTableAnnotationComposer,
      $$AjustesTablaTableCreateCompanionBuilder,
      $$AjustesTablaTableUpdateCompanionBuilder,
      (AjusteRow, BaseReferences<_$AppDatabase, $AjustesTablaTable, AjusteRow>),
      AjusteRow,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$EmpresasTablaTableTableManager get empresasTabla =>
      $$EmpresasTablaTableTableManager(_db, _db.empresasTabla);
  $$ClientesTablaTableTableManager get clientesTabla =>
      $$ClientesTablaTableTableManager(_db, _db.clientesTabla);
  $$ComprobantesTablaTableTableManager get comprobantesTabla =>
      $$ComprobantesTablaTableTableManager(_db, _db.comprobantesTabla);
  $$ItemsComprobanteTablaTableTableManager get itemsComprobanteTabla =>
      $$ItemsComprobanteTablaTableTableManager(_db, _db.itemsComprobanteTabla);
  $$CorrelativosTablaTableTableManager get correlativosTabla =>
      $$CorrelativosTablaTableTableManager(_db, _db.correlativosTabla);
  $$AjustesTablaTableTableManager get ajustesTabla =>
      $$AjustesTablaTableTableManager(_db, _db.ajustesTabla);
}
