// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ETOrderInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ETOrderInfo _$ETOrderInfoFromJson(Map<String, dynamic> json) {
  return ETOrderInfo(
    (json['id'] as num)?.toDouble(),
    json['orderNo'] as String,
    (json['guestId'] as num)?.toDouble(),
    (json['eventId '] as num)?.toDouble(),
    json['paymentType'] as String,
    (json['totalAmount '] as num)?.toDouble(),
    json['status'] as String,
    (json['quantity '] as num)?.toDouble(),
    json['guestName'] as String,
    json['guestPhone'] as String,
    json['guestEmail'] as String,
    (json['orderDetails'] as List)
        ?.map((e) => e == null
            ? null
            : ETOrderDetailInfo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$ETOrderInfoToJson(ETOrderInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'orderNo': instance.orderNo,
      'guestId': instance.guestId,
      'eventId ': instance.eventId,
      'paymentType': instance.paymentType,
      'totalAmount ': instance.totalAmount,
      'status': instance.status,
      'quantity ': instance.quantity,
      'guestName': instance.guestName,
      'guestPhone': instance.guestPhone,
      'guestEmail': instance.guestEmail,
      'orderDetails': instance.orderDetails,
    };
