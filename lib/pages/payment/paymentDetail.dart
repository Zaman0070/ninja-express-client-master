import 'package:flutter/material.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class PaymentDetailPage extends StatefulWidget {
  @override
  createState() => _PaymentDetailPageState();
}

class _PaymentDetailPageState extends State<PaymentDetailPage> {
  TextEditingController t1 = TextEditingController();
  TextEditingController t2 = TextEditingController();
  TextEditingController t3 = TextEditingController();
  TextEditingController t4 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: 'Detalle metodo de pago'),
        backgroundColor: ghostWhite,
        body: Padding(
            padding: EdgeInsets.all(padding_16),
            child: Column(children: [
              customTextField(hint: 'Numero de tarjeta', controller: t1),
              SizedBox(height: size_10),
              customTextField(hint: 'Fecha de expiración', controller: t2),
              SizedBox(height: size_10),
              customTextField(hint: 'Cvv', controller: t3),
              SizedBox(height: size_10),
              customTextField(hint: 'Nombre del titular', controller: t4),
              SizedBox(height: size_50),
              buttonRound(
                  context: context,
                  text: 'Añadir',
                  color: deepSkyBlue,
                  onClick: () {}),
              SizedBox(height: size_10),
              buttonRound(
                  context: context,
                  text: 'Eliminar',
                  color: radicalRed,
                  onClick: () {})
            ])));
  }
}
