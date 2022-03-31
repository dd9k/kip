import 'package:check_in_pro_for_visitor/src/database/Database.dart';
import 'package:json_annotation/json_annotation.dart';
part 'ETOrderDetailInfo.g.dart';

@JsonSerializable()
class ETOrderDetailInfo {
  @JsonKey(name: 'id')
  double id;

  @JsonKey(name: 'orderId')
  double orderId;

  @JsonKey(name: 'ticketId ')
  double ticketId;

  @JsonKey(name: 'quantity')
  double quantity;

  @JsonKey(name: 'amount')
  double amount;

  @JsonKey(name: 'discountId')
  double discountId;

  @JsonKey(name: 'inviteCode')
  String inviteCode;

  @JsonKey(name: 'status')
  String status;

  ETOrderDetailInfo(
    this.id,
    this.orderId,
    this.ticketId,
    this.quantity,
    this.amount,
    this.discountId,
    this.inviteCode,
    this.status,
  );

  ETOrderDetailInfo.copyWithEntity(ETOderDetailInfoEntry entry) {
    this.id = entry.id;
    this.orderId = entry.orderId;
    this.ticketId = entry.ticketId;
    this.quantity = entry.quantity;
    this.amount = entry.amount;
    this.discountId = entry.discountId;
    this.inviteCode = entry.inviteCode;
    this.status = entry.status;
  }

  ETOrderDetailInfo.local(
    this.id,
    this.orderId,
    this.ticketId,
    this.quantity,
    this.amount,
    this.discountId,
    this.inviteCode,
    this.status,
  );

  factory ETOrderDetailInfo.fromJson(Map<String, dynamic> json) =>
      _$ETOrderDetailInfoFromJson(json);

  Map<String, dynamic> toJson() => _$ETOrderDetailInfoToJson(this);
}
