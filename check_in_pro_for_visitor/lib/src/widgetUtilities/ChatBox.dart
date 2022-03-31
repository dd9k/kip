import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/constants/Styles.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/TyperAnimatedTextKit.dart';
import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  final String contentMess;

  ChatBox({this.contentMess});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ConstrainedBox(
      constraints: BoxConstraints.tight(Size(double.infinity, SizeConfig.safeBlockVertical * 23)),
      child: Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: <Widget>[
          Positioned(
            child: Container(
              constraints: BoxConstraints(minWidth: 300, minHeight: 50),
              decoration: BoxDecoration(color: Color(0xff0470da), borderRadius: BorderRadius.circular(40)),
              child: Center(
                  child: Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TyperAnimatedTextKit(
                    text: [
                      "$contentMess",
                    ],
                    textStyle: Styles.messageTxtBox,
                    textAlign: TextAlign.center,
                    alignment: AlignmentDirectional.topStart // or Alignment.topLeft
                    ),
              )),
            ),
            right: 135,
            bottom: 70,
          ),
          Positioned(
            child: Stack(
              children: <Widget>[
                Container(
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            alignment: Alignment.center,
                            width: 10,
                            height: 10,
                            decoration: const BoxDecoration(color: Color(0xff0470da), shape: BoxShape.circle)),
                      ),
                      CircleAvatar(
                        radius: 40,
                        child: Image.asset(
                          'assets/images/chat_box.png',
                          cacheWidth: 120 * SizeConfig.devicePixelRatio,
                          cacheHeight: 120 * SizeConfig.devicePixelRatio,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            bottom: 25,
            left: width - 155,
          )
        ],
      ),
    );
  }
}
