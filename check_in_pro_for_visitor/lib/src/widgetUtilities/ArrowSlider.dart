import 'dart:async';
import 'dart:core';

import 'dart:ui';

import 'package:flutter/cupertino.dart';

class ArrowSlider extends StatefulWidget {
  final double width;
  final double height;

  const ArrowSlider({Key key, this.width, this.height}) : super(key: key);

  @override
  ArrowSliderState createState() {
    return ArrowSliderState();
  }
}

class ArrowSliderState extends State<ArrowSlider> {
  static const image1 = "assets/images/img1.png";
  static const image2 = "assets/images/img2.png";
  String img1 = image1;
  String img2 = image2;
  Timer _timer;
  int pos = 1;

  int _start = 20;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            _start = 20;
          } else {
            _start = _start - 1;
          }

          if (pos == 2) {
            pos = 1;
          } else {
            pos += 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    startTimer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
//          RotatedBox(
//              quarterTurns: 2,
//              child: Image.asset(
//                pos == 1 ? image1 : image2,
//                height: 45.0,
//                width: 25.0,
//                color: pos == 1 ? Color(0xFF0a75e5) : Color(0xFF0a75e5).withOpacity(0.5),
//              ),
//          ),
          RotatedBox(
            quarterTurns: 2,
            child: Image.asset(
              pos == 2 ? image1 : image2,
              height: 35.0,
              width: 20.0,
              color: pos == 2 ? Color(0xFF0a75e5) : Color(0xFF0a75e5).withOpacity(0.5),
            ),
          ),
//          RotatedBox(
//            quarterTurns: 2,
//            child: Image.asset(
//              pos == 3 ? image1 : image2,
//              height: 35.0,
//              width: 15.0,
//              color: pos ==  3 ? Color(0xFF0a75e5) : Color(0xFF0a75e5).withOpacity(0.5),
//            ),
//          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}
