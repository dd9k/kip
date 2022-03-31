import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/EventLog.dart';
import 'package:check_in_pro_for_visitor/src/model/VisitorLog.dart';
import 'package:flutter/material.dart';
import 'dart:isolate';
import 'dart:io';
import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:provider/provider.dart';
import 'package:check_in_pro_for_visitor/src/services/RequestApi.dart';
import 'package:check_in_pro_for_visitor/src/services/ApiCallBack.dart';
import 'package:check_in_pro_for_visitor/src/model/BaseResponse.dart';
import 'package:check_in_pro_for_visitor/src/model/Errors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SyncService {
  Isolate isolate;

  Future<void> syncAllLog(BuildContext context) async {
    var db = Provider.of<Database>(context, listen: false);
    var logs = await db.visitorLogDAO.getAlls();
    var prefer = await SharedPreferences.getInstance();
    if (logs.isEmpty) {
      prefer.setInt(Constants.KEY_LAST_SYNC, DateTime.now().millisecondsSinceEpoch);
      return;
    }
    logs.forEach((element) async {
      await Future.delayed(new Duration(milliseconds: 500));
      ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
        await clearData(db, element, prefer);
      }, (Errors message) async {
        await clearData(db, element, prefer);
      });
      var imageBytes;
      var imageIdBytes;
      if (element.imagePath == null || element.imagePath.isEmpty) {
        imageBytes = null;
      } else {
        imageBytes = File(element.imagePath).readAsBytesSync();
      }
      if (element.imageIdPath == null || element.imageIdPath.isEmpty) {
        imageIdBytes = null;
      } else {
        imageIdBytes = File(element.imageIdPath).readAsBytesSync();
      }
      ApiRequest().requestSync(context, element, imageBytes, imageIdBytes, callBack);
    });
  }

  Future<void> syncEventFail(BuildContext context) async {
    var db = Provider.of<Database>(context, listen: false);
    var logs = await db.eventLogDAO.getFailLogs();
    if (logs.isNotEmpty) {
      logs.forEach((element) async {
        await Future.delayed(new Duration(milliseconds: 500));
        ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
          if (element.inviteCode == null || element.inviteCode.isEmpty) {
            var eventLog = EventLog.fromJson(baseResponse.data);
            element.inviteCode = eventLog.inviteCode;
          }
          element.syncFail = false;
          element.isNew = false;
          db.eventLogDAO.updateRow(element);
        }, (Errors message) async {

        });
        var imageBytes;
        if (element.imagePath == null || element.imagePath.isEmpty) {
          imageBytes = null;
        } else {
          imageBytes = File(element.imagePath).readAsBytesSync();
        }
        ApiRequest().requestSyncEvent(context, element, imageBytes, callBack);
      });
    }
  }

  Future<void> syncEventNow(BuildContext context, EventLog eventLog) async {
    if (eventLog != null) {
      var db = Provider.of<Database>(context, listen: false);
      ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
        if (eventLog.inviteCode == null || eventLog.inviteCode.isEmpty) {
          var eventLogNew = EventLog.fromJson(baseResponse.data);
          eventLog.inviteCode = eventLogNew.inviteCode;
        }
        eventLog.syncFail = false;
        eventLog.isNew = false;
        db.eventLogDAO.updateRow(eventLog);
      }, (Errors message) async {
        eventLog.syncFail = true;
        db.eventLogDAO.updateRow(eventLog);
      });
      var imageBytes;
      if (eventLog.imagePath == null || eventLog.imagePath.isEmpty) {
        imageBytes = null;
      } else {
        imageBytes = File(eventLog.imagePath).readAsBytesSync();
      }
      ApiRequest().requestSyncEvent(context, eventLog, imageBytes, callBack);
    }
  }

  Future clearData(Database db, VisitorLog element, SharedPreferences prefer) async {
    await db.visitorLogDAO.deleteById(element.privateKey);
    var newLogs = await db.visitorLogDAO.getAlls();
    if (newLogs.length == 0) {
      prefer.setInt(Constants.KEY_LAST_SYNC, DateTime.now().millisecondsSinceEpoch);
    }
  }

//  Future<void> syncCheckOutLog(BuildContext context) async {
//    var db = Provider.of<Database>(context, listen: false);
//    var logs = await db.visitorLogDAO.getAllSignOut();
//    logs.forEach((element) async {
//      await Future.delayed(new Duration(milliseconds: 500));
//      ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
//        await db.visitorLogDAO.deleteById(element.privateKey);
//      }, (Errors message) {
//      });
//      var imageBytes;
//      if (element.imagePath == null || element.imagePath.isEmpty) {
//        imageBytes = null;
//      } else {
//        imageBytes = File(element.imagePath).readAsBytesSync();
//      }
//      ApiRequest().requestSync(context, element, imageBytes, callBack);
//    });
//  }
//
//  Future<void> syncSingleLog(BuildContext context, String privateKey) async {
//    var db = Provider.of<Database>(context, listen: false);
//    var log = await db.visitorLogDAO.getById(privateKey);
//    ApiCallBack callBack = ApiCallBack((BaseResponse baseResponse) async {
//      await db.visitorLogDAO.deleteById(log.privateKey);
//    }, (Errors message) {
//    });
//    var imageBytes;
//    if (log.imagePath == null || log.imagePath.isEmpty) {
//      imageBytes = null;
//    } else {
//      imageBytes = File(log.imagePath).readAsBytesSync();
//    }
//    ApiRequest().requestSync(context, log, imageBytes, callBack);
//  }

  void stopService() {
    if (isolate != null) {
      isolate.kill(priority: Isolate.immediate);
    }
  }
}
