import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:check_in_pro_for_visitor/src/utilities/Utilities.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

import 'detector_painters.dart';

class PictureScanner {
  static final PictureScanner _singleton = PictureScanner._internal();

  factory PictureScanner() {
    return _singleton;
  }

  PictureScanner._internal();

  String _pathFileImage;
  File _imageFile;
  Size _imageSize;
  dynamic _scanResults;
  Detector _currentDetector = Detector.text;
  final BarcodeDetector _barcodeDetector = FirebaseVision.instance.barcodeDetector();
  final FaceDetector _faceDetector = FirebaseVision.instance.faceDetector();
  final ImageLabeler _imageLabeler = FirebaseVision.instance.imageLabeler();
  final ImageLabeler _cloudImageLabeler = FirebaseVision.instance.cloudImageLabeler();
  final TextRecognizer _recognizer = FirebaseVision.instance.textRecognizer();
  final TextRecognizer _cloudRecognizer = FirebaseVision.instance.cloudTextRecognizer();

  List<String> res = List<String>();
  List<String> resAddress = List<String>();
  String fullName;
  String idCard;
  String birthday;
  String nationality = "Viet Nam/Vietnamese";
  String sex;
  String address;

  Future<String> getAndScanImage(String pathFile) async {
    _imageFile = null;
    _imageSize = null;

    _pathFileImage = pathFile;
    final File imageFile = File(_pathFileImage);
    //final File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      await _getImageSize(imageFile);
      await _scanImage(imageFile);
    }

    _imageFile = imageFile;
    Utilities().printLog('_scanResults: $_scanResults');
    return _scanResults as String;
  }

  Future<void> _getImageSize(File imageFile) async {
    final Completer<Size> completer = Completer<Size>();

    final Image image = Image.file(imageFile);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        ));
      }),
    );

    final Size imageSize = await completer.future;

    _imageSize = imageSize;
  }

  Future<void> _scanImage(File imageFile) async {
    _scanResults = null;
    fullName = null;
    birthday = null;
    idCard = null;
    sex = null;
    address = null;
    res.clear();
    resAddress.clear();
    final FirebaseVisionImage visionImage = FirebaseVisionImage.fromFile(imageFile);

    dynamic results;
    switch (_currentDetector) {
      case Detector.barcode:
        results = await _barcodeDetector.detectInImage(visionImage);
        break;
      case Detector.face:
        results = await _faceDetector.processImage(visionImage);
        break;
      case Detector.label:
        results = await _imageLabeler.processImage(visionImage);
        break;
      case Detector.cloudLabel:
        results = await _cloudImageLabeler.processImage(visionImage);
        break;
      case Detector.text:
        results = await _recognizer.processImage(visionImage);
        final VisionText visionText = results;
        for (int index = 0; index < visionText.blocks.length; index++) {
          final String text = visionText.blocks[index].text;
          Utilities().printLog("value before = $text");
          findText(text);
          // get address
          if (text.contains(',')) {
            resAddress.add(text);
          }
        }
        Utilities().printLog("Data phan tich $res");
        var resxxx = createDataJsonInfo();
        _scanResults = resxxx;
        Utilities().printLog(" result = $resxxx");
        break;
      case Detector.cloudText:
        results = await _cloudRecognizer.processImage(visionImage);
        break;
      default:
        return;
    }
  }

  CustomPaint _buildResults(Size imageSize, dynamic results) {
    CustomPainter painter;

    switch (_currentDetector) {
      case Detector.barcode:
        painter = BarcodeDetectorPainter(_imageSize, results);
        break;
      case Detector.face:
        painter = FaceDetectorPainter(_imageSize, results);
        break;
      case Detector.label:
        painter = LabelDetectorPainter(_imageSize, results);
        break;
      case Detector.cloudLabel:
        painter = LabelDetectorPainter(_imageSize, results);
        break;
      case Detector.text:
        painter = TextDetectorPainter(_imageSize, results);
        break;
      case Detector.cloudText:
        painter = TextDetectorPainter(_imageSize, results);
        break;
      default:
        break;
    }

    return CustomPaint(
      painter: painter,
    );
  }

  Widget _buildImage() {
    return Container(
      constraints: const BoxConstraints.expand(),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: Image.file(_imageFile).image,
          fit: BoxFit.fill,
        ),
      ),
      child: _imageSize == null || _scanResults == null
          ? const Center(
              child: Text(
                'Scanning...',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 30.0,
                ),
              ),
            )
          : _buildResults(_imageSize, _scanResults),
    );
  }

  /**
   * function get result for UI
   * return: String/json
   */
  String createDataJsonInfo() {
    var indexName = 0;

    for (int index = 0; index < res.length; index++) {
      var item = res[index];
      //check id card
      if (idCard == null && _checkIdCard(item)) {
        idCard = item;
      }
      //check name
      if (fullName == null && _checkFullName(item)) {
        fullName = item;
        indexName = index;
      }
      //check birthday
      var value = _checkBirthDay(item);
      if (value != "") {
        if (birthday == null) {
          birthday = value;
        } else {
          if (!_compareYears(birthday, value)) {
            // birthday year > value years
            birthday = value;
          }
        }
      }
      //check sex
      if (sex == null && _checkSex(item)) {
        sex = item;
      }
    }

    // remove noisy idCard
    if (idCard != null) {
      var valueIdCard = _removeNoisyIdCard(idCard);
      idCard = valueIdCard;
    }

//    Utilities().printLog("Data phan tich dia chi $resAddress");
//    for (var item in resAddress) {
//      var value = _getAddress(item);
//      if (address == null) {
//        address = value;
//      } else {
//        address += " " + value;
//      }
//    }
//
//    if (address != null) {
//      //var listData = address.split(":").toList();
//      address = _removeAddressNoisy(address);
//    }

    //check full name long long
    if (indexName + 1 < res.length) {
      var nameLongLong = res[indexName + 1];
      if (_checkFullNameLong(nameLongLong) && nameLongLong != idCard && nameLongLong != sex) {
        if (fullName != null) {
          fullName += " " + nameLongLong;
        } else {
          fullName = nameLongLong;
        }
      }
    }

    Map<String, dynamic> toJson() => {
          'fullName': fullName,
          'idCard': idCard,
          'birthday': birthday,
          'nationality': "Viet Nam/Vietamese",
          "sex": sex != null ? sex.replaceAll(' ', '') : sex,
          "address": address
        };

    return jsonEncode(toJson());
  }

  String _removeAddressNoisy(String data) {
    Utilities().printLog("check adress$data");
    if (data != null && data.contains(":")) {
      var listData = data.split(":").toList();
      return listData[listData.length - 1].replaceAll("+", " ");
    } else {
      return data;
    }
  }

  String _getAddress(String data) {
    List<String> tempAddress = List<String>();
    String res = "";
    if (data.contains("\n")) {
      var listData = data.split("\n").toList();
      for (var item in listData) {
        if (item.contains(',') || item.contains("/")) {
          tempAddress.add(item);
        }
      }

      Utilities().printLog("tempAdress $tempAddress");
      for (var item in tempAddress) {
        if (!item.contains(birthday) && !item.contains('nam') && (item.contains(',') || item.contains("/"))) {
          res += item;
        }
      }
      return res;
    } else {
      return data;
    }
  }

  /**
   * kiem tra string co phai la id card hay khong
   * kiem tra character is number
   * */
  bool _checkIdCard(String data) {
    bool isNumber = false;
    if (data.contains("-") || data.contains("/")) {
      return false;
    }
    if (data.length < 2) {
      return false;
    }

    var listData = data.split('');
    int notNumer = 0;

    for (var item in listData) {
      if (!_isNumeric(item)) {
        notNumer += 1;
      } else {
        isNumber = true;
      }
      if (notNumer >= 4) {
        return false;
      }
    }

    return isNumber;
  }

  String _removeNoisyIdCard(String data) {
    String res = "";
    var dataList = data.split('').toList();
    for (var item in dataList) {
      if (_isNumeric(item)) {
        res += item;
      }
    }
    return res;
  }

  /**
   * full name short
   *
   */
  bool _checkFullName(String data) {
    if (!data.contains(" ")) {
      return false;
    }
    Utilities().printLog('data name: $data');
    if (" ".allMatches(data).length < 2) {
      return false;
    }
    var listData = data.split('');
    for (var item in listData) {
      if (item.length > 0 && _isNumeric(item)) {
        return false;
      }
    }

    return true;
  }

  bool _checkFullNameLong(String data) {
    if (data.contains(" ")) {
      return _checkFullName(data);
    }

    var listData = data.split('');
    for (var item in listData) {
      if (item.length > 0 && _isNumeric(item)) {
        return false;
      }
    }

    return true;
  }

  List<String> _splitBirthDay(String data) {
    if (data.contains("-")) {
      return data.split("-");
    }
    if (data.contains("/")) {
      return data.split("/");
    }
    return null;
  }

  /**
   * so sanh birthday hien tai, voi value new
   * true: ko thay doi birthday hien tai, false : thay doi
   */
  bool _compareYears(String data1, String data2) {
    if (data2 == null || data1 == null) {
      return false;
    }

    var listData1 = _splitBirthDay(data1);
    var listData2 = _splitBirthDay(data2);

    if (listData1 == null || listData2 == null) {
      return true;
    }

    var year1 = listData1[listData1.length - 1];
    var year2 = listData2[listData2.length - 1];
    if (year1.length < 4) {
      return false;
    }

    if (year2.length < 4) {
      return true;
    }

    if (double.parse(year1) < double.parse(year2)) {
      return true;
    } else {
      return false;
    }
  }

  bool _isNumeric(String s) {
    Utilities().printLog("_isNumeric $s");
    if (s == null) {
      return false;
    }
    return double.parse(s, (e) => null) != null;
  }

  String _checkBirthDay(String data) {
    if (data.contains("-") || data.contains("/")) {
      List<String> listData;
      if (data.contains("-")) {
        listData = data.split('-').toList();
      }
      if (data.contains("/")) {
        listData = data.split('/').toList();
      }

      if (listData != null && listData.length < 3) {
        return "";
      }

      //check is years
      var year = listData[listData.length - 1];

      if (year.length < 4) {
        return "";
      }

      bool isNumber = true;
      for (var item in listData) {
        if (!_isNumeric(item)) {
          isNumber = false;
        }
      }
      if (isNumber) {
        return data;
      } else {
        return "";
      }
    }

    return "";
  }

  //remove info text noisy text
  void findText(String data) {
    if (data.contains("\n")) {
      var listData = data.split("\n").toList();
      for (var item in listData) {
        findText(item);
      }
      return;
    }

    if (data.contains(":")) {
      var listData = data.split(":").toList();
      for (var item in listData) {
        var value = verifyRowText(item);
        if (value.length > 2) {
          res.add(value);
        }
      }
      return;
    }

    var value = verifyRowText(data);
    if (value.length > 2) {
      res.add(value);
    }

    Utilities().printLog("findText $res");
  }

  /**
   * phan tich tu tren row
   */
  String verifyRowText(String data) {
    bool isDate = false;
    //check "\" "-"
    if (data.contains("/") || data.contains("-")) {
      isDate = true;
    }

    var listRow = data.split(" ").toList();
    String res = "";

    for (var i = 0; i < listRow.length; i++) {
      if (listRow[i] != "-" && compareString(listRow[i].toUpperCase(), listRow[i])) {
        // != "-" doc lap - tu do - hanh fuck
        if (!isDate && i != listRow.length - 1) {
          res += listRow[i] + " ";
        } else {
          res += listRow[i];
        }
      }
      // check sex
      if (_checkSex(listRow[i])) {
        res = listRow[i] + " ";
      }
    }

    //tim header hay khong -> remove header
    if (res.contains(" ")) {
      if (checkHeader(res)) {
        return res;
      } else {
        return "";
      }
    }

    //tim DKHK
    if (res.contains("DKHK")) {
      res = "";
    }
    return res;
  }

  bool checkHeader(String data) {
    var listRow = data.toUpperCase().split(" ").toList();
    String cp = "";
    for (var item in listRow) {
      var listItem = item.split('');
      if (listItem.isNotEmpty) {
        cp += listItem[0];
      }
    }

    if (checkCHXHCNVN(cp)) {
      return false;
    }

    if (checkCMND(cp)) {
      return false;
    }

    if (checkCCCD(cp)) {
      return false;
    }
    if (checkVN(cp)) {
      return false;
    }

    switch (cp) {
      case "CHXHCNVN":
        return false;
      case "HXHCNVN":
        return false;
      case "CMND":
        return false;
      case "GCMND":
        return false;
      case "CC":
        return false;
      case "CD":
        return false;
      case "CCCD":
        return false;
      case "DKHK":
        return false;
      default:
        return true;
    }
  }

  bool checkCHXHCNVN(String data) {
    int count = data.length;
    var listLine = "VIETNAM".split('');
    var listKey = "CHXHCNVN".split('');

    for (int index = 0; index < listKey.length; index++) {
      if (!data.contains(listKey[index])) {
        count -= 1;
      }
    }
    return count / data.length >= 0.5;
  }

  bool checkVN(String data) {
    int count = data.length;

    var listKey = "VIETNAM".split('');

    for (int index = 0; index < listKey.length; index++) {
      if (!data.contains(listKey[index])) {
        count -= 1;
      }
    }
    return count / data.length >= 0.5;
  }

  bool checkCMND(String data) {
    int count = data.length;
    var listLine = data.split('');
    var listKey = "GCMND".split('');

    for (int index = 0; index < listKey.length; index++) {
      if (!data.contains(listKey[index])) {
        count -= 1;
      }
    }
    return count / data.length >= 0.5;
  }

  bool checkCCCD(String data) {
    int count = data.length;
    var listLine = data.split('');
    var listKey = "CCCD".split('');

    for (int index = 0; index < listKey.length; index++) {
      if (!data.contains(listKey[index])) {
        count -= 1;
      }
    }
    return count / data.length >= 0.5;
  }

  bool _checkSex(String data) {
    //remove " "
    String value = data.replaceAll(' ', '');
    switch (value) {
      case "NAM/M":
        return true;
      case "NU/FM":
        return true;
      case "NỮ/FM":
        return true;
      case "Nam":
        return true;
      case "Nu":
        return true;
      case "Nữ":
        return true;
      case "Nü":
        return true;
      default:
        return false;
    }
  }

  /**
   * phan tich character
   */
  bool compareString(String lineUp, String line) {
    int count = line.length;
    var listLineUp = lineUp.split('');
    var listLine = line.split('');

    for (int index = 0; index < listLine.length; index++) {
      if (listLine[index] != listLineUp[index]) {
        count -= 1;
      }
    }
    return count / line.length >= 0.8;
  }

  void dispose() {
    _barcodeDetector.close();
    _faceDetector.close();
    _imageLabeler.close();
    _cloudImageLabeler.close();
    _recognizer.close();
    _cloudRecognizer.close();
  }
}
