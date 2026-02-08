import 'package:flutter/material.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';

class TextConfig {

  static const loginTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const loginSubTitle = TextStyle(fontSize: 16,);
  static const loginFooter = TextStyle(fontSize: 12, color: ColorConstant.hintGrey);

  
  static const TextStyle labelBoldSmall = TextStyle(
    fontSize: 12,
    color: ColorConstant.primaryColor,
  );

   static const TextStyle inputHint = TextStyle(
    fontSize: 14,
    color: ColorConstant.hintGrey,
  );

   static const TextStyle labelForm = TextStyle(
    fontSize: 16,
  );
   
   static const TextStyle labelIcon = TextStyle(fontSize: 12,);

   static const TextStyle labelIcon2 = TextStyle(fontSize: 12, color: ColorConstant.hintGrey);

    static const TextStyle errorTextSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: ColorConstant.errorColor,
  );

    static const TextStyle textButton = TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  
 static const TextStyle titleHeader = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );
}
