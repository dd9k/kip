import 'package:check_in_pro_for_visitor/src/model/VisitorCheckIn.dart';

abstract class IDCardModel {
  IDCardModel.init();

  IDCardModel();

  IDCardModel fromJson(Map<String, dynamic> data);

  Map<String, dynamic> toJson();

  String getID();

  VisitorCheckIn createVisitor(VisitorCheckIn visitorBackup, bool isReplace);
}
