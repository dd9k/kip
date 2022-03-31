import 'package:check_in_pro_for_visitor/src/model/Document.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ListData.g.dart';

@JsonSerializable()
class ListData {
  @JsonKey(name: 'data')
  List<Document> data;

  @JsonKey(name: 'totalData')
  int totalData;

  ListData._();

  ListData(List<Document> data, int totalData) {
    this.data = data;
    this.totalData = totalData;
  }

  factory ListData.fromJson(Map<String, dynamic> json) => _$ListDataFromJson(json);
}
