import 'package:json_annotation/json_annotation.dart';

part 'catagories.g.dart';

@JsonSerializable()
class Catagories {
  int? id;
  String? name;
  String? description;
  int? catagoryid;
  String? icon;

  Catagories(
      {required this.id,
      required this.name,
      required this.description,
      required this.catagoryid,
      required this.icon});
  factory Catagories.fromJson(Map<String, dynamic> srcJson) =>
      _$CatagoriesFromJson(srcJson);

  Map<String, dynamic> toJson() => _$CatagoriesToJson(this);
}
