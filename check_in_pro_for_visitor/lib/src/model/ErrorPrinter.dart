import 'package:json_annotation/json_annotation.dart';

part 'ErrorPrinter.g.dart';

@JsonSerializable()
class ErrorPrinter {
  @JsonKey(name: 'status')
  String status;

  @JsonKey(name: 'ERROR_CODE')
  String ERROR_CODE;

  @JsonKey(name: 'message')
  String message;

  ErrorPrinter._();

  ErrorPrinter(this.status, this.ERROR_CODE, this.message);

  factory ErrorPrinter.fromJson(Map<String, dynamic> json) => _$ErrorPrinterFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorPrinterToJson(this);
}
