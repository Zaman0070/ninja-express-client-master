import 'package:flutter/material.dart';
import 'package:ninja_express_client/pages/profile/profilePage.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

import '../../models/user.dart';
import '../../net/beckend.dart';

class ChangePasswordPage extends StatefulWidget {
  final token;

  const ChangePasswordPage({Key? key, required this.token}) : super(key: key);

  @override
  createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  TextEditingController passcontroller = TextEditingController();
  TextEditingController confirmpasscontoller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: 'Cambiar contraseña'),
        backgroundColor: ghostWhite,
        body: Padding(
            padding: EdgeInsets.all(padding_16),
            child: Form(
              key: _formKey,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(height: size_20),
                    customTextField(hint: 'Nueva contraseña', controller: passcontroller),
                    SizedBox(height: size_20),
                    customTextField(hint: 'Confirmar contraseña', controller: confirmpasscontoller),
                    SizedBox(height: size_50),
                    buttonRound(
                        context: context,
                        color: deepSkyBlue,
                        text: 'Cambiar Contraseña',
                        onClick: () async {
                          if (_formKey.currentState!.validate()) {
                            if (passcontroller.text != confirmpasscontoller.text) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    elevation: 2,
                                    title: Text("Error Messege"),
                                    content: Text("Passwords do not match"),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            } else if (passcontroller.text.length < 6) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    elevation: 2,
                                    title: Text("Error Messege"),
                                    content: Text("Passwords should be atleat 6 chacters"),
                                    actions: [
                                      TextButton(
                                        child: Text("OK"),
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                      )
                                    ],
                                  );
                                },
                              );
                            } else {
                              int responsestatus = await Beckend().updatepassword(
                                  password: passcontroller.text, token: widget.token);
                              if (responsestatus != 211) {
                                showsnakbar(context: context, statuscode: responsestatus);
                              }
                              if (responsestatus == 211) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      elevation: 2,
                                      title: Text("Response Messege"),
                                      content: Text("Updated Successfully"),
                                      actions: [
                                        TextButton(
                                          child: Text("OK"),
                                          onPressed: () async {
                                            User? user =
                                                await Beckend().getuser(token: widget.token);
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => ProfilePage(
                                                        token: widget.token, user: user)));
                                          },
                                        )
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          }
                        })
                  ]),
            )));
  }
}
