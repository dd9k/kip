import 'dart:async';
import 'dart:core';

import 'dart:ui';

import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/ring.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'three_bounce.dart';

class ProcessWaiting extends StatefulWidget {
  final String message;
  final bool isVisible;

  const ProcessWaiting({Key key, this.message, this.isVisible}) : super(key: key);

  @override
  ProcessWaitingState createState() {
    return ProcessWaitingState();
  }
}

class ProcessWaitingState extends State<ProcessWaiting> {

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: widget.isVisible,
        child: AnimatedOpacity(
          opacity: widget.isVisible ? 1.0 : 0.0,
          duration: Duration(milliseconds: 500),
          child: Align(
              alignment: Alignment.center,
              child: Container(
                  width: 400,
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      color: Colors.white,
                      border: Border.all(
                        color: Colors.black,
                        width: 1.0,
                      )),
                  child: Center(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 30),
                          child: const SpinKitRing(
                            color: AppColor.MAIN_TEXT_COLOR,
                            lineWidth: 3.0,
                            size: 40,
                          ),
                        ),
                        Text(widget.message,
                            style: TextStyle(
                                fontSize: AppDestination.TEXT_BIG_WEL,
                                color: AppColor.MAIN_TEXT_COLOR,
                                decoration: TextDecoration.none)),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: const SpinKitThreeBounce(
                            color: AppColor.MAIN_TEXT_COLOR,
                            size: 20,
                          ),
                        )
                      ],
                    ),
                  ))),
        ),
      ),
    );
  }
}
