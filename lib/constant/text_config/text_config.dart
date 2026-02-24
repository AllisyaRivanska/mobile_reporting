import 'package:flutter/material.dart';
import 'package:mobile_reporting/constant/color_constant/color_constant.dart';

class TextConfig {

  static const loginTitle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  static const loginSubTitle = TextStyle(fontSize: 16,);
  static const loginFooter = TextStyle(fontSize: 12, color: ColorConstant.hintGrey);

  static const TextStyle titleExtraLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  );

  
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
    fontWeight: FontWeight.w500,
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
    fontSize: 18,
    fontWeight: FontWeight.w800,
  );

  
 static const TextStyle titleHeader = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle headerHomePage = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static const TextStyle subHeaderHomePage = TextStyle(
    fontSize: 14, 
    color: Colors.white70
    );

  static const TextStyle textIcon = TextStyle(
    fontSize: 20, 
    fontWeight: FontWeight.bold
    );

  static const TextStyle subTextIcon = TextStyle(fontSize: 15);

  static const TextStyle information = TextStyle(
    fontWeight: FontWeight.bold, 
    fontSize: 13
    );

  static const TextStyle subInformation = TextStyle(
    fontWeight: FontWeight.bold, 
    fontSize: 12
    );

    static const TextStyle seeDetailHomePage = TextStyle(
    color: ColorConstant.primaryColor,
    fontWeight: FontWeight.bold,
    fontSize: 12,
    );

  static const TextStyle status = TextStyle(
    color: Colors.white, 
    fontSize: 12, 
    fontWeight: FontWeight.bold);


  static const TextStyle alertMessage = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  static const TextStyle alertSubMessage = TextStyle(fontSize: 12, color: Colors.black);
  static const TextStyle alertButton = TextStyle(color: Colors.black);
  static const TextStyle alertWhiteButton = TextStyle(color: Colors.white);

  static const TextStyle headerDetail = TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          );

  static const TextStyle snackBarMessage = TextStyle(fontWeight: FontWeight.bold, fontSize: 16);
  static const TextStyle snackBarSubMessage = TextStyle(fontSize: 12);
  static const TextStyle textTitle = TextStyle(fontWeight: FontWeight.bold, fontSize: 14);
  static const TextStyle descriptionCard = TextStyle(fontSize: 13, height: 1.5);
}