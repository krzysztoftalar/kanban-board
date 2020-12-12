import 'package:flutter/foundation.dart';

class UpdateCardIndexParams {
  final int oldCardIndex;
  final int newCardIndex;
  final int oldColumnIndex;
  final int newColumnIndex;
  final int cardId;
  final int boardId;

  UpdateCardIndexParams({
    @required this.oldCardIndex,
    @required this.newCardIndex,
    @required this.oldColumnIndex,
    @required this.newColumnIndex,
    @required this.cardId,
    @required this.boardId,
  });

  Map<String, dynamic> toJson() => {
    "oldCardIndex": oldCardIndex,
    "newCardIndex": newCardIndex,
    "oldColumnIndex": oldColumnIndex,
    "newColumnIndex": newColumnIndex,
    "cardId": cardId,
    "boardId": boardId,
  };
}