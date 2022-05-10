import 'package:flutter/material.dart';

import 'dimens.dart';

TextStyle textAppBar({Color? color}) {
  return TextStyle(
      fontSize: text_20, color: color, fontFamily: 'MontserratSemiBold');
}

TextStyle textSmall({Color? color}) {
  return TextStyle(
    fontSize: text_12,
    color: color,
    fontFamily: 'MontserratMedium',
  );
}

TextStyle textDefault({Color? color, TextDecoration? textDecoration}) {
  return TextStyle(
      fontSize: text_14,
      color: color,
      fontFamily: 'MontserratMedium',
      decoration: textDecoration);
}

TextStyle textMedium({Color? color}) {
  return TextStyle(
      fontSize: text_16, color: color, fontFamily: 'MontserratMedium');
}

TextStyle textBig({Color? color}) {
  return TextStyle(fontSize: 16, color: color, fontFamily: 'MontserratRegular');
}

TextStyle textTitle({Color? color}) {
  return TextStyle(
      fontSize: text_30, color: color, fontFamily: 'MontserratSemiBold');
}
