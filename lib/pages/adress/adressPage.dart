import 'package:flutter/material.dart';
import 'package:ninja_express_client/models/address.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/pages/adress/adressCreationPage.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class AdressPage extends StatefulWidget {
  final String token;
  final User user;

  const AdressPage({Key? key, required this.token, required this.user})
      : super(key: key);
  @override
  createState() => _AdressPageState();
}

class _AdressPageState extends State<AdressPage> {
  List<Address> addresses = [];
  getClientaddresses() async {
    addresses.addAll(await Beckend()
        .getclientAddresses(token: widget.token, id: widget.user.id!));
  }

  @override
  Widget build(BuildContext context) {
    addresses = [];
    return Scaffold(
        appBar: customAppBar(title: 'Dirección de entrega'),
        backgroundColor: ghostWhite,
        body: SingleChildScrollView(
          child: FutureBuilder(
            future: getClientaddresses(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
              }
              return Padding(
                  padding: EdgeInsets.all(padding_16),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width * 0.1),
                          child: Text(
                            "Elegir Opcion de dirección",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: addresses
                                  .map((e) => Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 16.0),
                                        child: addressCard(
                                            address: e,
                                            context: context,
                                            token: widget.token,
                                            user: widget.user),
                                      ))
                                  .toList(),
                            )
                            //  addressCard(
                            //     address: "Av. Chapultepec 1422",
                            //     country: "Mexico",
                            //     state: "Nuevon Leon",
                            //     city: "Buenos Aires",
                            //     description: "frente a la casa azul",
                            //     size: MediaQuery.of(context).size),
                            )
                      ]));
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
            tooltip: 'Nueva dirección',
            backgroundColor: deepSkyBlue,
            foregroundColor: white,
            onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AdressCreationPage(
                        token: widget.token, user: widget.user))),
            child: Icon(Icons.add)));
  }
}
