import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class ProcessQR extends StatefulWidget {
  final int timeOutInit;
  final int remainder;
  final Widget child;
  final double sizeChild;
  final VoidCallback functionCallBack;

  const ProcessQR({Key key, this.timeOutInit, this.child, this.sizeChild, this.functionCallBack, this.remainder}) : super(key: key);

  @override
  ProcessQRState createState() => ProcessQRState();
}

class ProcessQRState extends State<ProcessQR> with TickerProviderStateMixin {
  AnimationController controller;
  bool isFirstTime = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (controller != null) {
      controller?.dispose();
    }
    int timeInit = (widget.remainder != null && widget.remainder > 0) ? widget.remainder : widget.timeOutInit;
    createAnimation(timeInit);
    return Stack(
      alignment: Alignment.center,
      children: <Widget>[
        AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              return Container(
                width: widget.sizeChild + 100,
                height: widget.sizeChild + 100,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                    border: Border.all(
                      color: Colors.white,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(360))
                ),
                child: Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Positioned.fill(
                                  child: CustomPaint(
                                      painter: CustomTimerPainter(
                                        animation: controller,
                                        backgroundColor: AppColor.HINT_TEXT_COLOR,
                                        color: AppColor.GREEN,
                                      )),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
        widget.child,
//        AnimatedBuilder(
//            animation: controller,
//            builder: (context, child) {
//              return Align(
//                alignment: Alignment.centerLeft,
//                child: Container(
//                  color: (controller.value > 0.5 ) ? AppColor.GREEN : (controller.value > 0.25 ) ? Colors.amber : AppColor.RED_COLOR,
//                  height: controller.value * 100,
//                  width: widget.sizeChild,
//                ),
//              );
//            }),
      ],
    );
  }

  void createAnimation(int timeInit) {
    Utilities().printLog("timeInit $timeInit");
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: timeInit),
    );
    controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
    controller.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        if (isFirstTime) {
          isFirstTime = false;
          widget.functionCallBack();
          createAnimation(widget.timeOutInit);
        } else {
          controller.reverse(from: controller.value == 0.0 ? 1.0 : controller.value);
          widget.functionCallBack();
        }
      }
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    double progress = (0.0 + animation.value) * 2 * math.pi;
    paint.color = (animation.value > 0.5 ) ? color : (animation.value > 0.25 ) ? Colors.amber : AppColor.RED_COLOR;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value || color != old.color || backgroundColor != old.backgroundColor;
  }
}
