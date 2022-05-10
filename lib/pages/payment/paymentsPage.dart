import 'package:flutter/material.dart';
import 'package:ninja_express_client/pages/payment/paymentCreation.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/util/constants.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class PaymentsPage extends StatefulWidget {
  @override
  createState() => _PaymentsPageState();
}

class _PaymentsPageState extends State<PaymentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: 'Metodos de pago'),
        backgroundColor: ghostWhite,
        body: Padding(
            padding: EdgeInsets.all(padding_16), child: Column(children: [])),
        floatingActionButton: FloatingActionButton(
            tooltip: 'Nuevo metodo de pago',
            backgroundColor: deepSkyBlue,
            foregroundColor: white,
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => PaymentCreationPage())),
            child: Icon(Icons.add)));
  }
}
