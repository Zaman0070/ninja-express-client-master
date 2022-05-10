import 'package:flutter/material.dart';
import 'package:ninja_express_client/models/business.dart';
import 'package:ninja_express_client/models/catagories.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/pages/product/productsPage.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/res/styles.dart';
import 'package:ninja_express_client/util/constants.dart';
import 'package:ninja_express_client/widgets/widgets.dart';
import 'package:transparent_image/transparent_image.dart';

class BusinessPage extends StatefulWidget {
  final int catagoryid;
  final String token;
  final User user;
  final String? catName;

  const BusinessPage({required this.catagoryid, required this.token, required this.user, this.catName});
  @override
  createState() => _BusinessPageState();
}

class _BusinessPageState extends State<BusinessPage> {
  List<Business> businesses = [];
  @override
  void initState() {
    getbusinesses(catagoryid: widget.catagoryid, token: widget.token);
    super.initState();
  }

  getbusinesses({required int catagoryid, required String token}) async {
    businesses = await Beckend().getbusinesses(id: catagoryid, token: token);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: widget.catName!),
        backgroundColor: ghostWhite,
        body: Padding(padding: EdgeInsets.all(padding_16), child: _setList()));
  }

  ListView _setList() {
    return ListView.builder(
        itemCount: businesses.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return InkWell(
            child: SizedBox(
              height: 120,
              child: Card(
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10), topLeft: Radius.circular(10)),
                      child: FadeInImage.memoryNetwork(
                          width: MediaQuery.of(context).size.width * 0.35,
                          height: 120,
                          fit: BoxFit.cover,
                          placeholder: kTransparentImage,
                          image: businesses[index].businessPhoto != null
                              ? businesses[index].businessPhoto!
                              : "https://www.zonergy.com.pk/wp-content/themes/consultix/images/no-image-found-360x250.png"),
                    ),
                    SizedBox(width: size_10),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                businesses[index].businessName!.length > 20
                                   ? businesses[index].businessName!.substring(0, 19) + "..."
                                    : businesses[index].businessName!,
                                style: textMedium(color: paynesGrey)),
                            Text(
                                businesses[index].businessAddress!.length > 26
                                    ? businesses[index].businessAddress!.substring(0, 25) + "..."
                                    : businesses[index].businessAddress!,
                                style: textDefault(color: paynesGrey))
                          ]),
                    )
                  ])),
            ),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProductsPage(
                        user: widget.user,
                        token: widget.token,
                        businessid: businesses[index].businessId!))),
          );
        });
  }
}
