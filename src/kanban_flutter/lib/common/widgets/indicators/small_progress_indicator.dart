import 'package:flutter/material.dart';

import '../../../style/index.dart';

class SmallProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getProportionateWidth(20),
      width: getProportionateWidth(20),
      child: CircularProgressIndicator(strokeWidth: 1.5),
    );
  }
}
