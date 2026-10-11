import 'dart:ui';
import 'package:hourify/features/calender/widgets/ca_custom_colors.dart';
import 'package:flutter/material.dart';
class CaTextstyle {

  static TextStyle headerTextStyle = TextStyle(
    color: CaCustomColors.caTextHeaderColor,
    fontWeight: FontWeight.bold,
    fontSize: 25
  );

  static TextStyle formatTextStyle = TextStyle(
    color: CaCustomColors.black,
    fontWeight: FontWeight.bold,
    fontSize: 20
  );
  static TextStyle formatTextStylemonth = TextStyle(
      color: CaCustomColors.textColor,
      fontWeight: FontWeight.bold
  );

}