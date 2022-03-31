import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppColors.dart';
import 'package:check_in_pro_for_visitor/src/constants/AppDestination.dart';
import 'package:check_in_pro_for_visitor/src/constants/Constants.dart';
import 'package:check_in_pro_for_visitor/src/model/FormatQRCode.dart';
import 'package:check_in_pro_for_visitor/src/services/printService/PrinterModel.dart';
import 'package:check_in_pro_for_visitor/src/utilities/AppLocalizations.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Style.dart';
import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/src/widgets/image.dart' as WidgetsImages;
import 'dart:ui' as ui;

class TemplatePrint extends StatefulWidget {
  TemplatePrint(
      {Key key,
      this.indexTemplate,
      this.visitorName,
      this.phoneNumber,
      this.fromCompany,
      this.toCompany,
      this.visitorType,
      this.idCard,
      this.printerModel,
      this.inviteCode,
      this.badgeTemplate,
      this.isBuilding = false,
      this.floor})
      : super(key: key);

  String indexTemplate;
  String visitorName;
  String phoneNumber;
  String fromCompany;
  String toCompany;
  String visitorType;
  String idCard;
  PrinterModel printerModel;
  String inviteCode;
  String badgeTemplate;
  bool isBuilding;
  String floor;

  @override
  TemplatePrintSate createState() => TemplatePrintSate();
}

class TemplatePrintSate extends State<TemplatePrint> {
  var cardHeight;
  var cardWidth;
  var styleName;
  var styleNormalBold;
  var styleNormal;
  var styleType;
  var minBig;
  var maxBig;
  var minSmall;
  var maxSmall;
  var floor;
  static const SIZE_QR = 86.0;

  @override
  Widget build(BuildContext context) {
    initValue();
    if (widget.badgeTemplate != null && widget.badgeTemplate.isNotEmpty) {
      return htmlTemplate();
    }
    switch (widget.indexTemplate) {
      case (Constants.BADGE_TEMPLATE + "2"):
        {
          return templateCard02();
        }
      case (Constants.BADGE_TEMPLATE + "3"):
        {
          return templateCard03();
        }
      case (Constants.BADGE_TEMPLATE + "5"):
        {
          return templateCard05();
        }
      case (Constants.BADGE_TEMPLATE + "6"):
        {
          return templateCard06();
        }
      case (Constants.BADGE_TEMPLATE + "7"):
        {
          return templateCard07();
        }
      case (Constants.BADGE_TEMPLATE + "8"):
        {
          return templateCard08();
        }
      default:
        {
          return templateCard02();
        }
    }
  }

  Container htmlTemplate() {
    var newBadge = widget.badgeTemplate
        .replaceAll(Constants.BADGE_NAME, widget.visitorName)
        .replaceAll(Constants.BADGE_CODE, widget.inviteCode)
        .replaceAll(Constants.BADGE_ID, widget.idCard)
        .replaceAll(Constants.BADGE_PHONE, widget.phoneNumber)
        .replaceAll(Constants.BADGE_TYPE, widget.visitorType)
        .replaceAll(Constants.BADGE_FROM, widget.fromCompany)
        .replaceAll(Constants.BADGE_QR, widget.badgeTemplate);
    return Container(
      height: cardHeight,
      width: cardWidth,
      child: HtmlWidget(
        newBadge,
      ),
    );
  }

  Future<String> createQRImage() async {
    final qrValidationResult = QrValidator.validate(
      data: getDataQR(),
      version: QrVersions.auto,
      errorCorrectionLevel: QrErrorCorrectLevel.L,
    );
    final qrCode = qrValidationResult.qrCode;
    final painter = QrPainter.withQr(
      qr: qrCode,
      color: const Color(0xFF000000),
      gapless: true,
      embeddedImageStyle: null,
      embeddedImage: null,
    );
    final picData = await painter.toImageData(2048, format: ui.ImageByteFormat.png);
    var path = await Utilities().getLocalPathFile(Constants.FOLDER_TEMP, "qr_qr", "", null);
    var file = await Utilities().writeToFile(picData, path);
    var base64 = base64Encode(file.readAsBytesSync());
    return base64;
  }

  void initValue() {
    if (widget?.printerModel?.type == PrinterType.BROTHER) {
      cardWidth = AppDestination.CARD_WIGHT;
      cardHeight = AppDestination.CARD_HEIGHT;
    } else {
      cardWidth = AppDestination.CARD_WIGHT_ESC;
      cardHeight = AppDestination.CARD_HEIGHT_ESC;
    }
    if ((widget.toCompany != null && widget.toCompany.isNotEmpty) &&
        (widget.fromCompany != null && widget.fromCompany.isNotEmpty)) {
      if (widget.toCompany.length > 35 && widget.fromCompany.length > 35) {
        minBig = 8.0;
        maxBig = 12.0;
        minSmall = 1.0;
        maxSmall = 8.0;
      } else {
        minBig = 10.0;
        maxBig = 13.0;
        minSmall = 1.0;
        maxSmall = 10.0;
      }
      styleName = Style.instance.styleTextName;
      styleNormalBold = styleNormalBold;
      styleNormal = Style.instance.styleTextNormal;
      styleType = styleType;
    } else {
      minBig = 12.0;
      maxBig = 16.0;
      minSmall = 5.0;
      maxSmall = 12.0;
      styleName = Style.instance.styleTextName;
      styleNormalBold = styleNormalBold;
      styleNormal = Style.instance.styleTextNormal;
      styleType = Style.instance.styleTextType;
    }

    if (widget.isBuilding) {
      widget.phoneNumber =  "";
      widget.fromCompany =  "";
      widget.visitorType =  "";
      widget.idCard =  "";
      floor = (widget.floor == null || widget.floor.isEmpty) ? "" : " - " + AppLocalizations.of(context).floorText + " " + widget.floor;
    }
  }

  Widget templateCard02() {
    return new Container(
      height: cardHeight,
      width: cardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerRight,
                  child: QrImage(
                    size: SIZE_QR,
                    data: getDataQR(),
                  ),
                ),
                Expanded(
                  //flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 2),
                          child: AutoSizeText(widget.visitorName.toUpperCase(),
                              maxLines: 3, minFontSize: minBig, maxFontSize: maxBig, style: styleName),
                        ),
                      ),
                      if (widget.phoneNumber != null && widget.phoneNumber.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(AppLocalizations.of(context).cardPhone,
                                minFontSize: minSmall, maxFontSize: maxSmall, style: styleNormal),
                          ),
                        ),
                      if (widget.phoneNumber != null && widget.phoneNumber.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(widget.phoneNumber,
                                maxLines: 1, minFontSize: minSmall, maxFontSize: maxSmall, style: styleNormalBold),
                          ),
                        ),
                      if (widget.idCard != null && widget.idCard.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardID,
                              style: styleNormal,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.idCard != null && widget.idCard.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.idCard,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.fromCompany != null && widget.fromCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardFrom,
                              style: styleNormal,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.fromCompany != null && widget.fromCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.fromCompany,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.toCompany != null && widget.toCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardTo,
                              style: styleNormal,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.toCompany != null && widget.toCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              widget.toCompany + floor,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: FractionalOffset.centerLeft,
                  child: new Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 2),
                    child: Align(
                      alignment: FractionalOffset.centerRight,
                      child: WidgetsImages.Image.asset("assets/images/logo_company.png", scale: 4, color: Colors.white),
                    ),
                  ),
                ),
                Align(
                  alignment: FractionalOffset.centerRight,
                  child: new Padding(
                      padding: EdgeInsets.only(top: 4, bottom: 1),
                      child: new AutoSizeText(widget.visitorType, maxLines: 3, style: styleType)),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  String getDataQR() {
    FormatQRCode formatQRCode;
    if (widget.inviteCode != null) {
      formatQRCode = FormatQRCode(FormatQRCode.EVENT, widget.inviteCode);
    } else if (widget.phoneNumber != null) {
      formatQRCode = FormatQRCode(FormatQRCode.CHECK_OUT_PHONE, widget.phoneNumber);
    } else if (widget.idCard != null) {
      formatQRCode = FormatQRCode(FormatQRCode.CHECK_OUT_ID, widget.idCard);
    }
    return jsonEncode(formatQRCode);
  }

  Widget templateCard03() {
    return new Container(
      height: cardHeight,
      width: cardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: FractionalOffset.bottomCenter,
                      child: Align(
                        alignment: FractionalOffset.topCenter,
                        child:
                            WidgetsImages.Image.asset("assets/images/logo_company.png", scale: 6, color: Colors.black),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: QrImage(
                        size: SIZE_QR,
                        data: getDataQR(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    )
                  ],
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 2),
                          child: AutoSizeText(
                            widget.visitorName.toUpperCase(),
                            maxLines: 3,
                            style: styleName,
                            minFontSize: minBig,
                            maxFontSize: maxBig,
                          ),
                        ),
                      ),
                      if (widget.phoneNumber != null && widget.phoneNumber.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardPhone,
                              style: styleNormal,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.phoneNumber != null && widget.phoneNumber.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(widget.phoneNumber,
                                maxLines: 3, minFontSize: minSmall, maxFontSize: maxSmall, style: styleNormalBold),
                          ),
                        ),
                      if (widget.idCard != null && widget.idCard.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardID,
                              style: styleNormal,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.idCard != null && widget.idCard.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(widget.idCard,
                                maxLines: 2, minFontSize: minSmall, maxFontSize: maxSmall, style: styleNormalBold),
                          ),
                        ),
                      if (widget.fromCompany != null && widget.fromCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardFrom,
                              style: styleNormal,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.fromCompany != null && widget.fromCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(widget.fromCompany,
                                maxLines: 2, minFontSize: minSmall, maxFontSize: maxSmall, style: styleNormalBold),
                          ),
                        ),
                      if (widget.toCompany != null && widget.toCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardTo,
                              style: styleNormal,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.toCompany != null && widget.toCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(widget.toCompany + floor,
                                maxLines: 2, minFontSize: minSmall, maxFontSize: maxSmall, style: styleNormalBold),
                          ),
                        ),
                      Align(
                        alignment: FractionalOffset.bottomRight,
                        child: new Padding(
                            padding: EdgeInsets.only(bottom: 1.0, right: 10),
                            child: new AutoSizeText(widget.visitorType,
                                maxLines: 1,
                                minFontSize: minSmall,
                                maxFontSize: maxSmall,
                                style: Style.instance.styleTextBack15)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget templateCard05() {
    return new Container(
      height: cardHeight,
      width: cardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.black,
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: FractionalOffset.topLeft,
                  child: new Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 2),
                    child: Align(
                      alignment: FractionalOffset.centerLeft,
                      child: WidgetsImages.Image.asset("assets/images/logo_company.png", scale: 4, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 5,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: 2,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 2),
                          child: AutoSizeText(widget.visitorName.toUpperCase(),
                              maxLines: 3, minFontSize: minBig, maxFontSize: maxBig, style: styleName),
                        ),
                      ),
                      if (widget.idCard != null && widget.idCard.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardID,
                              style: styleNormal,
                              maxLines: 1,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.idCard != null && widget.idCard.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.idCard,
                              maxLines: 3,
                              style: styleNormalBold,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.phoneNumber != null && widget.phoneNumber.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardPhone,
                              style: styleNormal,
                              maxLines: 1,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.phoneNumber != null && widget.phoneNumber.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.phoneNumber,
                              maxLines: 3,
                              style: styleNormalBold,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.fromCompany != null && widget.fromCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardFrom,
                              style: styleNormal,
                              maxLines: 1,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.fromCompany != null && widget.fromCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.fromCompany,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.toCompany != null && widget.toCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardTo,
                              style: styleNormal,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.toCompany != null && widget.toCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.toCompany + floor,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: QrImage(
                        size: SIZE_QR,
                        data: getDataQR(),
                      ),
                    ),
                    Align(
                      alignment: FractionalOffset.topCenter,
                      child: new Padding(
                        padding: EdgeInsets.only(left: 5, right: 10, bottom: 15),
                        child: Align(
                          alignment: FractionalOffset.topCenter,
                          child: AutoSizeText(widget.visitorType,
                              maxLines: 1,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                              style: Style.instance.styleTextBack15),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          )
        ],
      ),
    );
  }

  Widget templateCard06() {
    return new Container(
      height: cardHeight,
      width: cardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            color: Colors.black,
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: FractionalOffset.topLeft,
                  child: new Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 2),
                    child: Align(
                      alignment: FractionalOffset.center,
                      child: WidgetsImages.Image.asset("assets/images/logo_company.png", scale: 4, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 2,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      SizedBox(
                        height: 2,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 2),
                          child: AutoSizeText(widget.visitorName.toUpperCase(),
                              maxLines: 3, minFontSize: minBig, maxFontSize: maxBig, style: styleName),
                        ),
                      ),
                      if (widget.phoneNumber != null && widget.phoneNumber.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardPhone,
                              style: styleNormal,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.phoneNumber != null && widget.phoneNumber.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.phoneNumber,
                              maxLines: 3,
                              style: styleNormalBold,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.idCard != null && widget.idCard.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardID,
                              style: styleNormal,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.idCard != null && widget.idCard.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.idCard,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.fromCompany != null && widget.fromCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardFrom,
                              style: styleNormal,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.fromCompany != null && widget.fromCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.fromCompany,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.toCompany != null && widget.toCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardTo,
                              style: styleNormal,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.toCompany != null && widget.toCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.toCompany + floor,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: QrImage(
                        size: SIZE_QR,
                        data: getDataQR(),
                      ),
                    ),
                    Align(
                      alignment: FractionalOffset.topCenter,
                      child: new Padding(
                        padding: EdgeInsets.only(left: 5, right: 5, bottom: 15),
                        child: Align(
                          alignment: FractionalOffset.topCenter,
                          child: AutoSizeText(
                            widget.visitorType,
                            maxLines: 1,
                            style: Style.instance.styleTextBack15,
                            minFontSize: minSmall,
                            maxFontSize: maxSmall,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            height: 2,
          )
        ],
      ),
    );
  }

  Widget templateCard07() {
    return new Container(
      height: cardHeight,
      width: cardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 2),
                          child: AutoSizeText(widget.visitorName.toUpperCase(),
                              minFontSize: minBig, maxFontSize: maxBig, style: styleName),
                        ),
                      ),
                      if (widget.phoneNumber != null && widget.phoneNumber.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardPhone,
                              style: styleNormal,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.phoneNumber != null && widget.phoneNumber.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(widget.phoneNumber,
                                maxLines: 3, minFontSize: minSmall, maxFontSize: maxSmall, style: styleNormalBold),
                          ),
                        ),
                      if (widget.idCard != null && widget.idCard.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardID,
                              style: styleNormal,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.idCard != null && widget.idCard.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.idCard,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.fromCompany != null && widget.fromCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardFrom,
                              style: styleNormal,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.fromCompany != null && widget.fromCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.fromCompany,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.toCompany != null && widget.toCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardTo,
                              style: styleNormal,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.toCompany != null && widget.toCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.toCompany + floor,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: QrImage(
                    size: SIZE_QR,
                    data: getDataQR(),
                  ),
                ),
                SizedBox(
                  width: 15,
                )
              ],
            ),
          ),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }

  Widget templateCard08() {
    return new Container(
      height: cardHeight,
      width: cardWidth,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(right: 10),
                    child: QrImage(
                      size: SIZE_QR,
                      data: getDataQR(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 2),
                          child: AutoSizeText(widget.visitorName.toUpperCase(),
                              maxLines: 3, minFontSize: minBig, maxFontSize: maxBig, style: styleName),
                        ),
                      ),
                      if (widget.phoneNumber != null && widget.phoneNumber.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardPhone,
                              style: styleNormal,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.phoneNumber != null && widget.phoneNumber.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(widget.phoneNumber,
                                maxLines: 3, minFontSize: minSmall, maxFontSize: maxSmall, style: styleNormalBold),
                          ),
                        ),
                      if (widget.idCard != null && widget.idCard.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardID,
                              style: styleNormal,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.idCard != null && widget.idCard.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.idCard,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.fromCompany != null && widget.fromCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardFrom,
                              style: styleNormal,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.fromCompany != null && widget.fromCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.fromCompany,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.toCompany != null && widget.toCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            child: AutoSizeText(
                              AppLocalizations.of(context).cardTo,
                              style: styleNormal,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                      if (widget.toCompany != null && widget.toCompany.isNotEmpty)
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText(
                              widget.toCompany + floor,
                              style: styleNormalBold,
                              maxLines: 2,
                              minFontSize: minSmall,
                              maxFontSize: maxSmall,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget templateDemo() {
    return new Container(
      height: AppDestination.CARD_HEIGHT,
      width: AppDestination.CARD_WIGHT,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText("Welcome to",
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Helvetica-Light",
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 2),
                            child: AutoSizeText("UNIT Corp",
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Helvetica-Light",
                                )),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Divider(height: 2, thickness: 1, color: AppColor.LINE_COLOR),
                      SizedBox(
                        height: 8,
                      ),
                      Container(
                        child: Text(
                          "https://unit.com.vn",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Helvetica-Light",
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Container(
                        child: Text(
                          "Hotline: 0949 803 103",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Helvetica-Light",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    padding: EdgeInsets.only(right: 0),
                    child: QrImage(
                      size: SIZE_QR,
                      data: (widget.phoneNumber.isEmpty) ? "https://unit.com.vn" : widget.phoneNumber,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 10, right: 10),
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: FractionalOffset.topLeft,
                  child: new Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 2),
                    child: Align(
                      alignment: FractionalOffset.centerLeft,
                      child: WidgetsImages.Image.asset("assets/images/logo_company.png", scale: 4, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget templateDemo02() {
    return Container(
      height: AppDestination.CARD_HEIGHT,
      width: AppDestination.CARD_WIGHT,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Image.asset("assets/images/logo_unit.png", scale: 6, color: Colors.black),
                Container(
                  height: 25,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 2),
                      child: AutoSizeText(widget?.visitorName ?? "",
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w300,
                            fontFamily: "Helvetica-Light",
                          )),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 2),
                      child: AutoSizeText(widget?.inviteCode ?? "",
                          maxLines: 1,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Helvetica-Light",
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.black,
            width: double.maxFinite,
            padding: EdgeInsets.only(left: 3, right: 3),
            height: 25,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Align(
                  alignment: FractionalOffset.topLeft,
                  child: new Padding(
                    padding: EdgeInsets.only(top: 2, bottom: 2),
                    child: Align(
                      alignment: FractionalOffset.centerLeft,
                      child: Image.asset("assets/images/logo_company.png", scale: 4, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
