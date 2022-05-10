import 'package:flutter/material.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/pages/order/orderHistoryPage.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/res/styles.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class OrdersPage extends StatefulWidget {
  final User user;
  final String token;

  const OrdersPage({Key? key, required this.user, required this.token}) : super(key: key);

  @override
  createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(
            title: 'Pedidos',
            iconName: Icons.shopping_cart,
            onClick: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrderHistoryPage(
                          token: widget.token,
                          user: widget.user,
                        )))),
        backgroundColor: ghostWhite,
        body: Padding(padding: EdgeInsets.all(padding_16), child: _setList()));
  }

  ListView _setList() {
    List<String> example = ["a", "b", "a"];
    return ListView.builder(
        itemCount: example.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return _itemList(context, example, index);
        });
  }

  InkWell _itemList(BuildContext context, List<String> orders, int index) {
    return InkWell(
        child: Card(
            child: Padding(
          padding: EdgeInsets.all(padding_16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(
              'Nombre del producto',
              style: textMedium(color: paynesGrey),
            ),
            SizedBox(height: size_10),
            Text('Nombre negocio', style: textDefault(color: paynesGrey)),
            SizedBox(height: size_10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: textDefault(color: paynesGrey),
                  textAlign: TextAlign.start,
                ),
                Text(
                  'Estado de pago',
                  style: textDefault(color: orders[index] == 'a' ? deepSkyBlue : radicalRed),
                  textAlign: TextAlign.end,
                ),
              ],
            ),
          ]),
        )),
        onTap: () => {} // Navigator.pushNamed(context, orderDetailRoute),
        );
  }
}
