import 'package:json_annotation/json_annotation.dart';
part 'cartitemproduct.g.dart';

@JsonSerializable()
class CartItemProduct {
  int? productId;
  String? productDescription;
  String? productName;
  String productPhoto;

  int? productBusinessid;
  int? productActive;

  CartItemProduct(
      {required this.productId,
      required this.productDescription,
      required this.productName,
      required this.productPhoto,
      required this.productBusinessid,
      required this.productActive});

  factory CartItemProduct.fromjson(Map<String, dynamic> srcjson) =>
      _$CartItemProductFromJson(srcjson);

  Map<String, dynamic> tojson() => _$CartItemProductToJson(this);
}
