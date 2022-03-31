import 'dart:convert';
import 'dart:io';

import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/NativeRequest.dart';
import 'package:check_in_pro_for_visitor/src/model/NativeResponse.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/PrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:ui' as ui;

import 'package:ping_discover_network/ping_discover_network.dart';
import 'package:wifi/wifi.dart';
part 'QLPrinterModel.g.dart';

@JsonSerializable()
class QLPrinterModel extends PrinterModel {
  QLPrinterModel(String type, String ipAddress, String model, bool isConnect, int numberOfCopy)
      : super(type, ipAddress, model, isConnect, numberOfCopy);

  QLPrinterModel.init() : super.init();

  @override
  Future connectPrinter() async {
    await savePrinterToPreferences();
    return Constants.STATUS_SUCCESS;
  }

  @override
  Future<List<PrinterModel>> findPrinter() async {
    try {
      if (Platform.isAndroid) {
        var nativeRequest = NativeRequest(Constants.ACTION_PRINTER_FIND, null);
        var dataJson = jsonEncode(nativeRequest.toJson());
        var response = await Constants.PRINTER_CHANNEL.invokeMethod(dataJson);
        var nativeResponse = NativeResponse.fromJson(jsonDecode(response));
        if (nativeResponse.status == Constants.STATUS_SUCCESS) {
          return nativeResponse.data.map((Map model) => fromJson(model)).toList();
        }
        return List();
      } else {
        String ip = await Wifi.ip;
        List<PrinterModel> list = List();
        final String subnet = ip.substring(0, ip.lastIndexOf('.'));
        int port = 9100;
        final stream = NetworkAnalyzer.discover2(subnet, port);
        await for (NetworkAddress addr in stream) {
          if (addr.exists) {
            var xPrinter = QLPrinterModel(
                PrinterType.BROTHER, addr.ip, Constants.PRINTER_QL, false, 1);
            list.add(xPrinter);
          }
        }
        return list;
      }
    } on PlatformException catch (e) {
      return List();
    }
  }

  @override
  Future<String> printTemplate(RenderRepaintBoundary boundary) async {
    try {
      bool isSaved = await saveToImage(boundary);
      if (isSaved) {
        var nativeRequest = NativeRequest(Constants.ACTION_PRINTER_PRINT, this.toJson());
        var dataJson = jsonEncode(nativeRequest.toJson());
        var response = await Constants.PRINTER_CHANNEL.invokeMethod(dataJson);
        var nativeResponse = NativeResponse.fromJson(jsonDecode(response));
        if (nativeResponse.status == Constants.STATUS_SUCCESS) {
          return Constants.STATUS_SUCCESS;
        }
        return nativeResponse.errorCode;
      }
      return Constants.ERROR_PRINTER;
    } on PlatformException catch (e) {
      return Constants.ERROR_PRINTER;
    } catch (e) {
      Utilities().printLog(e.toString());
      return Constants.ERROR_PRINTER;
    }
  }

  Future<bool> saveToImage(RenderRepaintBoundary boundary) async {
    try {
      ui.Image image = await boundary.toImage(pixelRatio: (Platform.isAndroid) ? 15 : 5.58);
      ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      await writeToFile(byteData);
      return true;
    } catch (e) {
      Utilities().printLog(e.toString());
      return false;
    }
  }

  Future<void> writeToFile(ByteData data) async {
    var path =
        await Utilities().getLocalPathFile(Constants.FOLDER_BADGE, "", Constants.BADGE_FILE_TEST, Constants.PNG_ETX);
    final buffer = data.buffer;
    return File(path).writeAsBytes(buffer.asUint8List(data.offsetInBytes, data.lengthInBytes));
  }

  @override
  Future<String> printTest() async {
    try {
      var nativeRequest = NativeRequest(Constants.ACTION_PRINTER_TEST, this.toJson());
      var dataJson = jsonEncode(nativeRequest.toJson());
      var response = await Constants.PRINTER_CHANNEL.invokeMethod(dataJson);
      var nativeResponse = NativeResponse.fromJson(jsonDecode(response));
      if (nativeResponse.status == Constants.STATUS_SUCCESS) {
        return Constants.STATUS_SUCCESS;
      }
      return nativeResponse.errorCode;
    } on PlatformException catch (e) {
      return Constants.ERROR_PRINTER;
    } catch (e) {
      return Constants.ERROR_PRINTER;
    }
  }

  @override
  PrinterModel fromJson(Map<String, dynamic> data) => QLPrinterModel.fromJson(data);

  factory QLPrinterModel.fromJson(Map<String, dynamic> json) => _$QLPrinterModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$QLPrinterModelToJson(this);
}
