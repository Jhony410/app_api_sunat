# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Qué es este proyecto

App Flutter de facturación electrónica para el mercado peruano (SUNAT): emite facturas y boletas
siguiendo UBL 2.1, consulta RUC/DNI, y exporta cada comprobante como RIDE en PDF con su código QR.

Se construye en tres fases, y cada una debe compilar y correr antes de pasar a la siguiente:

1. **MVP en modo Simulación** — todo local, sin backend. Es el modo por defecto de la app.
2. **Consulta RUC/DNI** — contra una API pública, detrás de una interfaz para poder cambiar de proveedor.
3. **Emisión real** — contra el ambiente BETA de SUNAT a través de [Lycet](https://github.com/giansalex/lycet)
   (API REST sobre Greenter). La firma XML-DSig y el cliente SOAP **no** se reimplementan en Dart.

## Idioma

Todo el código nuevo se escribe en español (es-PE): nombres de clases, métodos, variables, comentarios
y copy de la interfaz. Sólo se dejan en inglés los identificadores impuestos por paquetes externos
(`build`, `copyWith`, `fromSql`…). Los comentarios explican **por qué**, no qué hace la línea.

## Comandos

```bash
flutter pub get
```

```bash
dart run build_runner build
```

```bash
flutter analyze
```

```bash
flutter test
```

Un solo archivo de test, o un solo caso por nombre:

```bash
flutter test test/calculadora_totales_test.dart --plain-name "IGV"
```

Regeneración continua mientras se editan modelos o tablas:

```bash
dart run build_runner watch
```

Ejecutar con la configuración de emisión real (ver `env.example.json`):

```bash
flutter run --dart-define-from-file=env.json
```

`flutter analyze` debe terminar sin warnings antes de dar por cerrada cualquier fase.

## Generación de código

`build_runner` alimenta cuatro generadores; hay que reejecutarlo tras tocar cualquiera de estos:

| Cambio | Genera |
| --- | --- |
| Entidad con `@freezed` | `*.freezed.dart` |
| Provider con `@riverpod` | `*.g.dart` |
| Tabla en `lib/core/database/tablas.dart` | `app_database.g.dart` |

**Trampa de Drift:** `app_database.g.dart` es un `part` de `app_database.dart`, así que hereda *sus*
imports, no los de `tablas.dart`. Cualquier tipo usado por un `TypeConverter` (los enums de
`catalogos_sunat.dart`) tiene que estar importado en `app_database.dart` aunque el cuerpo de la clase
no lo use, o el generado no compila.

## Versiones que cambian la API respecto de lo habitual

- **freezed 3.x** — las clases se declaran `abstract class X with _$X` (o `sealed`), no `class X`.
- **Riverpod 3.x** — `Ref` ya no es genérico (`AppDatabase appDatabase(Ref ref)`), y `AsyncValue`
  expone `.value` (que devuelve `T?`); `valueOrNull` ya no existe.
- **Tipografías** — van empaquetadas en `assets/fonts/` en lugar de `google_fonts`, porque la app
  debe verse igual sin conexión y el generador de PDF necesita el TTF para incrustarlo en el RIDE.

## Arquitectura

Feature-first con capas. `lib/core/` es lo transversal; cada carpeta de `lib/features/<feature>/`
tiene `data/`, `domain/` y `presentation/`.

```
lib/
  core/          constantes (catálogos SUNAT), database, router, theme, utils, widgets, providers
  features/
    empresa/       datos del emisor (registro único) y onboarding
    clientes/      agenda de receptores
    comprobantes/  cálculo fiscal, persistencia, RIDE en PDF, emisión
    configuracion/ ajustes clave/valor (modo de operación, Lycet, tema)
    inicio/        dashboard y cáscara de navegación
```

### Reglas que sostienen el dominio

**El cálculo fiscal tiene una sola fuente de verdad.**
`features/comprobantes/domain/servicios/calculadora_totales.dart` es puro: sin base de datos, sin red,
sin estado. Todo importe que se muestre, se imprima o se envíe sale de ahí. `Comprobante.totales` es un
getter que lo invoca, de modo que los totales nunca pueden quedar desincronizados de los ítems. **No se
persisten los totales** (salvo `importeTotal` denormalizado en la cabecera, que existe sólo para poder
filtrar y sumar en SQL sin cargar los ítems). Cualquier cambio aquí necesita cubrirse con tests.

El IGV se calcula **por línea sobre la base ya redondeada a dos decimales**, y luego se suman las líneas.
Es lo que hace que el total cuadre con la validación de SUNAT (tolerancia de un céntimo). No cambiar a
"sumar primero, redondear después".

**Los enums de catálogo se persisten por su código SUNAT**, no por su índice (`TipoComprobanteConverter`
y compañía en `core/database/convertidores.dart`). Reordenar un `enum` en Dart nunca debe corromper
datos ya guardados.

**El comprobante guarda una copia del cliente, no una referencia.** La tabla `comprobantes` tiene
columnas `cliente*` además de `clienteId`: un documento emitido es un registro histórico y no puede
cambiar porque después se corrija la ficha del cliente.

**El correlativo se reserva dentro de la misma transacción en que se inserta el comprobante**
(`ComprobanteRepositorio.crear`). Es lo que garantiza que no se repita ni se salte un número. El
`proximoCorrelativo` que muestra el formulario es sólo informativo.

**La emisión degrada con elegancia.** `ServicioEmision` cae a modo Simulación —conservando el
comprobante— si no hay pasarela configurada, si Lycet no responde o si el envío lanza. La app nunca
debe perder un documento ya capturado por un fallo de red.

### Estado y navegación

Riverpod con generación de código. Los providers de infraestructura (base de datos, repositorios,
router, ajustes, empresa) son `@Riverpod(keepAlive: true)`; los de pantalla son `@riverpod` a secas para
que se descarten al salir (el borrador del comprobante depende de eso).

`go_router` con un `ShellRoute` para las cuatro secciones con barra inferior. El `redirect` fuerza el
onboarding mientras `requiereConfiguracionInicialProvider` sea `true`, y un `refreshListenable` puente
sobre Riverpod lo reevalúa en cuanto la empresa queda configurada.

## Sistema de diseño

`core/theme/app_theme.dart` define Material 3 con semilla esmeralda (`#0E9F6E`), acento índigo y neutros
cálidos —los `surface*` se sobrescriben a mano porque `ColorScheme.fromSeed` los derivaría fríos—. Los
espaciados salen de `Espaciado` (múltiplos de 8) y los radios de `Radios`; no usar números sueltos.
Outfit para títulos, Inter para texto. Los estados vacíos usan `EstadoVacio` y las cargas usan los
esqueletos de `core/widgets/esqueletos.dart`, no spinners centrados.

## Configuración sensible

Ni tokens ni URLs se escriben en el código. Los valores por defecto llegan por
`--dart-define-from-file=env.json` (`ValoresPorDefecto` en `configuracion/domain/entidades/ajustes.dart`)
y el usuario puede sobrescribirlos desde Configuración, que los guarda en la tabla `ajustes`.
`env.json` y cualquier certificado están en `.gitignore`; `env.example.json` sí se versiona.

## Referencia

`docs/ejemplo_ubl_boleta.xml` es un XML real de una boleta firmada. Es la referencia de estructura para
los nombres de campo, los códigos de catálogo y el formato de importes al construir el envío de Fase 3.
