import 'package:flutter/foundation.dart';

import '../../domain/entities/user.dart';

class UserModel extends User {
  final String userName;
  final String token;

  UserModel({
    @required this.userName,
    @required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json['userName'],
      token: json['token'],
    );
  }

  static UserModel fromJsonModel(Map<String, dynamic> json) =>
      UserModel.fromJson(json);
}
