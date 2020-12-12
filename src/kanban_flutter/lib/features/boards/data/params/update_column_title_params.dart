import 'package:flutter/foundation.dart';

class UpdateColumnTitleParams {
  final int columnId;
  final String title;

  UpdateColumnTitleParams({
    @required this.columnId,
    @required this.title,
  });

  Map<String, dynamic> toJson() => {
        "columnId": columnId,
        "title": title,
      };
}
