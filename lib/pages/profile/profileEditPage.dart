import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ninja_express_client/api/helper/cameraAndGallery.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/pages/profile/profilePage.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/res/styles.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class ProfileEditPage extends StatefulWidget {
  final User user;
  final String token;
  const ProfileEditPage({required this.user, required this.token});
  @override
  createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  TextEditingController namecontoller = TextEditingController();
  TextEditingController emailcontoller = TextEditingController();
  TextEditingController phonecontoller = TextEditingController();

  @override
  void initState() {
    super.initState();
    namecontoller = TextEditingController(text: widget.user.name);
    phonecontoller = TextEditingController(text: widget.user.phone);
  }

  // File file = File("");
  File? _file;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: customAppBar(title: 'Editar perfil'),
        backgroundColor: ghostWhite,
        body: Padding(
            padding: EdgeInsets.all(padding_16),
            child: Column(children: [
              Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  customImagesetter(
                      file: _file,
                      urlImage: widget.user.photo,
                      height: size_200,
                      allCorner: corner_5,
                      shape: BoxShape.rectangle),
                  Padding(
                    padding: EdgeInsets.all(padding_10),
                    child: FloatingActionButton(
                        tooltip: 'Tomar o subir foto',
                        backgroundColor: turquoiseBlue,
                        foregroundColor: white,
                        onPressed: () {
                          showAlertDialogAction(
                              context: context,
                              title: '¿Dónde desea tomar la imagen?',
                              items: <Widget>[
                                GestureDetector(
                                  child: Text("Galeria",
                                      style: textBig(color: black), textAlign: TextAlign.center),
                                  onTap: () async {
                                    // Navigator.pop(context);
                                    try {
                                      final pickedFile = await openGallery(context);
                                      setState(() => _file = File(pickedFile.path));
                                    } catch (error) {
                                      // addLog(message: error);
                                    }
                                  },
                                ),
                                SizedBox(height: size_10),
                                GestureDetector(
                                  child: Text("Camara",
                                      style: textBig(color: black), textAlign: TextAlign.center),
                                  onTap: () async {
                                    Navigator.pop(context);
                                    try {
                                      final pickedFile = await openCamera(context);
                                      setState(() => _file = File(pickedFile.path));
                                    } catch (error) {
                                      // addLog(message: error);
                                    }
                                  },
                                ),
                              ]);
                        },
                        child: Icon(Icons.camera_alt_rounded)),
                  )
                ],
              ),
              SizedBox(height: size_30),
              customTextField(hint: 'Nombre', controller: namecontoller),
              SizedBox(height: size_10),
              customTextField(hint: 'Teléfono', controller: phonecontoller),
              SizedBox(height: size_10),
              customTextField(
                  hint: 'Correo electrónico', eneable: false, controller: emailcontoller),
              SizedBox(height: size_50),
              buttonRound(
                  context: context,
                  text: 'Guardar',
                  color: deepSkyBlue,
                  onClick: () async {
                    if (namecontoller.text.isEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            elevation: 2,
                            title: Text("Error Messege"),
                            content: Text("Name Cannot be empty"),
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
                    } else if (namecontoller.text == widget.user.name &&
                        phonecontoller.text == widget.user.phone &&
                        _file == null) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            elevation: 2,
                            title: Text("Error Messege"),
                            content: Text("Enter Something You want to Update"),
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
                      showProgressDialog(context: context);
                      int responsestatus = await updateprofile();
                      if (responsestatus != 211) {
                        Navigator.pop(context);
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
                                    User? user = await Beckend().getuser(token: widget.token);
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProfilePage(token: widget.token, user: user)));
                                  },
                                )
                              ],
                            );
                          },
                        );
                      }
                    }
                  })
            ])));
  }

  Future<int> updateprofile() async {
    return Beckend().updateprofile(
        photo: _file,
        name: namecontoller.text.isNotEmpty ? namecontoller.text : widget.user.name!,
        phone: phonecontoller.text.isNotEmpty ? phonecontoller.text : widget.user.phone!,
        token: widget.token);
  }
}
