import 'package:flutter/material.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/pages/adress/adressPage.dart';
import 'package:ninja_express_client/pages/auth/signInPage.dart';
import 'package:ninja_express_client/pages/chat/chatPage.dart';
import 'package:ninja_express_client/pages/payment/paymentsPage.dart';
import 'package:ninja_express_client/pages/profile/changePasswordPage.dart';
import 'package:ninja_express_client/pages/profile/profileEditPage.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class ProfilePage extends StatefulWidget {
  final String token;
  final User? user;

  const ProfilePage({required this.token, required this.user});
  @override
  createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: 'Perfil'),
        backgroundColor: ghostWhite,
        body: Padding(
            padding: EdgeInsets.all(padding_16),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  cardwithImage(
                      url: widget.user!.photo,
                      title: widget.user!.name!,
                      description: widget.user!.currentaddress!.address),
                  SizedBox(height: size_10),
                  cardButton(
                      context: context,
                      text: 'Editar Perfil',
                      onClick: () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ProfileEditPage(token: widget.token, user: widget.user!)),
                            )
                          }),
                  SizedBox(height: size_10),
                  cardButton(
                      context: context,
                      text: 'Cambiar Contraseña',
                      onClick: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChangePasswordPage(
                                    token: widget.token,
                                  )))),
                  SizedBox(height: size_10),
                  cardButton(
                      context: context,
                      text: 'Metodos de pago',
                      onClick: () => Navigator.push(
                          context, MaterialPageRoute(builder: (context) => PaymentsPage()))),
                  // PaymentsPage
                  SizedBox(height: size_10),
                  cardButton(
                      context: context,
                      text: 'Direcciones',
                      onClick: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AdressPage(token: widget.token, user: widget.user!)))),
                  SizedBox(height: size_10),
                  cardButton(
                      context: context,
                      text: 'Soporte',
                      onClick: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ChatPage(
                                    chatType: 3,
                                  )))),
                  SizedBox(height: size_10),
                  cardButton(
                      context: context,
                      text: 'Cerrar Sesión',
                      onClick: () async {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              elevation: 2,
                              title: Text("Logging Out"),
                              content: Text("Are you sure You want to log Out?"),
                              actions: [
                                TextButton(
                                  child: Text("Cancel"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                    child: Text("OK"),
                                    onPressed: () async {
                                      int responsestatus = await logout(token: widget.token);
                                      if (responsestatus != 200)
                                        showsnakbar(context: context, statuscode: responsestatus);

                                      if (responsestatus == 200) {
                                        Navigator.pushReplacement(context,
                                            MaterialPageRoute(builder: (context) => SignInPage()));
                                      }
                                    })
                              ],
                            );
                          },
                        );
                      })
                ])));
  }

  Future<int> logout({required String token}) {
    return Beckend().logout(token: token);
  }
}
