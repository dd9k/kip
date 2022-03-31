import 'dart:async';

import 'package:check_in_pro_for_visitor/src/constants/AppString.dart';
import 'package:chopper/chopper.dart';

import 'ConnectionStatusSingleton.dart';

class MobileDataInterceptor implements RequestInterceptor {
  @override
  FutureOr<Request> onRequest(Request request) async {
    final hasConnection = ConnectionStatusSingleton.getInstance().hasConnection;

    if (!hasConnection) {
      throw MobileException();
    }

    return request;
  }
}

class MobileException implements Exception {
  final message = AppString.NO_INTERNET;

  @override
  String toString() => message;
}
