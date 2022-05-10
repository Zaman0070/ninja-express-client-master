import 'package:flutter/material.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/pages/adress/adressPage.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class AdressCreationPage extends StatefulWidget {
  final String token;
  final User user;

  const AdressCreationPage({Key? key, required this.token, required this.user})
      : super(key: key);
  @override
  createState() => _AdressCreationPageState();
}

class _AdressCreationPageState extends State<AdressCreationPage> {
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController descroptionController = TextEditingController();
  @override
  void dispose() {
    addressController.dispose();
    countryController.dispose();
    stateController.dispose();
    cityController.dispose();
    descroptionController.dispose();
    super.dispose();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: 'Nueva dirección'),
        backgroundColor: ghostWhite,
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(padding_16),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  customTextField(
                      hint: 'Direccion', controller: addressController),
                  SizedBox(height: size_20),
                  customTextField(hint: 'país', controller: countryController),
                  SizedBox(height: size_20),
                  customTextField(hint: 'state', controller: stateController),
                  SizedBox(height: size_20),
                  customTextField(hint: 'Ciudad', controller: cityController),
                  SizedBox(height: size_20),
                  customTextField(
                      hint: 'Observaciones',
                      maxLines: 5,
                      controller: descroptionController),
                  SizedBox(height: size_50),
                  buttonRound(
                      context: context,
                      text: 'Añadir',
                      color: deepSkyBlue,
                      onClick: () async {
                        if (_formKey.currentState!.validate()) {
                          showProgressDialog(context: context);
                          int resposecode = await Beckend().createClientAddress(
                              token: widget.token,
                              clientid: widget.user.id!,
                              address: addressController.text,
                              country: countryController.text,
                              state: stateController.text,
                              city: cityController.text,
                              description: descroptionController.text);
                          if (resposecode == 200) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AdressPage(
                                        token: widget.token,
                                        user: widget.user)));
                          } else {
                            showsnakbar(
                                context: context, statuscode: resposecode);
                          }
                        }
                      })
                ]),
              )),
        ));
  }
}
