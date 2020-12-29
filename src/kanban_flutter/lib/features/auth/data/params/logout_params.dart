import 'package:flutter/foundation.dart';

class LogoutParams {
  final String refreshToken;

  LogoutParams({
    @required this.refreshToken,
  });

  Map<String, dynamic> toJson() => {
        "refreshToken": refreshToken,
      };
}
