import 'package:flutter/material.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class ShoppingCartPage extends StatefulWidget {

  @override
  createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Carrito'),
      backgroundColor: ghostWhite,
      body: Padding(
        padding: EdgeInsets.all(padding_16),
        child: Column(
          children: [

          ]
        )
      )
    );
  }
}