import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  const Loading({
    Key key,
    this.child,
    this.visible,
  }) : super(key: key);
  final Widget child;
  final bool visible;

  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.child,
        Visibility(
          visible: widget.visible,
          child: Center(child: CircularProgressIndicator()),
        ),
      ],
    );
  }
}
