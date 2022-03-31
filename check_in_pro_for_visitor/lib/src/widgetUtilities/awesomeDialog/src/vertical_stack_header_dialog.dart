import 'package:flutter/material.dart';

class VerticalStackDialog extends StatelessWidget {
  final String title;
  final String desc;
  final Widget btnOk;
  final Widget btnCancel;
  final Widget header;
  final Widget body;
  final bool isDense;
  final bool isShowImage;
  final AlignmentGeometry aligment;
  final EdgeInsetsGeometry padding;

  const VerticalStackDialog({
    Key key,
    @required this.title,
    @required this.desc,
    this.btnOk,
    this.btnCancel,
    this.isShowImage,
    this.body,
    this.aligment,
    this.isDense,
    @required this.header,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: aligment,
      child: Stack(
        children: <Widget>[
          Positioned(
              child: Align(
            alignment: Alignment.center,
            child: Container(
              width: 500,
              padding: isDense
                  ? EdgeInsets.only(top: 65.0, left: 15.0, right: 15.0, bottom: 10.0)
                  : EdgeInsets.only(top: 65.0, left: 40.0, right: 40.0, bottom: 10.0),
              child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
                elevation: 0.5,
                color: Theme.of(context).cardColor,
                child: Container(
                  padding: padding,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      if (isShowImage != null && isShowImage && header != null)
                        CircleAvatar(
                          backgroundColor: Theme.of(context).cardColor,
                          radius: 55.0,
                          child: header,
                        ),
                      SizedBox(
                        height: (isShowImage != null && isShowImage && header != null) ? 3.0 : 30.0,
                      ),
                      body ??
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                title,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, height: 1.25),
                              ),
                              if (desc != null)
                                SizedBox(
                                  height: 10.0,
                                ),
                              if (desc != null)
                                Flexible(
                                  fit: FlexFit.loose,
                                  child: SingleChildScrollView(
                                    physics: BouncingScrollPhysics(),
                                    child: Text(
                                      desc,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 23, height: 1.25),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                      SizedBox(
                        height: 16.0,
                      ),
                      if (btnOk != null || btnCancel != null)
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              btnCancel != null
                                  ? Expanded(
                                      child: btnCancel ?? Container(),
                                    )
                                  : Container(),
                              (btnCancel != null && btnOk != null)
                                  ? SizedBox(
                                      width: 10,
                                    )
                                  : Container(),
                              btnOk != null
                                  ? Expanded(
                                      child: btnOk,
                                    )
                                  : Container(),
                            ],
                          ),
                        ),
                      SizedBox(
                        height: 20.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
