import 'package:json_annotation/json_annotation.dart';
part 'business.g.dart';

@JsonSerializable()
class Business {
  int? businessId;
  int? businessAvalible;
  String? businessName;
  String? businessEmail;
  String? businessPhone;
  String? businessPhoto;
  int? businessCatagoryid;
  int? businessAddressid;
  int? businessUserid;
  String? businessAddress;
  Business(
      {required this.businessId,
      required this.businessAvalible,
      required this.businessName,
      required this.businessEmail,
      required this.businessPhone,
      required this.businessPhoto,
      required this.businessCatagoryid,
      required this.businessAddressid,
      required this.businessUserid,
      required this.businessAddress});

  factory Business.fromjson(Map<String, dynamic> srcjson) => _$BusinessFromJson(srcjson);

  Map<String, dynamic> tojson() => _$BusinessToJson(this);
}
