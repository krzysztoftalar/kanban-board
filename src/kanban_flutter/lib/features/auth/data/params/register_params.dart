import 'package:flutter/foundation.dart';

class RegisterParams {
  final String userName;
  final String email;
  final String password;

  RegisterParams({
    @required this.userName,
    @required this.email,
    @required this.password,
  });

  Map<String, dynamic> toJson() => {
        "userName": userName,
        "email": email,
        "password": password,
      };
}
