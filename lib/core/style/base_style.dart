import 'package:flutter/material.dart';

class BaseStyle {
  //Color
  static Color primaryBlack = Color(0xff1f1f1f);
  static Color lightBlue = Color(0xffb2ebf2);
  static Color darkBlue = Color(0xff00a8cc);
  static Color disableBtnColor = Color(0xffaeaeae);
  static Color hintBgTextfieldColor = Color(0xffefefef);
  static Color hintTextColor = Color(0xffaeaeae);
  static Color orangeTextColor = Color(0xfff78259);
  static Color errorTextColor = Color(0xffe43f5a);
  static Color orangeBtnColor = Color(0xfff78259);

  static String fontFamily = 'Poppins';
  static FontWeight bold = FontWeight.w800;
  static FontWeight semiBold = FontWeight.w400;

  static TextStyle ts16PrimaryBlack = TextStyle(
    fontSize: 16,
    fontFamily: fontFamily,
    color: primaryBlack,
  );

  static TextStyle ts14PrimaryBlack = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    color: primaryBlack,
  );

  static TextStyle ts14RedBold = TextStyle(
      fontSize: 14,
      fontFamily: fontFamily,
      color: Colors.red,
      fontWeight: FontWeight.bold);

  static TextStyle ts14White = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    color: Colors.white,
  );

  static TextStyle ts14WhiteBold = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    color: Colors.white,
    fontWeight: bold,
  );

  static TextStyle ts18PrimaryBlack = TextStyle(
    fontSize: 18,
    fontFamily: fontFamily,
    color: primaryBlack,
  );

  static TextStyle ts12PrimaryBlack = TextStyle(
    fontSize: 12,
    fontFamily: fontFamily,
    color: primaryBlack,
  );

  static TextStyle ts32DarkBlue = TextStyle(
    fontSize: 32,
    fontFamily: fontFamily,
    color: darkBlue,
  );
  static TextStyle ts32DarkBlueBold = TextStyle(
    fontSize: 32,
    fontFamily: fontFamily,
    color: darkBlue,
    fontWeight: FontWeight.w800,
  );

  static TextStyle ts12DarkBlue = TextStyle(
    fontSize: 12,
    fontFamily: fontFamily,
    color: darkBlue,
  );

  static TextStyle ts12RedBold = TextStyle(
    fontSize: 12,
    fontFamily: fontFamily,
    color: errorTextColor,
    fontWeight: bold,
  );

  static TextStyle ts14DarkBlue = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    color: darkBlue,
  );

  static TextStyle ts16DarkBlue = TextStyle(
    fontSize: 16,
    fontFamily: fontFamily,
    color: darkBlue,
  );

  static TextStyle ts14Orange = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    color: orangeBtnColor,
  );

  static TextStyle ts14OrangeBold = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    color: orangeBtnColor,
    fontWeight: bold,
  );

  static TextStyle ts16Orange = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    color: darkBlue,
  );

  static TextStyle ts16ExplicitBlack = TextStyle(
    fontSize: 16,
    fontFamily: fontFamily,
    color: Colors.black,
  );

  static TextStyle ts16ExplicitBlackw400 = TextStyle(
      fontSize: 16,
      fontFamily: fontFamily,
      color: Colors.black,
      fontWeight: FontWeight.w400);

  static TextStyle ts16ExplicitBlackw600 = TextStyle(
      fontSize: 16,
      fontFamily: fontFamily,
      color: Colors.black,
      fontWeight: FontWeight.w600);

  static TextStyle ts14ExplicitBlack = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    color: Colors.black,
  );

  static TextStyle ts14ExplicitBlackSemiBold = TextStyle(
    fontSize: 14,
    fontFamily: fontFamily,
    color: Colors.black,
    fontWeight: bold,
  );

  static TextStyle ts14ExplicitBlackBold = TextStyle(
      fontSize: 14,
      fontFamily: fontFamily,
      color: Colors.black,
      fontWeight: FontWeight.bold);

  static TextStyle ts18ExplicitBlack = TextStyle(
    fontSize: 18,
    fontFamily: fontFamily,
    color: Colors.black,
  );

  static TextStyle ts12ExplicitBlack = TextStyle(
    fontSize: 12,
    fontFamily: fontFamily,
    color: Colors.black,
  );

  static TextStyle ts10ExplicitBlack = TextStyle(
    fontSize: 12,
    fontFamily: fontFamily,
    color: Colors.black,
  );

  static TextStyle ts12ExplicitBlackBold = TextStyle(
      fontSize: 12,
      fontFamily: fontFamily,
      color: Colors.black,
      fontWeight: bold);

  static TextStyle ts32ExplicitBlack = TextStyle(
    fontSize: 32,
    fontFamily: fontFamily,
    color: darkBlue,
  );

  static TextStyle ts18DarkBlue = TextStyle(
    fontSize: 18,
    fontFamily: fontFamily,
    color: darkBlue,
  );

  static TextStyle ts18DarkBlueBold = TextStyle(
    fontSize: 18,
    fontFamily: fontFamily,
    color: darkBlue,
    fontWeight: bold,
  );
}
