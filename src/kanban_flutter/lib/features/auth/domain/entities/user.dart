import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String userName;
  final String token;
  final String refreshToken;

  User({
    @required this.userName,
    @required this.token,
    @required this.refreshToken,
  });

  User copyWith({String userName, String token}) {
    return User(
      userName: userName ?? this.userName,
      token: token ?? this.token,
      refreshToken: refreshToken ?? this.refreshToken,
    );
  }

  @override
  List<Object> get props => [userName, token, refreshToken];
}
