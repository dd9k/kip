import 'dart:convert';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/PrinterInfor.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PrinterModel {
  @JsonKey(name: 'type')
  String type;

  @JsonKey(name: 'ipAddress')
  String ipAddress;

  @JsonKey(name: 'model')
  String model;

  @JsonKey(name: 'isConnect')
  bool isConnect;

  @JsonKey(name: 'numberOfCopy')
  int numberOfCopy;

  PrinterModel.init();

  PrinterModel(this.type, this.ipAddress, this.model, this.isConnect, this.numberOfCopy);

  Future<List<PrinterModel>> findPrinter();

  Future connectPrinter();

  Future<String> printTemplate(RenderRepaintBoundary boundary);

  Future<String> printTest();

  Future<bool> checkPrinterConnect() async {
    var preferences = await SharedPreferences.getInstance();
    var data = preferences.getString(Constants.KEY_PRINTER);
    if (data == null || data.isEmpty) {
      return false;
    }
    var savedPrinter = PrinterInfor.fromJson(jsonDecode(data));
    if (savedPrinter.ipAddress == ipAddress) {
      return true;
    }
    return false;
  }

  PrinterModel fromJson(Map<String, dynamic> data);

  Map<String, dynamic> toJson();

  Future savePrinterToPreferences() async {
    var jsonString = jsonEncode(toJson());
    var preferences = await SharedPreferences.getInstance();
    preferences.setString(Constants.KEY_PRINTER, jsonString);
  }

  String getErrorCode(BuildContext context, String errorCode) {
    switch (errorCode) {
      case ErrorCode.NOT_SAME_MODEL:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.BROTHER_PRINTER_NOT_FOUND:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.PAPER_EMPTY:
        {
          return AppLocalizations.of(context).emptyPaper;
        }
      case ErrorCode.BATTERY_EMPTY:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.COMMUNICATION_ERROR:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.OVERHEAT:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.PAPER_JAM:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.HIGH_VOLTAGE_ADAPTER:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.FEED_OR_CASSETTE_EMPTY:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.SYSTEM_ERROR:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.NO_CASSETTE:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.WRONG_CASSETTE_DIRECT:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.CREATE_SOCKET_FAILED:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.CONNECT_SOCKET_FAILED:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.GET_OUTPUT_STREAM_FAILED:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.GET_INPUT_STREAM_FAILED:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.CLOSE_SOCKET_FAILED:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.OUT_OF_MEMORY:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.SET_OVER_MARGIN:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.NO_SD_CARD:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.FILE_NOT_SUPPORTED:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.EVALUATION_TIMEUP:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.WRONG_CUSTOM_INFO:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.NO_ADDRESS:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.NOT_MATCH_ADDRESS:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.FILE_NOT_FOUND:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.TEMPLATE_FILE_NOT_MATCH_MODEL:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.TEMPLATE_NOT_TRANS_MODEL:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.COVER_OPEN:
        {
          return AppLocalizations.of(context).coverOpen;
        }
      case ErrorCode.WRONG_LABEL:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.PORT_NOT_SUPPORTED:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.WRONG_TEMPLATE_KEY:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.BUSY:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.TEMPLATE_NOT_PRINT_MODEL:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.CANCEL:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.PRINTER_SETTING_NOT_SUPPORTED:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.INVALID_PARAMETER:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.INTERNAL_ERROR:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.TEMPLATE_NOT_CONTROL_MODEL:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.TEMPLATE_NOT_EXIST:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.BUFFER_FULL:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.TUBE_EMPTY:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.TUBE_RIBBON_EMPTY:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.UPDATE_FRIM_NOT_SUPPORTED:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.OS_VERSION_NOT_SUPPORTED:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.RESOLUTION_MODE:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.POWER_CABLE_UNPLUGGING:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.BATTERY_TROUBLE:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.UNSUPPORTED_MEDIA:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.TUBE_CUTTER:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.UNSUPPORTED_TWO_COLOR:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.UNSUPPORTED_MONO_COLOR:
        {
          return AppLocalizations.of(context).communicationError;
        }
      case ErrorCode.MINIMUM_LENGTH_LIMIT:
        {
          return AppLocalizations.of(context).communicationError;
        }
      default:
        {
          return AppLocalizations.of(context).communicationError;
        }
    }
  }
}
