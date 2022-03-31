
import 'dart:async';

import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../MainNotifier.dart';

class SaverNotifier extends MainNotifier {
  Timer timerClock;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  void firebaseCloudMessaging_Listeners() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        utilities.printLog("_firebaseMessaging: $message");
        await handlerMSGFirebase(message);
      },
      onResume: (Map<String, dynamic> message) async {
      },
      onLaunch: (Map<String, dynamic> message) async {
//        await handlerMSGFirebase(message, context);
      },
    );
  }

  Future handlerMSGFirebase(Map<String, dynamic> message) async {
    navigationService.navigatePop(context, arguments: message);
  }

  void runClock() {
    timerClock?.cancel();
    timerClock = Timer.periodic(Duration(minutes: 1), (Timer t) {
      notifyListeners();
    });
  }

  @override
  void dispose() {
    timerClock?.cancel();
    super.dispose();
  }
}
