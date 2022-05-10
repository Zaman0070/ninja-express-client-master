import 'package:flutter/material.dart';
import 'package:ninja_express_client/models/product.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/pages/product/productDetail.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/res/styles.dart';
import 'package:ninja_express_client/widgets/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductsPage extends StatefulWidget {
  final int businessid;
  final String token;
  final User user;

  const ProductsPage(
      {required this.businessid, required this.token, required this.user});
  @override
  createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  List<Product> businesses = [];
  @override
  void initState() {
    getbusinessProducts(catagoryid: widget.businessid, token: widget.token);
    super.initState();
  }

  getbusinessProducts({required int catagoryid, required String token}) async {
    businesses =
        await Beckend().getbusinessProducts(id: catagoryid, token: token);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: 'Productos'),
        backgroundColor: ghostWhite,
        body: Padding(padding: EdgeInsets.all(padding_16), child: _setList()));
  }

  ListView _setList() {
    return ListView.builder(
        itemCount: businesses.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return InkWell(
              child: SizedBox(
                height: 120,
                child: Card(
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            topLeft: Radius.circular(10)),
                        child: FadeInImage.memoryNetwork(
                            width: 150,
                            fit: BoxFit.cover,
                            placeholder: kTransparentImage,
                            image: businesses[index].productPhoto == "null"
                                ? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSqCkBNyXYFOAAoR28ypgiRBQjDoj7iBm4FDuHVipMw_aofesj5g9YWlFafch0uqUYfps4&usqp=CAU"
                                : businesses[index].productPhoto),
                      ),
                      SizedBox(width: size_10),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.45,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 16.0),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(businesses[index].productName!,
                                    style: textMedium(color: paynesGrey)),
                                Text(businesses[index].productDescription!,
                                    style: textDefault(color: paynesGrey)),
                                SizedBox(height: 20),
                                Text(businesses[index].productPrice.toString(),
                                    style: textDefault(color: paynesGrey)),
                              ]),
                        ),
                      )
                    ])),
              ),
              onTap: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                                  user: widget.user,
                                  token: widget.token,
                                  product: businesses[index],
                                ))),
                  });
        });
  }
}
