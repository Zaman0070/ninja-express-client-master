import 'package:json_annotation/json_annotation.dart';
import 'package:ninja_express_client/models/cartitemproduct.dart';
// import 'package:ninja_express_client/models/product.dart';
part 'cartitem.g.dart';

@JsonSerializable()
class CartItem {
  int subtotal;
  int cartitemid;
  String quantity;
  int productid;
  CartItemProduct cartitemproduct;

  CartItem(
      {required this.cartitemid,
      required this.quantity,
      required this.productid,
      required this.cartitemproduct,
      required this.subtotal});

  factory CartItem.fromjson(Map<String, dynamic> srcjson) => _$CartItemFromJson(srcjson);

  Map<String, dynamic> tojson() => _$CartItemToJson(this);
}
