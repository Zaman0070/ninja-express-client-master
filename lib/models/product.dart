import 'package:json_annotation/json_annotation.dart';
part 'product.g.dart';

@JsonSerializable()
class Product {
  int? productId;
  String? productDescription;
  String? productName;
  String productPhoto;
  int productPrice;
  int? productBusinessid;
  int? productActive;

  Product(
      {required this.productId,
      required this.productDescription,
      required this.productName,
      required this.productPhoto,
      required this.productPrice,
      required this.productBusinessid,
      required this.productActive});

  factory Product.fromjson(Map<String, dynamic> srcjson) =>
      _$ProductFromJson(srcjson);

  Map<String, dynamic> tojson() => _$ProductToJson(this);
}
