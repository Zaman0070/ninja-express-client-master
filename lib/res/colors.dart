import 'package:flutter/material.dart';

//0xFF + color hexadecimal
MaterialColor white = MaterialColor(0xffFFFFFF, _getColorVariants(0xffFFFFFF));
MaterialColor ghostWhite = MaterialColor(0xffF3F4F9, _getColorVariants(0xffF3F4F9));
MaterialColor linkWater = MaterialColor(0xffC5CBDA, _getColorVariants(0xffC5CBDA));
MaterialColor zumthor = MaterialColor(0xffD1D3D3, _getColorVariants(0xffD1D3D3));
MaterialColor paynesGrey = MaterialColor(0xff383A46, _getColorVariants(0xff383A46));
MaterialColor black = MaterialColor(0xff000000, _getColorVariants(0xff000000));
MaterialColor transparent = MaterialColor(0xff66000000, _getColorVariants(0xff66000000));
MaterialColor sunshade = MaterialColor(0xffFF9945, _getColorVariants(0xffFF9945));
MaterialColor radicalRed = MaterialColor(0xffF7455E, _getColorVariants(0xffF7455E));
MaterialColor bittersweet = MaterialColor(0xffFD7663, _getColorVariants(0xffFD7663));
MaterialColor turquoiseBlue = MaterialColor(0xff75F1E5, _getColorVariants(0xff75F1E5));
MaterialColor brightTurquoise = MaterialColor(0xff04F1D6, _getColorVariants(0xff04F1D6));
MaterialColor deepSkyBlue = MaterialColor(0xff03A8F7, _getColorVariants(0xff03A8F7));
MaterialColor windsor = MaterialColor(0xff412C79, _getColorVariants(0xff412C79));

Map<int, Color> _getColorVariants(int color){
  Map<int, Color> colorVariants = {
    50:Color(color),
    100:Color(color),
    200:Color(color),
    300:Color(color),
    400:Color(color),
    500:Color(color),
    600:Color(color),
    700:Color(color),
    800:Color(color),
    900:Color(color),
  };
  return colorVariants;
}
