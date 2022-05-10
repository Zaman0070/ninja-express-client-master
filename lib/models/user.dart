import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import 'address.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  int? id;
  String? name;
  String? phone;
  String? photo;
  int? userid;
  int cartId;

  Address? currentaddress;
  User(
      {required this.id,
      required this.name,
      required this.phone,
      required this.photo,
      required this.userid,
      required this.cartId,
      this.currentaddress});

  factory User.fromJson(Map<String, dynamic> srcJson) => _$UserFromJson(srcJson);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}
