import 'package:json_annotation/json_annotation.dart';
part 'address.g.dart';

@JsonSerializable()
class Address {
  int id;
  String address;
  String city;
  String state;
  String country;
  String description;
  int clientid;
  Address(
      {required this.id,
      required this.address,
      required this.city,
      required this.state,
      required this.country,
      required this.description,
      required this.clientid});

  factory Address.fromjson(Map<String, dynamic> srcjson) =>
      _$AddressFromJson(srcjson);

  Map<String, dynamic> tojson() => _$AddressToJson(this);
}
