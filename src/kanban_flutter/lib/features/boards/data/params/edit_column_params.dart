import 'package:flutter/foundation.dart';

class EditColumnParams {
  final int columnId;
  final String title;

  EditColumnParams({
    @required this.columnId,
    @required this.title,
  });

  Map<String, dynamic> toJson() => {
        "columnId": columnId,
        "title": title,
      };
}
