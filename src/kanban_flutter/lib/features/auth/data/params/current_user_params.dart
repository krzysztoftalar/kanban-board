import 'package:flutter/foundation.dart';

class CurrentUserParams {
  final String refreshToken;

  CurrentUserParams({
    @required this.refreshToken,
  });

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken,
      };
}
