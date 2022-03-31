import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:signalr_client/signalr_client.dart';
import 'package:logging/logging.dart';

class SignalRService {
  HubConnection _hubConnection;
  bool isStopping = false;

  Future<void> connectSignalR(Function callBack, bool isRestart) async {
    try {
      if (_hubConnection != null) {
        if (isRestart) {
          await _hubConnection.stop();
          _hubConnection.on(Constants.SIGNAL_R_METHOD, callBack);
          await _hubConnection.start();
        } else {
          _hubConnection.on(Constants.SIGNAL_R_METHOD, callBack);
        }
        return;
      }
      final hubProtLogger = Logger("SignalR - hub");
      final transportProtLogger = Logger("SignalR - transport");
      final httpOptions = new HttpConnectionOptions(
          accessTokenFactory: () {
            return Utilities().getToken1();
          },
          logger: transportProtLogger,
          transport: HttpTransportType.LongPolling);
      _hubConnection = HubConnectionBuilder()
          .withUrl('${Constants.URL_LIST[Constants().indexURL]}${Constants.SIGNAL_R_ENDPOINT}', options: httpOptions)
          .configureLogging(hubProtLogger)
          .build();
      _hubConnection.on(Constants.SIGNAL_R_METHOD, callBack);
      _hubConnection.onclose((e) {
        if (!isStopping) {
          connectSignalR(callBack, true);
        }
      });
      _hubConnection.serverTimeoutInMilliseconds = 100000;
      _hubConnection.keepAliveIntervalInMilliseconds = 10000;
      if (_hubConnection.state != HubConnectionState.Connected) {
        await _hubConnection.start();
      }
    } catch (e) {}
  }

  Future<void> stopSignalR() async {
    isStopping = true;
    try {
      if (_hubConnection != null && _hubConnection.state == HubConnectionState.Connected) {
        await _hubConnection.stop();
        _hubConnection = null;
        isStopping = false;
        return;
      }
    } catch (e) {
      isStopping = false;
    }
  }
}
