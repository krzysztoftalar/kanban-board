import 'package:flutter/foundation.dart';

class CreateCardParams {
  final int columnId;
  final int cardIndex;
  final String title;

  CreateCardParams({
    @required this.columnId,
    @required this.cardIndex,
    @required this.title,
  });

  Map<String, dynamic> toJson() => {
        "columnId": columnId,
        "cardIndex": cardIndex,
        "title": title,
      };
}
