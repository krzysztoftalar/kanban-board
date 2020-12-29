import 'package:flutter/material.dart';

import '../../../../../../style/index.dart';
import '../../../../domain/entities/index.dart';

class ColumnCardItem extends StatelessWidget {
  final CardItem card;

  ColumnCardItem({
    @required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: getSize(8)),
      child: Card(
        color: ThemeColor.card_bg,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: getSize(10),
            horizontal: getSize(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                card.title,
                style: TextStyle(
                  height: 1.5,
                  fontSize: getSize(ThemeSize.fs_17),
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
