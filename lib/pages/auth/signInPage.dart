import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/pages/auth/resetPasswordPage.dart';
import 'package:ninja_express_client/pages/auth/signUpPage.dart';
import 'package:ninja_express_client/pages/home/homePage.dart';
import 'package:ninja_express_client/provider/auth_provider.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/res/styles.dart';
import 'package:ninja_express_client/util/constants.dart';
import 'package:ninja_express_client/widgets/widgets.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatefulWidget {
  @override
  createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _viewPassword = false;
  late List responsestatus;
  TextEditingController emailcontoller = TextEditingController();
  TextEditingController passwordcontoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

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
                Image.asset('lib/images/ic_logo.png'),
                SizedBox(height: size_30),
                customTextField(hint: 'Correo Electrónico', controller: emailcontoller),
                SizedBox(height: size_20),
                customTextField(
                    controller: passwordcontoller,
                    hint: 'Contraseña',
                    isPassword: !_viewPassword,
                    iconButton: iconPassword(
                        context: context,
                        viewPassword: _viewPassword,
                        onClick: () => setState(() => _viewPassword = !_viewPassword))),
                SizedBox(height: size_30),
                SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                        child: Text('Olvidaste tu contraseña?',
                            style: textDefault(
                                color: paynesGrey, textDecoration: TextDecoration.underline),
                            textAlign: TextAlign.end),
                        onTap: () => Navigator.push(context,
                            MaterialPageRoute(builder: (context) => ResetPasswordPage())))),
                SizedBox(height: size_40),
                buttonRound(
                    context: context,
                    width: size_250,
                    text: 'Iniciar Sesión',
                    color: brightTurquoise,
                    onClick: () async {
                      if (_formKey.currentState!.validate()) {
                        showProgressDialog(context: context);
                        responsestatus = await authProvider.login(
                            email: emailcontoller.text, password: passwordcontoller.text);
                        if (responsestatus.first != 200) {
                          Navigator.pop(context);
                          showsnakbar(context: context, statuscode: responsestatus.first);
                        }
                        if (responsestatus.first == 200) {
                          Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      HomePage(token: responsestatus.last['token'])));
                        }
                      }
                    }),
                SizedBox(height: size_20),
                buttonRound(
                    context: context,
                    width: size_250,
                    text: 'Registrarse',
                    color: windsor,
                    onClick: () => Navigator.push(
                        context, MaterialPageRoute(builder: (context) => SignUpPage())))
              ]),
        ),
      ),
    );
  }
}
