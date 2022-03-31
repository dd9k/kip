import 'dart:typed_data';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/PrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:esc_pos_printer/esc_pos_printer.dart';
import 'package:esc_pos_utils/esc_pos_utils.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:ui' as ui;
import 'package:image/src/image.dart' as Im;
import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:wifi/wifi.dart';

part 'XPrinterModel.g.dart';

@JsonSerializable()
class XPrinterModel extends PrinterModel {
  XPrinterModel(String type, String ipAddress, String model, bool isConnect, int numberOfCopy) : super(type, ipAddress, model, isConnect, numberOfCopy);

  XPrinterModel.init() : super.init();

  @JsonKey(ignore: true)
  List<PrinterModel> listAlready = List();

  @override
  Future<String> connectPrinter() async {
//    try {
//      var listConvert = ipAddress.split(" ");
//      var vendorId = int.parse(listConvert[0]);
//      var productId = int.parse(listConvert[1]);
//      await Escposprinter.connectPrinter(vendorId, productId);
//    } on PlatformException catch (e) {
//      return Constants.ERROR_PRINTER;
//    }
    await savePrinterToPreferences();
    return Constants.STATUS_SUCCESS;
  }

  @override
  Future<List<PrinterModel>> findPrinter() async {
    try {
      String ip = await Wifi.ip;
      List<PrinterModel> list = List();
      final String subnet = ip.substring(0, ip.lastIndexOf('.'));
      int port = 9100;
      final stream = NetworkAnalyzer.discover2(subnet, port);
      await for (NetworkAddress addr in stream) {
        if (addr.exists && !isAlreadyAdd(addr.ip)) {
          var xPrinter = XPrinterModel(PrinterType.X_PRINTER, addr.ip, Constants.PRINTER_ESC_POS, false, 1);
          list.add(xPrinter);
        }
      }

//      List returned = await Escposprinter.getUSBDeviceList;
//      await Future.forEach(returned, (device) async {
//        var id = device['vendorid'] + " " + device['productid'];
//        var productName = device['manufacturer'] + " " + device['product'];
//        var xPrinter = XPrinterModel(PrinterType.X_PRINTER, id, Constants.PRINTER_ESC_POS + " " + productName, false);
//        list.add(xPrinter);
//      });
      return list;
    } on PlatformException catch (e) {
      return List();
    }
  }

  void setListAlready(List<PrinterModel> listAlready) async {
    this.listAlready = listAlready;
  }

  bool isAlreadyAdd(String ip) {
    if (listAlready == null || listAlready.isEmpty) {
      return false;
    }
    for (PrinterModel print in listAlready) {
      if (print.ipAddress == ip) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<String> printTemplate(RenderRepaintBoundary boundary) async {
    try {
      final profile = await CapabilityProfile.load();
      final Ticket ticket = Ticket(PaperSize.mm80, profile);
      //var data = await saveToImage(boundary);
      ui.Image image = await boundary.toImage(pixelRatio: 2.58);
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData != null) {
        Uint8List pngBytes = byteData.buffer.asUint8List();
        final img = decodeImage(pngBytes);
        ticket.imageRaster(img);
        ticket.cut();
//        var string = base64.encode(ticket.bytes);
//        final resImage = await Escposprinter.printRawData(string);
        final PrinterNetworkManager printerManager = PrinterNetworkManager();
        printerManager.selectPrinter(ipAddress, port: 9100);
        final PosPrintResult resImage = await printerManager.printTicket(ticket);
        if (resImage.value == PosPrintResult.success.value) {
          return Constants.STATUS_SUCCESS;
        } else {
          return Constants.ERROR_PRINTER;
        }
      }
      return Constants.ERROR_PRINTER;
    } on PlatformException {
      return Constants.ERROR_PRINTER;
    }
  }

  @override
  Future<String> printTest() async {
    try {
      final profile = await CapabilityProfile.load();
      final Ticket ticket = Ticket(PaperSize.mm80, profile);

      /// Print image
      final ByteData data = await rootBundle.load('assets/images/card_exmp.png');
      final Uint8List bytes = data.buffer.asUint8List();
      final Im.Image image = decodeImage(bytes);
      ticket.image(image);
      ticket.cut();
      final PrinterNetworkManager printerManager = PrinterNetworkManager();
      printerManager.selectPrinter(ipAddress, port: 9100);
      final PosPrintResult resImage = await printerManager.printTicket(ticket);

      ///call printer
//      var string = base64.encode(ticket.bytes);
//      final resImage = await Escposprinter.printRawData(string);
      if (resImage.value == PosPrintResult.success.value) {
        return Constants.STATUS_SUCCESS;
      } else {
        return Constants.ERROR_PRINTER;
      }
    } on PlatformException {
      return Constants.ERROR_PRINTER;
    }
  }

  Future<ByteData> saveToImage(RenderRepaintBoundary boundary) async {
    try {
      ui.Image image = await boundary.toImage(pixelRatio: 25.0);
      return await image.toByteData(format: ui.ImageByteFormat.png);
    } catch (e) {
      Utilities().writeLog(e.toString());
      return null;
    }
  }

  @override
  PrinterModel fromJson(Map<String, dynamic> data) => XPrinterModel.fromJson(data);

  factory XPrinterModel.fromJson(Map<String, dynamic> json) => _$XPrinterModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$XPrinterModelToJson(this);
}
