import 'dart:io';
import 'dart:typed_data';

// El nivel de corrección del QR vive en `barcode`, que `pdf/widgets.dart` usa
// pero no reexporta.
import 'package:barcode/barcode.dart' show BarcodeQRCorrectionLevel;
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../../core/constantes/catalogos_sunat.dart';
import '../../../core/utils/formatos.dart';
import '../../empresa/domain/entidades/empresa.dart';
import '../domain/entidades/comprobante.dart';
import '../domain/entidades/item_comprobante.dart';
import '../domain/entidades/totales.dart';

/// Genera la representación impresa del comprobante electrónico (RIDE).
///
/// El diseño replica lo que exige SUNAT —datos del emisor, del receptor,
/// detalle de ítems, totales desglosados, importe en letras y código QR— con la
/// tipografía y la paleta de la app. En modo Simulación se imprime una marca
/// visible para que nadie confunda el documento con uno realmente emitido.
class GeneradorRide {
  const GeneradorRide();

  // Paleta del RIDE, alineada con el tema de la app.
  static const _tinta = PdfColor.fromInt(0xFF1A1A1F);
  static const _tintaSuave = PdfColor.fromInt(0xFF6B6B76);
  static const _acento = PdfColor.fromInt(0xFF0E9F6E);
  static const _lineaSuave = PdfColor.fromInt(0xFFE2DED7);
  static const _fondoSuave = PdfColor.fromInt(0xFFF7F5F1);

  /// Construye el PDF y devuelve sus bytes, listos para compartir o imprimir.
  Future<Uint8List> generar(Comprobante comprobante, Empresa empresa) async {
    final tipografia = await _cargarTipografia();
    final logo = await _cargarLogo(empresa.logoPath);
    final totales = comprobante.totales;
    final esSimulado = comprobante.estadoSunat == EstadoSunat.simulado;

    final documento = pw.Document(
      title: '${comprobante.tipo.tituloRide} ${comprobante.numeroCompleto}',
      author: empresa.razonSocial,
      creator: 'app_api_sunat',
    );

    documento.addPage(
      pw.MultiPage(
        pageTheme: pw.PageTheme(
          pageFormat: PdfPageFormat.a4,
          margin: const pw.EdgeInsets.fromLTRB(32, 32, 32, 28),
          theme: tipografia,
          // La marca de agua deja claro que el documento no es oficial.
          buildBackground: esSimulado ? (context) => _marcaDeAgua() : null,
        ),
        header: (context) =>
            context.pageNumber == 1 ? _encabezado(comprobante, empresa, logo) : pw.SizedBox(),
        footer: (context) => _pie(context, comprobante, esSimulado),
        build: (context) => [
          pw.SizedBox(height: 14),
          _bloqueReceptor(comprobante),
          pw.SizedBox(height: 14),
          _tablaItems(comprobante),
          pw.SizedBox(height: 14),
          _bloqueTotalesYQr(comprobante, empresa),
          if (comprobante.observaciones != null &&
              comprobante.observaciones!.trim().isNotEmpty) ...[
            pw.SizedBox(height: 14),
            _bloqueObservaciones(comprobante.observaciones!),
          ],
          pw.SizedBox(height: 10),
          pw.Text(
            'Importe en letras: ${totales.totalEnLetras}',
            style: const pw.TextStyle(fontSize: 8.5, color: _tintaSuave),
          ),
        ],
      ),
    );

    return documento.save();
  }

  /// Guarda el PDF en [directorio] y devuelve el archivo creado.
  Future<File> guardarEn(
    Directory directorio,
    Comprobante comprobante,
    Empresa empresa,
  ) async {
    final bytes = await generar(comprobante, empresa);
    final nombre = nombreArchivo(comprobante, empresa);
    final archivo = File('${directorio.path}${Platform.pathSeparator}$nombre');
    return archivo.writeAsBytes(bytes);
  }

  /// `20123456789-01-F001-00000123.pdf`, la convención de nombres de SUNAT.
  String nombreArchivo(Comprobante comprobante, Empresa empresa) =>
      '${empresa.ruc}-${comprobante.tipo.codigo}-${comprobante.numeroCompleto}.pdf';

  // ---------------------------------------------------------------- secciones

  pw.Widget _encabezado(Comprobante comprobante, Empresa empresa, pw.MemoryImage? logo) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 3,
          child: pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              if (logo != null) ...[
                pw.Container(
                  width: 56,
                  height: 56,
                  child: pw.Image(logo, fit: pw.BoxFit.contain),
                ),
                pw.SizedBox(width: 12),
              ],
              pw.Expanded(
                child: pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Text(
                      empresa.nombreParaMostrar.toUpperCase(),
                      style: pw.TextStyle(
                        fontSize: 15,
                        fontWeight: pw.FontWeight.bold,
                        color: _tinta,
                      ),
                    ),
                    if (empresa.nombreComercial.trim().isNotEmpty)
                      pw.Text(
                        empresa.razonSocial.toUpperCase(),
                        style: const pw.TextStyle(fontSize: 8.5, color: _tintaSuave),
                      ),
                    pw.SizedBox(height: 4),
                    pw.Text(
                      empresa.direccionCompleta,
                      style: const pw.TextStyle(fontSize: 8.5, color: _tintaSuave),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        pw.SizedBox(width: 14),
        // Recuadro con el identificador del comprobante, como manda el formato.
        pw.Container(
          width: 190,
          padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: pw.BoxDecoration(
            border: pw.Border.all(color: _acento, width: 1.2),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Column(
            children: [
              pw.Text(
                'R.U.C. ${empresa.ruc}',
                style: pw.TextStyle(fontSize: 10.5, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                comprobante.tipo.tituloRide,
                textAlign: pw.TextAlign.center,
                style: pw.TextStyle(
                  fontSize: 9.5,
                  fontWeight: pw.FontWeight.bold,
                  color: _acento,
                ),
              ),
              pw.SizedBox(height: 4),
              pw.Text(
                comprobante.numeroCompleto,
                style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _bloqueReceptor(Comprobante comprobante) {
    final cliente = comprobante.cliente;

    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        color: _fondoSuave,
        borderRadius: pw.BorderRadius.circular(8),
      ),
      child: pw.Column(
        children: [
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 3,
                child: _dato(
                  cliente.tipoDocumento == TipoDocumentoIdentidad.ruc
                      ? 'Señor(es)'
                      : 'Cliente',
                  cliente.razonSocialONombres,
                ),
              ),
              pw.Expanded(
                flex: 2,
                child: _dato(
                  cliente.tipoDocumento.etiqueta,
                  cliente.numeroDocumento,
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 6),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 3,
                child: _dato('Dirección', cliente.direccion ?? '—'),
              ),
              pw.Expanded(
                flex: 2,
                child: _dato(
                  'Fecha de emisión',
                  formatearFecha(comprobante.fechaEmision),
                ),
              ),
            ],
          ),
          pw.SizedBox(height: 6),
          pw.Row(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Expanded(
                flex: 3,
                child: _dato(
                  'Condición de pago',
                  comprobante.formaPago.etiqueta +
                      (comprobante.fechaVencimiento == null
                          ? ''
                          : ' · vence el ${formatearFecha(comprobante.fechaVencimiento!)}'),
                ),
              ),
              pw.Expanded(
                flex: 2,
                child: _dato('Moneda', comprobante.moneda.etiqueta),
              ),
            ],
          ),
          if (comprobante.esNota) ...[
            pw.SizedBox(height: 6),
            pw.Row(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Expanded(
                  flex: 3,
                  child: _dato(
                    'Motivo',
                    comprobante.motivoNota?.etiqueta ?? '—',
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: _dato(
                    'Documento que modifica',
                    comprobante.documentoAfectado ?? '—',
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  pw.Widget _tablaItems(Comprobante comprobante) {
    final totales = comprobante.totales;
    final moneda = comprobante.moneda;

    const encabezados = [
      'Ítem',
      'Código',
      'Descripción',
      'Cant.',
      'U.M.',
      'V. unit.',
      'P. unit.',
      'Importe',
    ];

    return pw.Table(
      border: pw.TableBorder(
        horizontalInside: const pw.BorderSide(color: _lineaSuave, width: 0.5),
        bottom: const pw.BorderSide(color: _lineaSuave, width: 0.5),
      ),
      columnWidths: const {
        0: pw.FixedColumnWidth(26),
        1: pw.FixedColumnWidth(52),
        2: pw.FlexColumnWidth(),
        3: pw.FixedColumnWidth(38),
        4: pw.FixedColumnWidth(34),
        5: pw.FixedColumnWidth(56),
        6: pw.FixedColumnWidth(56),
        7: pw.FixedColumnWidth(62),
      },
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: _fondoSuave),
          children: [
            for (var i = 0; i < encabezados.length; i++)
              pw.Padding(
                padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 6),
                child: pw.Text(
                  encabezados[i],
                  textAlign: i >= 3 ? pw.TextAlign.right : pw.TextAlign.left,
                  style: pw.TextStyle(
                    fontSize: 7.5,
                    fontWeight: pw.FontWeight.bold,
                    color: _tintaSuave,
                  ),
                ),
              ),
          ],
        ),
        for (var i = 0; i < comprobante.items.length; i++)
          _filaItem(comprobante.items[i], totales.lineas[i], moneda),
      ],
    );
  }

  pw.TableRow _filaItem(ItemComprobante item, LineaCalculada linea, Moneda moneda) {
    pw.Widget celda(String texto, {bool derecha = false, bool fuerte = false}) =>
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          child: pw.Text(
            texto,
            textAlign: derecha ? pw.TextAlign.right : pw.TextAlign.left,
            style: pw.TextStyle(
              fontSize: 8,
              fontWeight: fuerte ? pw.FontWeight.bold : pw.FontWeight.normal,
            ),
          ),
        );

    return pw.TableRow(
      children: [
        celda('${linea.orden}'),
        celda(item.codigo),
        pw.Padding(
          padding: const pw.EdgeInsets.symmetric(horizontal: 4, vertical: 5),
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(item.descripcion, style: const pw.TextStyle(fontSize: 8)),
              if (linea.afectacion.esGratuita)
                pw.Text(
                  'Transferencia gratuita — no genera importe a pagar',
                  style: const pw.TextStyle(fontSize: 6.5, color: _tintaSuave),
                ),
              if (linea.descuento > 0)
                pw.Text(
                  'Descuento: ${formatearImporte(linea.descuento)}',
                  style: const pw.TextStyle(fontSize: 6.5, color: _tintaSuave),
                ),
            ],
          ),
        ),
        celda(formatearCantidad(linea.cantidad), derecha: true),
        celda(item.unidadMedida.codigo, derecha: true),
        celda(formatearImporte(linea.valorUnitario), derecha: true),
        celda(formatearImporte(linea.precioUnitario), derecha: true),
        celda(formatearImporte(linea.totalLinea), derecha: true, fuerte: true),
      ],
    );
  }

  pw.Widget _bloqueTotalesYQr(Comprobante comprobante, Empresa empresa) {
    final totales = comprobante.totales;
    final moneda = comprobante.moneda;
    final cadenaQr = comprobante.cadenaQr(rucEmisor: empresa.ruc);

    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        // Columna izquierda: QR y valor resumen.
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.BarcodeWidget(
              barcode: pw.Barcode.qrCode(errorCorrectLevel: BarcodeQRCorrectionLevel.medium),
              data: cadenaQr,
              width: 92,
              height: 92,
              drawText: false,
            ),
            pw.SizedBox(height: 5),
            pw.SizedBox(
              width: 190,
              child: pw.Text(
                'Valor resumen: ${comprobante.hashCodigo ?? '—'}',
                style: const pw.TextStyle(fontSize: 6.5, color: _tintaSuave),
              ),
            ),
          ],
        ),
        pw.Spacer(),
        // Columna derecha: desglose de totales.
        pw.Container(
          width: 250,
          child: pw.Column(
            children: [
              for (final entrada in totales.casillasConImporte.entries)
                _filaTotal(
                  entrada.key,
                  formatearImporte(entrada.value),
                  moneda,
                ),
              if (totales.totalIgvGratuitas > 0)
                _filaTotal(
                  'IGV de gratuitas (informativo)',
                  formatearImporte(totales.totalIgvGratuitas),
                  moneda,
                  atenuado: true,
                ),
              pw.SizedBox(height: 4),
              pw.Container(
                padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                decoration: pw.BoxDecoration(
                  color: _acento,
                  borderRadius: pw.BorderRadius.circular(6),
                ),
                child: pw.Row(
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Text(
                      'IMPORTE TOTAL',
                      style: pw.TextStyle(
                        fontSize: 9.5,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                    pw.Text(
                      '${moneda.simbolo} ${formatearImporte(totales.importeTotal)}',
                      style: pw.TextStyle(
                        fontSize: 11.5,
                        fontWeight: pw.FontWeight.bold,
                        color: PdfColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _filaTotal(
    String etiqueta,
    String valor,
    Moneda moneda, {
    bool atenuado = false,
  }) {
    final color = atenuado ? _tintaSuave : _tinta;
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 2.5),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(etiqueta, style: pw.TextStyle(fontSize: 8.5, color: color)),
          pw.Text(
            '${moneda.simbolo} $valor',
            style: pw.TextStyle(fontSize: 8.5, color: color),
          ),
        ],
      ),
    );
  }

  pw.Widget _bloqueObservaciones(String texto) {
    return pw.Container(
      width: double.infinity,
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: _lineaSuave),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            'Observaciones',
            style: pw.TextStyle(
              fontSize: 7.5,
              fontWeight: pw.FontWeight.bold,
              color: _tintaSuave,
            ),
          ),
          pw.SizedBox(height: 3),
          pw.Text(texto, style: const pw.TextStyle(fontSize: 8.5)),
        ],
      ),
    );
  }

  pw.Widget _pie(pw.Context context, Comprobante comprobante, bool esSimulado) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Divider(color: _lineaSuave, height: 12),
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Text(
                esSimulado
                    ? 'DOCUMENTO DE PRUEBA — representación no oficial generada en modo Simulación. '
                        'No ha sido enviado ni validado por SUNAT.'
                    : 'Representación impresa del comprobante electrónico. '
                        'Consúltelo en www.sunat.gob.pe',
                style: pw.TextStyle(
                  fontSize: 6.5,
                  color: esSimulado ? PdfColors.red700 : _tintaSuave,
                  fontWeight: esSimulado ? pw.FontWeight.bold : pw.FontWeight.normal,
                ),
              ),
            ),
            pw.SizedBox(width: 12),
            pw.Text(
              'Página ${context.pageNumber} de ${context.pagesCount}',
              style: const pw.TextStyle(fontSize: 6.5, color: _tintaSuave),
            ),
          ],
        ),
      ],
    );
  }

  pw.Widget _marcaDeAgua() {
    return pw.Center(
      child: pw.Transform.rotate(
        angle: 0.62,
        child: pw.Opacity(
          opacity: 0.07,
          child: pw.Text(
            'SIMULACIÓN',
            style: pw.TextStyle(
              fontSize: 96,
              fontWeight: pw.FontWeight.bold,
              color: PdfColors.black,
            ),
          ),
        ),
      ),
    );
  }

  pw.Widget _dato(String etiqueta, String valor) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text(
          etiqueta.toUpperCase(),
          style: pw.TextStyle(
            fontSize: 6.5,
            fontWeight: pw.FontWeight.bold,
            color: _tintaSuave,
          ),
        ),
        pw.Text(valor, style: const pw.TextStyle(fontSize: 9)),
      ],
    );
  }

  // ----------------------------------------------------------------- recursos

  /// Usa las mismas tipografías empaquetadas que la interfaz, para que el PDF
  /// y la app se vean como una sola pieza.
  Future<pw.ThemeData> _cargarTipografia() async {
    Future<pw.Font> cargar(String ruta) async =>
        pw.Font.ttf(await rootBundle.load(ruta));

    return pw.ThemeData.withFont(
      base: await cargar('assets/fonts/Inter-Regular.ttf'),
      bold: await cargar('assets/fonts/Inter-SemiBold.ttf'),
    );
  }

  Future<pw.MemoryImage?> _cargarLogo(String? ruta) async {
    if (ruta == null || ruta.trim().isEmpty) return null;
    try {
      final archivo = File(ruta);
      if (!archivo.existsSync()) return null;
      return pw.MemoryImage(await archivo.readAsBytes());
    } catch (_) {
      // Un logo ilegible nunca debe impedir que se genere el comprobante.
      return null;
    }
  }
}
