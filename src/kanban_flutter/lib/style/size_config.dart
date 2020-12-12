import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
  }
}

// 683 is the layout height that designer use
double getProportionateHeight(double inputHeight) =>
    (inputHeight / 683) * SizeConfig.screenHeight;

// 411 is the layout width that designer use
double getProportionateWidth(double inputWidth) =>
    (inputWidth / 411) * SizeConfig.screenWidth;
