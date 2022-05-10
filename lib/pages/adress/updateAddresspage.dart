import 'package:flutter/material.dart';
import 'package:ninja_express_client/models/address.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/pages/adress/adressPage.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class UpdateAddress extends StatefulWidget {
  final String token;
  final Address address;
  final User user;

  const UpdateAddress({Key? key, required this.token, required this.address, required this.user})
      : super(key: key);
  @override
  createState() => _UpdateAddressState();
}

class _UpdateAddressState extends State<UpdateAddress> {
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController descroptionController = TextEditingController();

  @override
  void initState() {
    addressController = TextEditingController(text: widget.address.address);
    countryController = TextEditingController(text: widget.address.country);
    stateController = TextEditingController(text: widget.address.state);
    cityController = TextEditingController(text: widget.address.city);
    descroptionController = TextEditingController(text: widget.address.description);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: 'Editar dirección'),
        backgroundColor: ghostWhite,
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.all(padding_16),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  customTextField(hint: widget.address.address, controller: addressController),
                  SizedBox(height: size_20),
                  customTextField(hint: widget.address.country, controller: countryController),
                  SizedBox(height: size_20),
                  customTextField(hint: widget.address.state, controller: stateController),
                  SizedBox(height: size_20),
                  customTextField(hint: widget.address.city, controller: cityController),
                  SizedBox(height: size_20),
                  customTextField(
                      hint: widget.address.description,
                      maxLines: 5,
                      controller: descroptionController),
                  SizedBox(height: size_50),
                  buttonRound(
                      context: context,
                      text: 'Añadir',
                      color: deepSkyBlue,
                      onClick: () async {
                        if (_formKey.currentState!.validate()) {
                          if (addressController.text == widget.address.address &&
                              countryController.text == widget.address.country &&
                              stateController.text == widget.address.state &&
                              cityController.text == widget.address.city &&
                              descroptionController.text == widget.address.description) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  elevation: 2,
                                  title: Text("Error Messege"),
                                  content: Text("Enter something you want to Update"),
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
                            int resposecode = await Beckend().updateClientAddress(
                                token: widget.token,
                                addressid: widget.address.id,
                                address: addressController.text,
                                country: countryController.text,
                                state: stateController.text,
                                city: cityController.text,
                                description: descroptionController.text);
                            if (resposecode == 200) {
                              Navigator.of(context).pushReplacement(MaterialPageRoute(
                                  builder: (context) =>
                                      AdressPage(token: widget.token, user: widget.user)));
                            } else {
                              showsnakbar(context: context, statuscode: resposecode);
                            }
                          }
                        }
                      })
                ]),
              )),
        ));
  }
}
