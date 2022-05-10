import 'package:flutter/material.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/pages/auth/signInPage.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/res/styles.dart';
import 'package:ninja_express_client/util/constants.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController emailcontroller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: ghostWhite,
        body: Padding(
            padding: EdgeInsets.all(padding_30),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                        'Ninja Express le enviará un mensaje con una contraseña generada para que pueda ingresar y cambiar su contraseña',
                        style: textBig(color: paynesGrey),
                        textAlign: TextAlign.justify),
                    SizedBox(height: size_40),
                    customTextField(
                        hint: 'Correo Electrónico',
                        controller: emailcontroller),
                    SizedBox(height: size_40),
                    buttonRound(
                        context: context,
                        width: size_250,
                        text: 'Eviar',
                        color: brightTurquoise,
                        onClick: () async {
                          int responsestatus;
                          if (_formKey.currentState!.validate()) {
                            responsestatus = await _sendEmail();
                            if (responsestatus == 500) {
                              showsnakbar("internal server Error");
                            }
                            if (responsestatus == 404) {
                              showsnakbar("Failed Mail  delivery");
                            }
                            if (responsestatus == 200) {
                              emailcontroller.clear();
                              showsnakbar("Check Your Email To reset Password");
                            }
                          }
                        }),
                    SizedBox(height: size_30),
                    FloatingActionButton(
                        tooltip: 'Regresar',
                        backgroundColor: windsor,
                        foregroundColor: white,
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignInPage())),
                        child: Icon(Icons.arrow_back))
                  ]),
            )));
  }

  Future<int> _sendEmail() async {
    return Beckend().resetpass(email: emailcontroller.text.trim());
  }

  showsnakbar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
