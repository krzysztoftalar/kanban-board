import 'package:flutter/material.dart';

import '../../../style/index.dart';

class SmallProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getSize(20),
      width: getSize(20),
      child: CircularProgressIndicator(strokeWidth: 1.5),
    );
  }
}
