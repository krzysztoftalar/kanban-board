import 'package:flutter/foundation.dart';

class EditBoardParams {
  final String title;
  final int boardId;

  EditBoardParams({
    @required this.title,
    @required this.boardId,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "boardId": boardId,
      };
}
