import 'package:flutter/foundation.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  final String userName;
  final String token;
  final String refreshToken;

  UserModel({
    @required this.userName,
    @required this.token,
    @required this.refreshToken,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
      token: json['token'],
      refreshToken: json['refreshToken'],
    );
  }

  static UserModel fromJsonModel(Map<String, dynamic> json) =>
      UserModel.fromJson(json);
}
