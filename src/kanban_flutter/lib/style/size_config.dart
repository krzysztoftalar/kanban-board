import 'package:flutter/material.dart';

class SizeConfig {
  static MediaQueryData mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static bool isLandscape;

  void init(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);
    screenWidth = mediaQueryData.size.width;
    screenHeight = mediaQueryData.size.height;
    isLandscape = mediaQueryData.orientation == Orientation.landscape;
  }
}

// 411 is the layout width that designer use
double getSize(double inputSize) {
  if (SizeConfig.isLandscape) {
    return (inputSize / 411) * SizeConfig.screenHeight;
  }
  return (inputSize / 411) * SizeConfig.screenWidth;
}
