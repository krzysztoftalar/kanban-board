import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class User extends Equatable {
  final String userName;
  final String token;

  User({
    @required this.userName,
    @required this.token,
  });

  User copyWith({String userName, String token}) {
    return User(
      userName: userName ?? this.userName,
      token: token ?? this.token,
    );
  }

  @override
  List<Object> get props => [userName, token];
}
