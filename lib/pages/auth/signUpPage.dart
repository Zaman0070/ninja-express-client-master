import 'package:flutter/material.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/pages/auth/signInPage.dart';
import 'package:ninja_express_client/provider/auth_provider.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/res/styles.dart';
import 'package:ninja_express_client/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatefulWidget {
  @override
  createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _viewPassword = false;
  TextEditingController namecontoller = TextEditingController();
  TextEditingController emailcontoller = TextEditingController();
  TextEditingController passwordcontoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  late int responsestatus;
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
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
                      'Vamos a crear una cuenta',
                      style: textTitle(color: paynesGrey),
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(height: size_20),
                    customTextField(hint: 'Nombre', controller: namecontoller),
                    SizedBox(height: size_20),
                    customTextField(
                        hint: 'Correo Electrónico', controller: emailcontoller),
                    SizedBox(height: size_20),
                    customTextField(
                        controller: passwordcontoller,
                        hint: 'Contraseña',
                        isPassword: !_viewPassword,
                        iconButton: iconPassword(
                            context: context,
                            viewPassword: _viewPassword,
                            onClick: () => setState(
                                () => _viewPassword = !_viewPassword))),
                    SizedBox(height: size_40),
                    buttonRound(
                        context: context,
                        width: size_250,
                        text: 'Registrarse',
                        color: brightTurquoise,
                        onClick: () async {
                          if (_formKey.currentState!.validate()) {
                            showProgressDialog(context: context);
                            responsestatus = await authProvider.signUp(
                                name: namecontoller.text,
                                email: emailcontoller.text,
                                password: passwordcontoller.text);
                            if (responsestatus != 201) {
                              Navigator.pop(context);
                              showsnakbar(
                                  context: context, statuscode: responsestatus);
                            }
                            if (responsestatus == 201) {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignInPage()));
                            }
                          }
                        }),
                    SizedBox(height: size_30),
                    FloatingActionButton(
                        tooltip: 'Regresar',
                        backgroundColor: windsor,
                        foregroundColor: white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        // Navigator.pushReplacementNamed(context, signInRoute),
                        child: Icon(Icons.arrow_back))
                  ]),
            )));
  }
}
