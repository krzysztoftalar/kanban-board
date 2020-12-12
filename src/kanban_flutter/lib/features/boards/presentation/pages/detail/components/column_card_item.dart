import 'package:flutter/material.dart';

import '../../../../domain/entities/index.dart';
import '../../../../../../style/index.dart';

class ColumnCardItem extends StatelessWidget {
  final CardItem card;

  ColumnCardItem({
    @required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: getProportionateWidth(2),
        left: getProportionateWidth(8),
        right: getProportionateWidth(8),
      ),
      child: Card(
        color: ThemeColor.card_bg,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                card.title,
                style: TextStyle(
                  height: 1.5,
                  fontSize: getProportionateWidth(ThemeSize.fs_15),
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
