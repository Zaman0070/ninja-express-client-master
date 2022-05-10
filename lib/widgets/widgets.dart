// ignore_for_file: unnecessary_null_comparison, deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ninja_express_client/models/address.dart';
import 'package:ninja_express_client/models/user.dart';
import 'package:ninja_express_client/pages/adress/addressDetail.dart';
import 'package:ninja_express_client/pages/adress/updateAddresspage.dart';
import 'package:ninja_express_client/res/colors.dart';
import 'package:ninja_express_client/res/dimens.dart';
import 'package:ninja_express_client/res/styles.dart';
import 'package:transparent_image/transparent_image.dart';

AppBar customAppBar({required String title, IconData? iconName, void Function()? onClick}) {
  return AppBar(
    centerTitle: true,
    title: Text(title, style: textAppBar(color: white)),
    actions: [
      IconButton(
          icon: Icon(
            iconName,
            color: turquoiseBlue,
          ),
          onPressed: onClick)
    ],
  );
}

Card customTextField(
    {required String hint,
    TextInputType? textInputType,
    bool applyhintstyle = false,
    TextInputAction? textInputAction,
    int maxLines = 1,
    int? minLines,
    String? text,
    bool eneable = true,
    bool isPassword = false,
    TextEditingController? controller,
    String? errorText,
    IconButton? iconButton,
    double? corners}) {
  return Card(
    margin: EdgeInsets.all(0),
    color: white,
    shape: RoundedRectangleBorder(
        borderRadius:
            corners == null ? BorderRadius.circular(corner_5) : BorderRadius.circular(corners)),
    child: TextFormField(
        onChanged: (value) => {},
        maxLines: maxLines,
        minLines: minLines,
        enabled: eneable,
        initialValue: text,
        style: textMedium(color: paynesGrey),
        obscureText: isPassword,
        keyboardType: textInputType,
        keyboardAppearance: Brightness.dark,
        textInputAction: textInputAction,
        decoration: InputDecoration(
            hintStyle:
                applyhintstyle ? TextStyle(color: Colors.black) : TextStyle(color: Colors.grey),
            contentPadding: EdgeInsets.symmetric(vertical: padding_16, horizontal: padding_10),
            hintText: hint,
            suffixIcon: iconButton,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(corner_30), borderSide: BorderSide.none),
            errorText: errorText),
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This Field Is Required';
          }
          return null;
        }),
  );
}

SizedBox customsmallTextField(
    {required String hint,
    TextInputType? textInputType,
    TextInputAction? textInputAction,
    int maxLines = 1,
    int? minLines,
    String? text,
    bool eneable = true,
    bool isPassword = false,
    required TextEditingController controller,
    String? errorText,
    IconButton? iconButton,
    double? corners}) {
  return SizedBox(
    width: 130,
    child: Card(
      margin: EdgeInsets.all(0),
      color: white,
      shape: RoundedRectangleBorder(
          borderRadius:
              corners == null ? BorderRadius.circular(corner_5) : BorderRadius.circular(corners)),
      child: TextFormField(
          onChanged: (value) => {},
          maxLines: maxLines,
          minLines: minLines,
          enabled: eneable,
          initialValue: text,
          style: textMedium(color: paynesGrey),
          obscureText: isPassword,
          keyboardType: textInputType,
          keyboardAppearance: Brightness.dark,
          textInputAction: textInputAction,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: padding_16, horizontal: padding_10),
              hintText: hint,
              suffixIcon: iconButton,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(corner_30), borderSide: BorderSide.none),
              errorText: errorText),
          controller: controller,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter some text';
            }
            return null;
          }),
    ),
  );
}

Container customInputChat(
    {required void Function() onClick, required TextEditingController controller}) {
  return Container(
      color: windsor,
      child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding_16, vertical: padding_10),
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                    child: customTextField(
                  hint: 'Escribe un mensaje...',
                  controller: controller,
                  corners: corner_30,
                )),
                SizedBox(width: size_10),
                FloatingActionButton(
                    tooltip: 'Enviar mensaje',
                    backgroundColor: deepSkyBlue,
                    foregroundColor: white,
                    onPressed: onClick,
                    child: Icon(Icons.send, size: size_20))
              ])));
}

IconButton iconPassword(
    {required BuildContext context, required bool viewPassword, required void Function() onClick}) {
  return IconButton(
      icon: Icon(!viewPassword ? Icons.visibility : Icons.visibility_off),
      onPressed: () => onClick());
}

Container buttonRound(
    {required BuildContext context,
    required String text,
    required void Function() onClick,
    Color? color,
    double? width}) {
  return Container(
      color: Colors.transparent,
      width: width == null ? MediaQuery.of(context).size.width : width,
      height: size_50,
      child: FlatButton(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(corner_30)),
          onPressed: () => onClick(),
          color: color,
          child: Text(text, style: textBig(color: white))));
}

Container buttonRoundWithIcon(
    {required BuildContext context,
    required void Function() onClick,
    required IconData icon,
    Color? color,
    double? width}) {
  return Container(
      decoration: BoxDecoration(color: Colors.blue, borderRadius: BorderRadius.circular(30)),
      width: width == null ? MediaQuery.of(context).size.width : width,
      height: size_50,
      child: IconButton(
          onPressed: () => onClick(),
          color: color,
          icon: Icon(
            icon,
            color: Colors.white,
          )));
}

RaisedButton cardButton(
    {required BuildContext context, required String text, required void Function() onClick}) {
  return RaisedButton(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(corner_5)),
    onPressed: onClick,
    color: white,
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: padding_16, horizontal: padding_0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text, style: textDefault(color: paynesGrey)),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: paynesGrey,
            size: size_20,
          )
        ],
      ),
    ),
  );
}

BottomNavigationBar customBottomNavigationBar(
    {int? currentIndex, List<BottomNavigationBarItem>? items, void Function(int)? onTap}) {
  return BottomNavigationBar(
    unselectedItemColor: white,
    selectedItemColor: turquoiseBlue,
    backgroundColor: windsor,
    currentIndex: currentIndex!,
    items: items!,
    onTap: onTap,
  );
}

Container customImagesetter(
    {double? width,
    required double height,
    required BoxShape shape,
    String? urlImage,
    double? allCorner,
    double? leftCorner,
    double? rightCorner,
    File? file}) {
  return Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
        color: black, // delete later
        shape: shape,
        image: DecorationImage(
          image: file != null
              ? FileImage(file)
              : urlImage != null
                  ? NetworkImage(urlImage) as ImageProvider
                  : AssetImage("lib/images/ic_logo.png"),
          fit: BoxFit.cover,
        ),
        borderRadius: allCorner != null
            ? BorderRadius.circular(allCorner)
            : leftCorner != null
                ? BorderRadius.horizontal(left: Radius.circular(leftCorner))
                : BorderRadius.horizontal(left: Radius.circular(rightCorner!))),
  );
}

Container customImageSVJ(
    {double? width,
    double? height,
    required BoxShape shape,
    String? urlImage,
    double? allCorner,
    double? leftCorner,
    double? rightCorner}) {
  return Container(
    width: width,
    height: height,
    child: urlImage != null
        ? SvgPicture.network(
            urlImage,
            placeholderBuilder: (BuildContext context) => Container(
                // padding: const EdgeInsets.all(10.0),
                child: const CircularProgressIndicator()),
            fit: BoxFit.fill,
          )
        : Image.asset("lib/images/ic_logo.png", fit: BoxFit.fill),
    decoration: BoxDecoration(
        shape: shape,
        borderRadius: allCorner != null
            ? BorderRadius.circular(allCorner)
            : leftCorner != null
                ? BorderRadius.horizontal(left: Radius.circular(leftCorner))
                : BorderRadius.horizontal(left: Radius.circular(rightCorner!))),
  );
}

Container customImageJPG(
    {double? width,
    double? height,
    required BoxShape shape,
    String? urlImage,
    double? allCorner,
    double? leftCorner,
    double? rightCorner}) {
  return Container(
    width: width,
    height: height,
    child: urlImage != null
        ? FadeInImage.memoryNetwork(
            image: urlImage,
            placeholder: kTransparentImage,
            fit: BoxFit.cover,
          )
        : Image.asset("lib/images/ic_logo.png", fit: BoxFit.fill),
    decoration: BoxDecoration(
        shape: shape,
        borderRadius: allCorner != null
            ? BorderRadius.circular(allCorner)
            : leftCorner != null
                ? BorderRadius.horizontal(left: Radius.circular(leftCorner))
                : BorderRadius.horizontal(left: Radius.circular(rightCorner!))),
  );
}

Card cardwithImage({String? url, required String title, required String description}) {
  return Card(
      margin: EdgeInsets.all(margin_0),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            customImageJPG(
                leftCorner: corner_5,
                urlImage: url,
                width: size_100,
                height: size_100,
                shape: BoxShape.rectangle),
            SizedBox(width: size_10),
            Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textMedium(color: paynesGrey),
                  ),
                  Text(
                    description,
                    style: textDefault(color: paynesGrey),
                  )
                ])
          ]));
}

GestureDetector addressCard(
    {required User user,
    required Address address,
    required BuildContext context,
    required String token}) {
  Size size = MediaQuery.of(context).size;
  return GestureDetector(
    onTap: () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AddressDetail(
                    token: token,
                    address: address,
                    user: user,
                  )));
    },
    child: Container(
      height: size.height * 0.21,
      width: size.width * 0.9,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    address.address.length > 25
                        ? address.address.substring(0, 24) + ".."
                        : address.address,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UpdateAddress(
                                      token: token,
                                      address: address,
                                      user: user,
                                    )));
                      },
                      child: Text(
                        "Editar",
                        style: TextStyle(color: Colors.red),
                      ))
                ],
              ),
              SizedBox(width: size_10),
              Text(
                address.country,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: size_10),
              Text(
                address.state,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: size_10),
              Text(
                address.city,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
              SizedBox(width: size_10),
              Text(
                address.description,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ]),
      ),
    ),
  );
}

showProgressDialog({required BuildContext context}) {
  // set up the progress indicator
  Widget progress = Column(mainAxisSize: MainAxisSize.min, children: [
    SizedBox(
      height: size_20,
    ),
    CircularProgressIndicator(),
    SizedBox(
      height: size_20,
    ),
    Text('Cargando', style: textBig(color: paynesGrey)),
    SizedBox(
      height: size_20,
    ),
  ]);

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(content: progress);

  // show the dialog
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return alert;
      });
}

// showProgressDialog({BuildContext context}) {
//   // show the dialog
//   showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (BuildContext context) {
//         return AlertDialog(
//             content: Column(mainAxisSize: MainAxisSize.min, children: [
//           SizedBox(
//             height: size_20,
//           ),
//           CircularProgressIndicator(),
//           SizedBox(
//             height: size_20,
//           ),
//           Text('Cargando', style: textBig(color: paynesGrey)),
//           SizedBox(
//             height: size_20,
//           ),
//         ]));
//       });
// }

showsnakbar({required BuildContext context, required int statuscode}) {
  String message = "";
  if (statuscode == 211) message = "Updated Successfully";
  if (statuscode == 400) message = "Invalid Sysntax";
  if (statuscode == 401) message = "Email Or Password Incorrect";
  if (statuscode == 403) message = "You do not have access rights to the content";
  if (statuscode == 403) message = "The server can not find the requested resource";
  if (statuscode == 403) message = "Request Timeout";
  if (statuscode == 413) message = "Request entity is larger than limits defined by server";
  if (statuscode == 423) message = "The resource that is being accessed is locked";
  if (statuscode == 432) message = "Invalid email or Password too Short";
  if (statuscode == 422) message = "Invalid Arguments";

  if (statuscode == 500) message = "Internal Server Error";

  if (statuscode == 504) message = "HTTP version Not supported";
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        elevation: 2,
        title: Text("Error Messege"),
        content: Text(message),
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
}

showAlertDialogAction(
    {required BuildContext context, required String title, required List<Widget> items}) {
  // set up the buttons
  Widget negativeButton = TextButton(
      child: Text("Cancelar", style: textMedium(color: black)),
      onPressed: () => Navigator.of(context).pop());

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      title,
      style: textBig(color: black),
      textAlign: TextAlign.center,
    ),
    actions: [negativeButton],
    content: SingleChildScrollView(child: ListBody(children: items)),
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
