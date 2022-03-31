import 'dart:convert';
import 'dart:typed_data';
import 'package:intl/intl.dart';

import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';

// import 'package:flutter_full_pdf_viewer/flutter_full_pdf_viewer.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:flutter/material.dart';

class NDANotifier extends ChangeNotifier {
  // String _hexOfRGBA(int r, int g, int b) {
  //   r = (r<0)?-r:r;
  //   g = (g<0)?-g:g;
  //   b = (b<0)?-b:b;
  //   r = (r>255)?255:r;
  //   g = (g>255)?255:g;
  //   b = (b>255)?255:b;
  //   var red = r.toRadixString(16).padLeft(2, '0');
  //   var green = g.toRadixString(16).padLeft(2, '0');
  //   var blue = b.toRadixString(16).padLeft(2, '0');

  //   return '#$red$green$blue';
  // }

  // String _formatRgbToHex(String string) {
  //   var cpString = string;

  //   const startStr = 'rgb';
  //   const endStr = ')';
  //   const startStrSplit = '(';
  //   const endStrSplit = ')';
  //   const charSplit = ',';

  //   var iChar = 0;
  //   while (true) {
  //     var indexStart = string.indexOf(startStr, iChar);
  //     if (indexStart <= -1) {
  //       break;
  //     }
  //     var indexEnd = string.indexOf(endStr, indexStart);
  //     iChar = indexEnd;
  //     if (iChar <= -1) {
  //       break;
  //     }
  //     var subStr = string.substring(indexStart, indexEnd + 1);
  //     // Split section
  //     var iStart = subStr.indexOf(startStrSplit);
  //     var iEnd = subStr.lastIndexOf(endStrSplit);
  //     var subSplit = subStr.substring(iStart + 1, iEnd);
  //     var arrSplit = subSplit.split(charSplit);
  //     // Change rgb to hex color
  //     var rgbColor = _hexOfRGBA(int.parse(arrSplit[0]), int.parse(arrSplit[1]), int.parse(arrSplit[2]));
  //     // Replace string
  //     cpString = cpString.replaceAll(subStr, rgbColor);
  //   }
  //   return cpString;
  // }

  String formatHTMLRender(String html) {
    var result = html;
    // result = _formatRgbToHex(result);

    return result;
  }

  Future<void> saveFilePDFThroughHTML(String htmlContent, BuildContext context) async {
    var targetPath = await Utilities().localPath("");
    var targetFileName = "NDA-pdf";

    var generatedPdfFile = await FlutterHtmlToPdf.convertFromHtmlContent(htmlContent, targetPath, targetFileName);
    var generatedPdfFilePath = generatedPdfFile.path;
    // Navigator.push(
    //   context,
    //   Material(
    //     builder: (context) => PDFViewerScaffold(
    //     appBar: AppBar(title: Text("Generated PDF Document")),
    //     path: generatedPdfFilePath)
    //   ),
    // );
  }

  String addSignatureToHTML(String imgSrc, String htmlContent) {
    var nameVistor = 'Lee Wong Hao';
    var dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    var dateString = dateFormat.format(DateTime.now());
    // Add new component to HTML content
    var result = htmlContent +
        '''
              <img src="data:image/svg+xml;base64,$imgSrc" height="70" width="130" />
              <p>$nameVistor</p>
              <p>$dateString</p>
              ''';

    return result;
  }

  String convertSvgStringToBytes(String data) {
    List<int> list = data.codeUnits;
    Uint8List bytes = Uint8List.fromList(list);
    String base64Image = base64Encode(bytes);

    return base64Image;
  }
}
