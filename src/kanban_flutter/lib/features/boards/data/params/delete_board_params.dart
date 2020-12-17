import 'package:flutter/foundation.dart';

class DeleteBoardParams {
  final int boardId;

  DeleteBoardParams({
    @required this.boardId,
  });

  Map<String, dynamic> toJson() => {
        "boardId": boardId,
      };
}
