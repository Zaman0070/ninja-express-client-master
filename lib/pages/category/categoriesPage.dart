import 'package:flutter/material.dart';
import 'package:ninja_express_client/models/catagories.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/net/beckend.dart';
import 'package:ninja_express_client/pages/business/businessPage.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/res/styles.dart';
import 'package:ninja_express_client/widgets/widgets.dart';

class CategoriesPage extends StatefulWidget {
  final String token;
  final User user;

  const CategoriesPage({required this.token, required this.user});

  @override
  createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  List<Catagories> catagories = [];
  @override
  void initState() {
    getcatagories();
    super.initState();
  }

  getcatagories() async {
    catagories = await Beckend().getcatagories(token: widget.token);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: 'Categorias'),
        backgroundColor: ghostWhite,
        body: Padding(
            padding: EdgeInsets.all(padding_16),
            child: GridView.count(crossAxisCount: 2, children: _setList())));
  }

  List<Widget> _setList() {
    return List.generate(catagories.length, (index) {
      return InkWell(
          child: Card(
              child: Padding(
            padding: EdgeInsets.all(padding_16),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customImageSVJ(
                      width: size_80,
                      height: 66,
                      urlImage: catagories[index].icon!,
                      allCorner: corner_5,
                      shape: BoxShape.rectangle),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        catagories[index].name!,
                        style: catagories[index].name!.length > 13
                            ? textSmall(color: paynesGrey)
                            : textBig(color: paynesGrey),

                      )),
                ]),
          )),
          onTap: () => {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BusinessPage(
                          catName: catagories[index].name,
                            user: widget.user,
                            catagoryid: catagories[index].id!,
                            token: widget.token)))
              });
    });
  }
}
