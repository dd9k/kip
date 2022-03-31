import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:check_in_pro_for_visitor/src/model/ETOrderDetailInfo.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ETOrderInfo.g.dart';

@JsonSerializable()
class ETOrderInfo {
  @JsonKey(name: 'id')
  double id;

  @JsonKey(name: 'orderNo')
  String orderNo;

  @JsonKey(name: 'guestId')
  double guestId;

  @JsonKey(name: 'eventId ')
  double eventId;

  @JsonKey(name: 'paymentType')
  String paymentType;

  @JsonKey(name: 'totalAmount ')
  double totalAmount;

  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'quantity ')
  double quantity;

  @JsonKey(name: 'guestName')
  String guestName;

  @JsonKey(name: 'guestPhone')
  String guestPhone;

  @JsonKey(name: 'guestEmail')
  String guestEmail;

  @JsonKey(name: 'orderDetails')
  List<ETOrderDetailInfo> orderDetails;

  ETOrderInfo.copyWithEntity(ETOderInfoEntry entry) {
    this.id = entry.id;
    this.orderNo = entry.orderNo;
    this.guestId = entry.guestId;
    this.eventId = entry.eventId;
    this.paymentType = entry.paymentType;
    this.totalAmount = entry.totalAmount;
    this.status = entry.status;
    this.quantity = entry.quantity;
    this.guestName = entry.guestName;
    this.guestPhone = entry.guestPhone;
    this.guestEmail = entry.guestEmail;
  }

  ETOrderInfo(this.id, this.orderNo, this.guestId, this.eventId, this.paymentType, this.totalAmount,
      this.status, this.quantity, this.guestName, this.guestPhone, this.guestEmail, this.orderDetails);

  ETOrderInfo.local(this.id, this.orderNo, this.guestId, this.eventId, this.paymentType, this.totalAmount,
      this.status, this.quantity, this.guestName, this.guestPhone, this.guestEmail, this.orderDetails);

  factory ETOrderInfo.fromJson(Map<String, dynamic> json) => _$ETOrderInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ETOrderInfoToJson(this);
}
