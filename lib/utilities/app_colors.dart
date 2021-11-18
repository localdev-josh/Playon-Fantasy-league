import 'dart:math';

import 'package:flutter/material.dart';

class AppColors {
  static const kWhite = Colors.white;
  static const kBlack = Colors.black;
  static const kBlack1 = Color(0xffF2F3F5);
  static const kBlack2 = Color(0xff242C35);
  static const kPrimaryColorGrey = Color(0xff221F20);
  static const kPrimaryColorLightGrey = Color(0xffF2F3F5);
  static const kPrimaryColorLightShadeGrey = Color(0xffF3F5F7);
  static const kPrimaryColorDarkGrey = Color(0xff95A4BC);
  static const kPrimaryColorShadeGrey = Color(0xffD1D6DE);
  static const kPrimaryColorBlue = Color(0xff0184FB);
  static const kPrimaryColorBlueDark = Color(0xff0681F0);
  static const kPrimaryColor = Color(0xff000000);
  static const kPrimaryColor1 = Color(0xffb59021);
  static const kPrimaryColorLight = Color(0xffF7EDD1);
  static const kSubText = Color(0xff737373);
  static const kSecondaryColor = Color(0xff161616);
  static const kSecondaryColor2 = Color(0xffF9F4F4);
  static const kSecondaryColor3 = Color(0xffB7B7B7);
  static const kSecondaryColor4 = Color(0xffE3E1E1);
  static const kSecondaryColor5 = Color(0xff7F7F7F);
  static const kIndicatorColor = Color(0xff363333);
  static const kBottomNav = Color(0xffF9F4F4);
  static const kPrimaryColor2 = Color(0xff0b2328);
  static const kTextColor = Color(0xff050826);
  static const kLightText = Color(0xffdeeaed);
  static const kTextBg = Color(0xffEEEEEF);
  static const kGreyText = Color(0xff484848);
  static const kGreyText2 = Color(0xff666666);
  static const kGreyBg = Color(0xffE8E8E8);
  static const kGreyBg1 = Color(0xffDCDCDC);
  static const kGrey = Color(0xffE9E9E9);
  static const kYellow = Color.fromRGBO(255, 201, 54, 1);

  static var kRed = Color(0xFFd14747);
  static const kRed2 = Color(0xFFC05757);
  static const kRed3 = Color(0xffFBCBCB);
  static const kRed4 = Color(0xffF53232);
  static var kGreen = Color(0xFF2ab750);
  static var kGreen3 = Color(0xff189D4D);
  static var kGreen1 = Color(0xFF11D400);
  static var kGreen2 = Color(0xFF00CA45);
  static var kPending = Color(0xFFFF7519);
  static const kRejected = Color(0xFFE02020);
  static const knewBlue = Color(0xff010D57);

  static getRandomColor() => [
    Color(0xffF53232),
    Color(0xff0184FB),
    Color(0xFF00CA45),
  ][Random().nextInt(3)];
}
