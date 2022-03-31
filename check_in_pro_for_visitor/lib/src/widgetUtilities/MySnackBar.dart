import 'package:async/async.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/services/ConnectionStatusSingleton.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/material.dart';

class MySnackBar extends StatefulWidget {
  final String message;
  final bool initState;
  final Widget icon;
  final Color backgroundColor;
  final Color textColor;
  final double height;
  final double size;

  const MySnackBar({
    Key key,
    this.message = "",
    this.initState,
    this.icon,
    this.backgroundColor,
    this.textColor,
    this.height,
    this.size
  }) : super(key: key);

  @override
  MySnackBarState createState() => MySnackBarState();
}

class MySnackBarState extends State<MySnackBar> {
  var isConnection;
  AsyncMemoizer<bool> memCache = AsyncMemoizer();

  @override
  void initState() {
    super.initState();
    if (widget.initState == null) {
      ConnectionStatusSingleton.getInstance().connectionChange.listen((dynamic result) {
        setState(() {
          isConnection = result;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: memCache.runOnce(() => Utilities().isConnectInternet(isChangeState: false)),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          var isVisible = widget.initState ?? ((isConnection != null) ? !isConnection : !snapshot.data);
          return Visibility(
            visible: isVisible,
            child: Container(
              color: widget.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 20, top: 5, bottom: 5),
                    child: widget.icon,
                  ),
                  Text(
                    widget.message,
                    style: TextStyle(color: widget.textColor, fontSize: widget.size, decoration: TextDecoration.none),
                  )
                ],
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
