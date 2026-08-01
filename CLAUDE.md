# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Qué es este proyecto

App Flutter de facturación electrónica para el mercado peruano (SUNAT): emite facturas y boletas
siguiendo UBL 2.1, consulta RUC/DNI, y exporta cada comprobante como RIDE en PDF con su código QR.

Se construye en tres fases, y cada una debe compilar y correr antes de pasar a la siguiente:

1. **MVP en modo Simulación** — todo local, sin backend. Es el modo por defecto de la app. **Completa.**
2. **Consulta RUC/DNI** — contra una API pública, detrás de una interfaz para poder cambiar de proveedor.
3. **Emisión real** — contra el ambiente BETA de SUNAT a través de [Lycet](https://github.com/giansalex/lycet)
   (API REST sobre Greenter). La firma XML-DSig y el cliente SOAP **no** se reimplementan en Dart.

Los puntos de enganche de las fases siguientes ya están puestos y vacíos: `FormularioCliente`
acepta un `accionConsulta` y `CamposIdentificacionEmpresa` un `accionConsultaRuc` para el botón de
la Fase 2; `PasarelaSunat` es la interfaz que implementará el cliente de Lycet en la Fase 3, y
`servicioEmisionProvider` es donde se inyectará. Nada de eso debe obligar a tocar la interfaz.

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

Regenerar las capturas que ilustran el README (no entran en `flutter test`):

```bash
flutter test --update-goldens test/capturas/generar_capturas.dart
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
- **`barcode`** — `BarcodeQRCorrectionLevel` vive ahí; `pdf/widgets.dart` lo usa pero no lo
  reexporta, así que hay que importarlo a mano en el generador del RIDE.

## Trampas que ya costaron una sesión

**`intl` no tiene datos numéricos de `es_PE`** y degrada en silencio a los de España: coma decimal,
punto de millares y símbolo detrás (`1.234,50 S/`). Perú escribe `S/ 1,234.50`. Por eso
`core/utils/formatos.dart` toma los separadores de `en_US` —que coinciden con la convención
peruana— y antepone el símbolo a mano. **No pasar `kLocalePeru` a un `NumberFormat`**: esa
constante sólo vale para fechas, cuyos patrones son explícitos. Lo que viaja al XML no se ve
afectado porque `importeParaSunat` usa `toStringAsFixed`, que ignora la configuración regional.

**Un provider `autoDispose` leído con `ref.read` desde un widget no tiene oyentes**, así que
Riverpod lo destruye enseguida. Si su método sigue usando `ref` después de un `await` —generar el
PDF, hablar con la pasarela, escribir la segunda de dos claves— revienta a mitad de la operación.
Los controladores de pantalla (`ControladorRide`, `ControladorEmision`, `ControladorAjustes`) se
**observan** con `ref.watch(...notifier)` desde el `build` de la pantalla que los usa, no se leen.

**`PopScope` con `canPop: false`**: dentro de `onPopInvokedWithResult` hay que salir con
`context.pop()` (que llama a `Navigator.pop`), nunca con `maybePop`, o el `PopScope` se dispara
otra vez y el diálogo de descarte entra en bucle.

## Arquitectura

Feature-first con capas. `lib/core/` es lo transversal; cada carpeta de `lib/features/<feature>/`
tiene `data/`, `domain/` y `presentation/`.

```
lib/
  core/          constantes (catálogos SUNAT), database, router, theme, utils, widgets, providers
  features/
    empresa/       datos del emisor (registro único), onboarding y su edición posterior
    clientes/      agenda de receptores
    comprobantes/  cálculo fiscal, persistencia, RIDE en PDF, emisión
    configuracion/ ajustes clave/valor (modo de operación, Lycet, tema)
    inicio/        dashboard y cáscara de navegación
```

Las pantallas de `comprobantes/presentation/`: `pantalla_historial`, `pantalla_nuevo_comprobante`
(formulario de emisión) y `pantalla_detalle_comprobante` (con la pestaña del RIDE). Los widgets que
comparten son `panel_totales` —el desglose, que sirve igual al borrador y al comprobante emitido—,
`tabla_items` y `hoja_item_comprobante`, la hoja inferior de captura de línea.

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
sobre Riverpod lo reevalúa en cuanto la empresa queda configurada. Las pantallas de trabajo —nuevo
comprobante, detalle, ficha de cliente, datos de la empresa— se apilan sobre el navegador **raíz**
(`parentNavigatorKey`) para que tapen la barra inferior en vez de vivir dentro de una sección.

`main.dart` monta el `ProviderScope`, el router, el tema y las traducciones de Material en es-PE, y
llama a `initializeDateFormatting` **antes** del primer `DateFormat`, o `intl` lanza al formatear.

## Pruebas

`test/utiles/entorno_prueba.dart` monta la **app entera** —router, tema y providers— contra una
base en memoria (`AppDatabase.paraPruebas` + `NativeDatabase.memory()`), sobrescribiendo sólo
`appDatabaseProvider`. Se prueba así, y no el widget suelto, porque los fallos que importan están
en el cableado: que el correlativo no se repita, que el receptor quede copiado en el comprobante,
que guardar dos ajustes seguidos no pierda el segundo.

Dos detalles del arnés: el lienzo por defecto (800 × 600) deja fuera media pantalla, así que
`montar()` lo agranda; y las capturas cargan a mano las tipografías del proyecto y la de íconos,
porque el motor de pruebas usa por defecto una fuente de rectángulos.

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

`docs/capturas/` son las imágenes del README, generadas por `test/capturas/generar_capturas.dart`.
Hay que regenerarlas cuando cambie la interfaz; el `ride.pdf` de esa carpeta es la salida real del
generador y sirve para comprobar de un vistazo si algo se rompió en el RIDE.
