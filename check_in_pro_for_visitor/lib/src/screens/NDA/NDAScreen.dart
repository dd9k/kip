import 'dart:ui';
import 'package:check_in_pro_for_visitor/src/screens/NDA/NDANotifier.dart';

import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:hand_signature/signature.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/LiteRollingSwitch.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/SizeConfig.dart';
import 'package:check_in_pro_for_visitor/src/widgetUtilities/RaisedGradientButton.dart';
import 'package:provider/provider.dart';

class NDAScreen extends StatefulWidget {
  static const String route_name = '/NDA-screen';
  final String title;

  NDAScreen({this.title});

  @override
  NDAScreenState createState() => NDAScreenState();
}

class NDAScreenState extends State<NDAScreen> {
  final String html = '''
    <img src='https://cip-webapp.unit.vn/assets/images/logo-unit-blue.png' height='40' width='180'/>
  <h3 id="Terms_Of_Use_Vs_Terms_And_Conditions">Terms of Use Vs. Terms and Conditions</h3>
  <p>Legally speaking, <strong>a Terms of Use agreement is the same thing as a Terms and Conditions agreement</strong>.</p>
  <p>We're using the phrase "Terms of Use" to describe <strong>a general agreement between you and your users</strong>. Different companies use different names for this type of agreement, including:</p>
  <ul>
  <li>Terms and Conditions</li>
  <li>Terms of Service</li>
  <li>User Agreement</li>
  <li>Acceptable Use Policy</li>
  </ul>
  <p style="color: rgb(23, 156, 97)">These documents usually <strong>serve the same purpose</strong> but can be used in different contexts.</p>
  <h3 id="Terms_Of_Use_Vs_Privacy_Policy">Terms of Use Vs. Privacy Policy</h3>
  <p><strong>A Terms of Use agreement is very different from a Privacy Policy</strong>.</p>
  <p>A Privacy Policy is a form of notice that explains the ways in which a company <em>processes personal information</em>.</p>
  <p><strong>A Privacy Policy is a legal requirement</strong> for almost every company that operates a website or online service under laws such as the <a href="https://www.termsfeed.com/blog/gdpr/">EU General Data Protection Regulation (GDPR)</a> or <a href="https://www.termsfeed.com/blog/caloppa/">California Online Privacy Protection Act (CalOPPA)</a>.</p>
  ''';

  bool _isTurnOnOverlay = true;
  bool _isDisableBtnContinue = true;
  bool scrollListEnable = true;
  double borderWithSignature = 0.0;
  String data;
  static const IconData eraser = IconData(0xf12d, fontFamily: 'Eraser-Regular', fontPackage: null);

  static const double sizeHS = 2.0;
  static const double maxSizeHS = 2.0;
  final HandSignatureControl control = new HandSignatureControl(
    threshold: 5.0,
    smoothRatio: 0.65,
    velocityRange: 2.0,
  );

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<NDANotifier>(context, listen: false);
    SizeConfig().init(context);

    return MaterialApp(
      title: 'Signature Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.white70,
        body: SafeArea(
            child: SingleChildScrollView(
                physics: scrollListEnable ? AlwaysScrollableScrollPhysics() : NeverScrollableScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(
                        left: 10,
                        right: 10,
                      ),
                      child: HtmlWidget(provider.formatHTMLRender(html)),
                    ),
                    SizedBox(height: 20),
                    ConstrainedBox(
                        constraints: BoxConstraints.expand(height: 250),
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          overflow: Overflow.clip,
                          children: <Widget>[
                            _signatureGIF(context),
                            _overlayTapGesture(context),
                            _handSignature(context),
                            Positioned(
                              top: 10,
                              right: 10,
                              child: Padding(
                                  padding: EdgeInsets.only(bottom: 10, right: 10),
                                  child: Align(
                                    alignment: Alignment.topRight,
                                    child: Wrap(
                                      spacing: 15,
                                      children: <Widget>[
                                        // Button DONE
                                        _iconButtonForSignature(context, Icons.done, Colors.lightGreen, () {
                                          setState(() {
                                            scrollListEnable = true;
                                            borderWithSignature = 0.0;
                                            if (control.isFilled) {
                                              _isTurnOnOverlay = false;
                                              _isDisableBtnContinue = false;
                                            } else {
                                              _isTurnOnOverlay = true;
                                              _isDisableBtnContinue = true;
                                            }
                                            data = control.toSvg(
                                              color: Colors.black87,
                                              size: sizeHS,
                                              maxSize: maxSizeHS,
                                              type: SignatureDrawType.arc,
                                            );
                                          });
                                        }),
                                        // Button CLEAR
                                        _iconButtonForSignature(context, eraser, Colors.redAccent, () {
                                          setState(() {
                                            control.clear();
                                          });
                                        })
                                      ],
                                    ),
                                  )),
                            ),
                          ],
                        )),
                    _switcherSendEmail(context),
                    _buttonContinue(context, provider),
                  ],
                ))),
      ),
    );
  }

  Widget _signatureGIF(BuildContext context) {
    if (_isTurnOnOverlay) {
      return Container(
        height: 250,
        width: double.infinity,
        child: Center(
          child: Image.asset(
            'assets/images/signature.gif',
          ),
        ),
      );
    }
    return Container();
  }

  Widget _overlayTapGesture(BuildContext context) {
    if (_isTurnOnOverlay) {
      return ClipRect(
        child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
            child: Container(
              height: 250,
              width: double.infinity,
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  runAlignment: WrapAlignment.center,
                  spacing: 20,
                  direction: Axis.vertical,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 60),
                      child: Image.asset(
                        'assets/images/touch_here.gif',
                        fit: BoxFit.contain,
                        scale: 1.5,
                      ),
                    ),
                    Text(AppLocalizations.of(context).tapHereSignatureContent,
                        style: TextStyle(
                          fontSize: AppDestination.TEXT_NORMAL,
                          color: AppColor.BLACK_TEXT_COLOR,
                          fontStyle: FontStyle.italic,
                        )),
                  ],
                ),
              ),
            )),
      );
    }
    return Container();
  }

  Widget _buttonContinue(BuildContext context, NDANotifier provider) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;
    int sizeRender = isPortrait ? 70 : 50;

    return Padding(
      padding: EdgeInsets.only(
        top: AppDestination.PADDING_BIGGER,
        left: AppDestination.PADDING_NORMAL,
        right: AppDestination.PADDING_NORMAL,
        bottom: AppDestination.PADDING_BIGGER,
      ),
      child: SizedBox(
          width: SizeConfig.blockSizeHorizontal * sizeRender,
          child: RaisedGradientButton(
              disable: _isDisableBtnContinue,
              btnText: AppLocalizations.of(context).btnContinue,
              onPressed: () {
                String imgBytes = provider.convertSvgStringToBytes(data);
                String htmlContent = provider.addSignatureToHTML(imgBytes, html);
                provider.saveFilePDFThroughHTML(htmlContent, context);
              })),
    );
  }

  Widget _switcherSendEmail(BuildContext context) {
    const duration = 400;

    return Padding(
      padding: EdgeInsets.only(top: 20, left: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Text(AppLocalizations.of(context).sendMailNDAContent,
                style: TextStyle(fontSize: AppDestination.TEXT_SMALL, color: AppColor.BLACK_TEXT_COLOR)),
          ),
          LiteRollingSwitch(
            value: false,
            textOff: AppLocalizations.of(context).btnNo,
            textOn: AppLocalizations.of(context).btnYes,
            iconOff: Icons.remove_circle_outline,
            iconOn: Icons.send,
            animationDuration: const Duration(milliseconds: duration),
            onChanged: (bool state) {},
          ),
        ],
      ),
    );
  }

  Widget _iconButtonForSignature(BuildContext context, IconData icons, Color colors, Function callback) {
    const size = 44.0;
    const duration = 300;

    return AnimatedOpacity(
        opacity: scrollListEnable ? 0.0 : 1.0,
        duration: Duration(milliseconds: duration),
        child: Material(
          color: Colors.transparent,
          child: Ink(
            width: size,
            height: size,
            decoration: ShapeDecoration(
              color: scrollListEnable ? Colors.transparent : colors,
              shape: CircleBorder(),
            ),
            child: IconButton(
              iconSize: size / 2,
              icon: Icon(icons),
              color: Colors.white,
              onPressed: () {
                callback();
              },
            ),
          ),
        ));
  }

  Widget _handSignature(BuildContext context) {
    return GestureDetector(
        onTap: () {
          setState(() {
            scrollListEnable = false;
            borderWithSignature = 1.0;
            _isDisableBtnContinue = true;
          });
        },
        child: Container(
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(scrollListEnable ? 0.2 : 1.0),
                border: Border.all(
                  width: borderWithSignature,
                  color: Colors.transparent,
                )),
            height: 250,
            width: double.infinity,
            child: IgnorePointer(
              ignoring: scrollListEnable,
              child: HandSignaturePainterView(
                  control: control,
                  type: SignatureDrawType.shape,
                  color: Colors.black87,
                  width: sizeHS,
                  maxWidth: maxSizeHS),
            )));
  }
}
