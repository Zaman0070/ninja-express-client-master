import 'package:flutter/material.dart';
import 'package:http/retry.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/res/styles.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

import '../../models/cart.dart';
import '../../net/beckend.dart';

class OrderHistoryPage extends StatefulWidget {
  final User user;
  final String token;

  const OrderHistoryPage({Key? key, required this.user, required this.token}) : super(key: key);
  @override
  createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  Cart? cart;
  @override
  void initState() {
    // getcartproducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Carrito'),
      backgroundColor: ghostWhite,
      body: FutureBuilder(
          future: Beckend().getcartProducts(cartid: widget.user.cartId, token: widget.token),
          builder: (context, AsyncSnapshot<Cart?> snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(child: CircularProgressIndicator());
            }
            print(snapshot.data!.cartitems.first.productid);
            return Padding(
                padding: EdgeInsets.all(padding_16),
                child: Column(
                  children: [
                    Container(
                      height: 160,
                      width: 500,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text(
                              'producto',
                              style: textMedium(color: paynesGrey),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            for (int i = 0; i < snapshot.data!.cartitems.length; i++)
                              Padding(
                                padding: const EdgeInsets.only(top: 2),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(snapshot.data!.cartitems[i].quantity),
                                        Text(' x '),
                                        Text(snapshot
                                            .data!.cartitems[i].cartitemproduct.productName!),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: IconButton(
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          ),
                                          onPressed: () async {
                                            int response = await Beckend().deletecartitem(
                                                cartitemproductid:
                                                    snapshot.data!.cartitems[i].cartitemid,
                                                cartitemproductquantity:
                                                    snapshot.data!.cartitems[i].quantity,
                                                token: widget.token);
                                          }),
                                    ),
                                  ],
                                ),
                              ),
                          ]),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                        color: Colors.transparent,
                        width: 500,
                        height: 60,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            onPressed: () {},
                            color: Colors.red,
                            child: Text('Añadir mas productos', style: textBig(color: white)))),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 65,
                      width: 500,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 18, 8, 8),
                          child: Text(
                            snapshot.data!.total.toString(),
                            // style: textMedium(color: paynesGrey),
                            style: TextStyle(fontSize: 18, color: paynesGrey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 65,
                      width: 500,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 18, 8, 8),
                          child: Text(
                            // snapshot.data!.total.toString(),
                            'Payment in cash',
                            // style: textMedium(color: paynesGrey),
                            style: TextStyle(fontSize: 18, color: paynesGrey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 65,
                      width: 500,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 18, 8, 8),
                          child: Text(
                            // snapshot.data!.total.toString(),
                            widget.user.currentaddress!.address,
                            // style: textMedium(color: paynesGrey),
                            style: TextStyle(fontSize: 18, color: paynesGrey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      height: 65,
                      width: 500,
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(8.0, 18, 8, 8),
                          child: Text(
                            // snapshot.data!.total.toString(),
                            "Delivery Cost : " + snapshot.data!.deliveryCost.toString(),
                            // style: textMedium(color: paynesGrey),
                            style: TextStyle(fontSize: 18, color: paynesGrey),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                        color: Colors.transparent,
                        width: 500,
                        height: 60,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                            onPressed: () {},
                            color: Colors.blue,
                            child: Text('Realizar pedido', style: textBig(color: white))))
                  ],
                )

                // buttonRound(
                //           context: context,
                //           width: size_250,
                //           text: 'Añadir mas productos',
                //           color: brightTurquoise,
                //           onClick: () async {}),
                // ListView.builder(
                //     itemCount: snapshot.data!.cartitems.length,
                //     scrollDirection: Axis.vertical,
                //     itemBuilder: (context, index) {
                //       return Card(
                //           child: Padding(
                //         padding: EdgeInsets.all(padding_16),
                //         child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                //           Text(
                //             'producto',
                //             style: textMedium(color: paynesGrey),
                //           ),
                //           SizedBox(height: size_10),
                //           Text('Nombre negocio', style: textDefault(color: paynesGrey)),
                //           SizedBox(height: size_10),
                //           Row(
                //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //             children: [
                //               Text(
                //                 'Cantidad',
                //                 style: textDefault(color: paynesGrey),
                //                 textAlign: TextAlign.start,
                //               ),
                //               Text(
                //                 'Total',
                //                 style: textDefault(color: paynesGrey),
                //                 textAlign: TextAlign.end,
                //               ),
                //             ],
                //           ),
                //         ]),
                //       ));
                //     })
                );
          }),
    );
  }
}
