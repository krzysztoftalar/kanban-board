import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../entities/user.dart';
import '../repositories/user_repository.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/index.dart';
import '../../../../core/error/exceptions.dart';

class Login extends UseCase<User, LoginParams> {
  final UserRepository repository;

  Login({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, User>> call(LoginParams params) async {
    return await repository.login(params);
  }
}
