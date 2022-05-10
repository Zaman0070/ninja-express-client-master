import 'package:flutter/material.dart';
import 'package:ninja_express_client/models/product.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/res/styles.dart';
import 'package:ninja_express_client/widgets/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetailPage extends StatefulWidget {
  final Product product;
  final User user;

  final String token;

  const ProductDetailPage(
      {Key? key, required this.product, required this.user, required this.token})
      : super(key: key);
  @override
  createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: 'Detalle del producto'),
        backgroundColor: ghostWhite,
        body: Padding(
            padding: EdgeInsets.all(padding_16),
            child: Column(children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.rectangle, borderRadius: BorderRadius.circular(20)),
                child: widget.product.productPhoto != ""
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage.memoryNetwork(
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width * 0.93,
                          image: widget.product.productPhoto,
                          placeholder: kTransparentImage,
                          fit: BoxFit.fill,
                        ),
                      )
                    : Image.asset("lib/images/ic_logo.png", fit: BoxFit.fill),
              ),
              SizedBox(height: size_10),
              customTextField(
                  text: "Product Name : " + widget.product.productName!,
                  hint: "Product Name : " + widget.product.productName!,
                  eneable: false),
              SizedBox(height: size_10),
              customTextField(
                  maxLines: 4,
                  text: "Product Description :\n\n    " + widget.product.productDescription!,
                  hint: "Product Name : \n" + widget.product.productDescription!,
                  eneable: false),
              SizedBox(height: size_10),
              customTextField(
                  text: "Product Price : " + widget.product.productPrice.toString(),
                  hint: "Product Price : " + widget.product.productPrice.toString(),
                  eneable: false),
              SizedBox(height: size_20),
              StatefulBuilder(builder: (context, StateSetter setter) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                          child: Text(
                        quantity.toString(),
                        style: textBig(color: Colors.white),
                      )),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.1,
                    ),
                    buttonRoundWithIcon(
                        width: MediaQuery.of(context).size.width * 0.2,
                        context: context,
                        icon: Icons.add,
                        color: Colors.blue,
                        onClick: () {
                          quantity++;
                          setter(() {});
                        }),
                    buttonRoundWithIcon(
                        width: MediaQuery.of(context).size.width * 0.2,
                        context: context,
                        icon: Icons.remove,
                        color: Colors.blue,
                        onClick: () {
                          if (quantity > 1) quantity--;
                          setter(() {});
                        })
                  ],
                );
              }),
              SizedBox(height: size_50),
              buttonRound(
                  context: context,
                  text: "Añadir al carrito",
                  color: Colors.blue,
                  onClick: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          elevation: 2,
                          title: Text("Add to Cart"),
                          content: Text("Do you want to add item to cart"),
                          actions: [
                            TextButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            TextButton(
                                child: Text("OK"),
                                onPressed: () async {
                                  showProgressDialog(context: context);
                                  int responsestatus = await Beckend().addItemToCart(
                                      cartid: widget.user.cartId,
                                      quantity: quantity,
                                      productId: widget.product.productId!,
                                      token: widget.token);
                                  if (responsestatus != 201)
                                    showsnakbar(context: context, statuscode: responsestatus);

                                  if (responsestatus == 201) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                    // Navigator.pushReplacement(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             ()));
                                  }
                                })
                          ],
                        );
                      },
                    );
                  })
            ])));
  }
}
