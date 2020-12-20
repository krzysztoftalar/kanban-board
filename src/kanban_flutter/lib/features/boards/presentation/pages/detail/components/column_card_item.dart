import 'package:flutter/material.dart';

import '../../../../../../style/index.dart';
import '../../../../domain/entities/index.dart';

// TODO Add functionality, rebuild card ui
class ColumnCardItem extends StatelessWidget {
  final CardItem card;

  ColumnCardItem({
    @required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: getSize(2),
        left: getSize(8),
        right: getSize(8),
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
                  fontSize: getSize(ThemeSize.fs_15),
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
