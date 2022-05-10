import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ninja_express_client/models/cartitem.dart';
part 'cart.g.dart';

@JsonSerializable()
class Cart {
  int? cartId;
  String? deliveryCost;
  int? total;

  List<CartItem> cartitems;

  Cart({
    required this.total,
    required this.cartId,
    required this.deliveryCost,
    required this.cartitems,
  });

  factory Cart.fromjson(Map<String, dynamic> srcjson) => _$CartFromJson(srcjson);

  Map<String, dynamic> tojson() => _$CartToJson(this);
}
