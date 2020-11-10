import 'dart:ui';

import 'package:flutter/material.dart';

class CustomTheme {
  static const bgColor = Color(0XFF021B3A);
  static const bgColor1 = Color(0XFF313F70);
  static const bgColor2 = Color(0XFF203063);
  static const mainTxtColor = Colors.white;
  static const infoTxtColor = Color(0XFF6B81BD);

  static const infoTxtStyle = TextStyle(
    height: 1.5,
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: infoTxtColor,
  );

  static const modalTxtStyle = TextStyle(
    height: 1.5,
    fontWeight: FontWeight.w600,
    fontSize: 15,
    color: infoTxtColor,
  );

  static const modalTitleTxtStyle = TextStyle(
    // height: 1.5,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    color: color1,
  );

  static const currentTasbihHeaderTxtStyle = TextStyle(
    height: 2,
    fontWeight: FontWeight.w500,
    fontSize: 20,
    color: CustomTheme.mainTxtColor,
  );

  static TextStyle chipTxtStyle = TextStyle(
    fontWeight: FontWeight.w800,
    color: Colors.black,
    fontSize: 14,
  );

  static const curveGradient = RadialGradient(
    colors: <Color>[
      bgColor1,
      bgColor2,
    ],
    focalRadius: 16,
  );

  static const titleStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: color1,
    fontSize: 36,
  );

  static const startTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: color1,
    fontSize: 18,
  );

  static const modalInputTextStyle = TextStyle(
    fontWeight: FontWeight.w600,
    color: color1,
    fontSize: 13,
  );

  static const Color inProgressColor = const Color(0XFF5ed6da);
  static const Color doneColor = const Color(0XFF1be549);
  static const Color startColor = const Color(0XFF4d4af5);

  static Color trackColor = Color(0XFFefeeeb).withOpacity(0.6);
  static Color doneColor1 = Color(0XFF2bcd6c);
  static Color notYetStarted = Color(0XFFfffb8a);

  static const Color color1 = Colors.white;
  static Color color3 = Colors.blueAccent.withOpacity(0.8);

  static TextStyle bottomLabelStyle = TextStyle(
    color: Colors.white.withOpacity(0.8),
    fontSize: 40,
    fontWeight: FontWeight.bold,
  );
  static TextStyle topLabelStyle = TextStyle(
    color: Colors.white.withOpacity(0.8),
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static TextStyle currentTasbihInfoStyle = TextStyle(
      color: Colors.white54.withOpacity(0.6),
      fontSize: 15,
      fontWeight: FontWeight.w600);
  static TextStyle mainLabelStyle = TextStyle(
    color: Colors.white.withOpacity(0.8),
    fontSize: 0,
    fontWeight: FontWeight.bold,
  );

  static const CompactDeviceHeaderHeight = 200;
  static const CompactDeviceListHeight = 250;
}
