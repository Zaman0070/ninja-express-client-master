import 'package:flutter/material.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class AdressDetailPage extends StatefulWidget {

  @override
  createState() => _AdressDetailPageState();
}

class _AdressDetailPageState extends State<AdressDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: 'Detalle de dirección'),
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