# app_api_sunat

App Flutter de **facturación electrónica para el mercado peruano**. Emite facturas y boletas
siguiendo el estándar UBL 2.1 de SUNAT, calcula el IGV con las reglas del Anexo VIII del
Reglamento de Comprobantes de Pago, y exporta cada documento como RIDE en PDF con su código QR.

Funciona **sin conexión y sin backend**: la base de datos, el motor de cálculo, el generador del
PDF y las tipografías viven en el dispositivo. La emisión real ante SUNAT es un añadido opcional,
no un requisito para usar la app.

## Estado

El proyecto se construye en tres fases; cada una compila y corre antes de empezar la siguiente.

| Fase | Alcance | Estado |
| --- | --- | --- |
| 1 | MVP en modo Simulación: todo local, sin backend | **Completa** |
| 2 | Consulta RUC/DNI contra una API pública | Pendiente |
| 3 | Emisión real contra el ambiente BETA de SUNAT vía [Lycet](https://github.com/giansalex/lycet) | Pendiente |

Lo que ya se puede hacer hoy:

- Configurar el emisor en un onboarding de tres pasos (identificación, dirección fiscal, series).
- Llevar una agenda de clientes con validación de RUC (módulo 11) y DNI.
- Emitir facturas y boletas: ítems con unidad de medida, afectación del IGV, descuento por línea
  y captura del valor sin IGV **o** del precio al público, con los totales recalculándose en vivo.
- Consultar el historial con buscador y filtros por tipo, estado y rango de fechas.
- Ver el detalle de cualquier comprobante junto a su RIDE, e imprimirlo, compartirlo o guardarlo
  como PDF.
- Cambiar el modo de operación, las credenciales de la pasarela y el tema desde Configuración.

## Cómo se ve

Cuatro secciones con barra inferior —que en pantallas anchas se convierte en un riel lateral—:

```
Inicio        resumen del día y del mes, tendencia de 14 días y últimos comprobantes
Historial     buscador y filtros sobre todo lo emitido
Clientes      agenda de receptores
Ajustes       modo de operación, pasarela, emisor y apariencia
```

## Puesta en marcha

```bash
flutter pub get
dart run build_runner build
flutter run
```

La app arranca en **modo Simulación**: los comprobantes se guardan, se numeran y se imprimen, pero
no viajan a SUNAT y el PDF lleva una marca de agua que lo deja claro. Es el modo por defecto y no
necesita ninguna credencial.

Para trabajar contra una pasarela real, copia la plantilla de configuración y pásala al arrancar:

```bash
cp env.example.json env.json   # env.json está en .gitignore
flutter run --dart-define-from-file=env.json
```

Esos valores son sólo el punto de partida: se pueden sobrescribir desde Configuración, que los
guarda en la base local. **Ni tokens ni URLs se escriben nunca en el código.**

## Desarrollo

```bash
dart run build_runner build     # tras tocar entidades @freezed, providers @riverpod o tablas Drift
dart run build_runner watch     # regeneración continua
flutter analyze                 # debe terminar sin issues
flutter test                    # pruebas del motor de cálculo fiscal
```

Un solo caso por nombre:

```bash
flutter test test/calculadora_totales_test.dart --plain-name "IGV"
```

## Arquitectura

Feature-first con capas. `lib/core/` es lo transversal; cada carpeta de `lib/features/<feature>/`
tiene `data/`, `domain/` y `presentation/`.

```
lib/
  core/          catálogos SUNAT, base de datos (Drift), router, tema, utilidades, widgets
  features/
    empresa/       datos del emisor (registro único) y onboarding
    clientes/      agenda de receptores
    comprobantes/  cálculo fiscal, persistencia, RIDE en PDF y emisión
    configuracion/ ajustes clave/valor (modo de operación, Lycet, tema)
    inicio/        dashboard y cáscara de navegación
```

Estado con **Riverpod 3** y generación de código; navegación con **go_router** (un `ShellRoute`
para las cuatro secciones, y un `redirect` que fuerza el onboarding mientras falte configurar la
empresa); persistencia con **Drift** sobre SQLite; PDF con **pdf** + **printing**.

### Decisiones que sostienen el dominio

**El cálculo fiscal tiene una sola fuente de verdad.** `CalculadoraTotales` es una clase pura —sin
base de datos, sin red, sin estado— y `Comprobante.totales` es un getter que la invoca. Los totales
no se persisten (salvo `importeTotal`, denormalizado en la cabecera sólo para poder filtrar y sumar
en SQL), así que nunca pueden quedar desincronizados de los ítems.

**El IGV se calcula por línea sobre la base ya redondeada**, y después se suman las líneas. Es lo
que hace que el total cuadre con la validación de SUNAT, que admite una tolerancia de un céntimo.

**Los enums de catálogo se persisten por su código SUNAT**, no por su índice: reordenar un `enum`
en Dart nunca puede corromper datos ya guardados.

**El comprobante guarda una copia del cliente, no una referencia.** Un documento emitido es un
registro histórico y no debe cambiar porque después se corrija la ficha del cliente.

**El correlativo se reserva dentro de la misma transacción en que se inserta el comprobante**, de
modo que no pueda repetirse ni saltarse un número.

**La emisión degrada con elegancia.** Si no hay pasarela configurada, si no responde o si el envío
lanza, el comprobante se conserva en modo Simulación. La app nunca pierde un documento ya capturado
por un fallo de red.

## Sistema de diseño

Material 3 con semilla esmeralda (`#0E9F6E`), acento índigo y neutros cálidos —los `surface*` se
sobrescriben a mano porque `ColorScheme.fromSeed` los derivaría fríos—. Los espaciados salen de
`Espaciado` (múltiplos de 8) y los radios de `Radios`. Outfit para títulos, Inter para texto: van
empaquetadas en `assets/fonts/` en lugar de descargarse, porque la app debe verse igual sin
conexión y el generador de PDF necesita el TTF para incrustarlo en el RIDE.

## Idioma del código

Todo el código se escribe en español (es-PE): clases, métodos, variables, comentarios y copy de la
interfaz. Sólo quedan en inglés los identificadores que imponen los paquetes externos (`build`,
`copyWith`, `fromSql`…).

## Referencias

- `docs/ejemplo_ubl_boleta.xml` — XML real de una boleta firmada, referencia de estructura para el
  envío de la Fase 3.
- `CLAUDE.md` — notas de arquitectura, trampas de compilación e invariantes del dominio.
- [Lycet](https://github.com/giansalex/lycet) — API REST sobre Greenter; la firma XML-DSig y el
  cliente SOAP no se reimplementan en Dart.
