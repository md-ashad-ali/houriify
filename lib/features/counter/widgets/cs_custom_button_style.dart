import 'package:flutter/material.dart';
import 'package:hourify/features/counter/widgets/cs_custom_app_color.dart';

class CsCustomButtonStyle {

  static ButtonStyle CustomButtonDesign = ElevatedButton.styleFrom(
    minimumSize: Size(100, 50),
    backgroundColor: CsCustomAppColor.appbuttonColor,
    foregroundColor: CsCustomAppColor.appBarColor,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusGeometry.circular(10),
    )
  );

}