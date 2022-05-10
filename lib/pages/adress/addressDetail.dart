import 'package:flutter/material.dart';
import 'package:ninja_express_client/models/address.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/pages/adress/adressPage.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class AddressDetail extends StatefulWidget {
  final String token;
  final Address address;
  final User user;

  const AddressDetail({Key? key, required this.token, required this.address, required this.user})
      : super(key: key);
  @override
  createState() => _AddressDetailState();
}

class _AddressDetailState extends State<AddressDetail> {
  TextEditingController addressController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController descroptionController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
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
        key: _scaffoldKey,
        appBar: customAppBar(title: 'Editar dirección'),
        backgroundColor: ghostWhite,
        body: Padding(
            padding: EdgeInsets.all(padding_16),
            child: Form(
              key: _formKey,
              child: Column(children: [
                customTextField(
                    applyhintstyle: true,
                    eneable: false,
                    hint: widget.address.address,
                    controller: addressController),
                SizedBox(height: size_20),
                customTextField(
                    applyhintstyle: true,
                    eneable: false,
                    hint: widget.address.country,
                    controller: countryController),
                SizedBox(height: size_20),
                customTextField(
                    applyhintstyle: true,
                    eneable: false,
                    hint: widget.address.state,
                    controller: stateController),
                SizedBox(height: size_20),
                customTextField(
                    applyhintstyle: true,
                    eneable: false,
                    hint: widget.address.city,
                    controller: cityController),
                SizedBox(height: size_20),
                customTextField(
                    applyhintstyle: true,
                    eneable: false,
                    hint: widget.address.description,
                    maxLines: 5,
                    controller: descroptionController),
                SizedBox(height: size_50),
                buttonRound(
                    context: context,
                    text: 'Guardar',
                    color: deepSkyBlue,
                    onClick: () async {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  AdressPage(token: widget.token, user: widget.user)));
                    }),
                SizedBox(height: size_20),
                buttonRound(
                    context: context,
                    text: 'establecer como dirección actual',
                    color: deepSkyBlue,
                    onClick: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            elevation: 2,
                            title: Text("borrar direccion"),
                            content: Text("¿establecer la dirección actual??"),
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
                                    showProgressDialog(context: context);
                                    int responsestatus = await Beckend().changeCurrentAddress(
                                        token: widget.token,
                                        currentAddressId: widget.address.id,
                                        userid: widget.user.id!);
                                    if (responsestatus != 200)
                                      showsnakbar(context: context, statuscode: responsestatus);

                                    if (responsestatus == 200) {
                                      showInSnackBar("Address Deleted Successfully");
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AdressPage(
                                                  token: widget.token, user: widget.user)));
                                    }
                                  })
                            ],
                          );
                        },
                      );
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => AdressPage(
                      //             token: widget.token, user: widget.user)));
                    }),
                SizedBox(height: size_20),
                buttonRound(
                    context: context,
                    text: 'Eliminar',
                    color: Colors.red,
                    onClick: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            elevation: 2,
                            title: Text("borrar direccion"),
                            content: Text("¿Estás seguro de que quieres eliminar esta dirección?"),
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
                                    showProgressDialog(context: context);
                                    int responsestatus = await Beckend().deleteAddress(
                                        token: widget.token, addressid: widget.address.id);
                                    if (responsestatus != 200)
                                      showsnakbar(context: context, statuscode: responsestatus);

                                    if (responsestatus == 200) {
                                      showInSnackBar("Address Deleted Successfully");
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => AdressPage(
                                                  token: widget.token, user: widget.user)));
                                    }
                                  })
                            ],
                          );
                        },
                      );
                    })
              ]),
            )));
  }

  void showInSnackBar(String value) {
    // ignore: deprecated_member_use
    _scaffoldKey.currentState!.showSnackBar(new SnackBar(content: new Text(value)));
  }
}
