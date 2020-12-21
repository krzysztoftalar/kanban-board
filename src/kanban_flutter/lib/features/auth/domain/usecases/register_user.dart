import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/index.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class RegisterUser extends UseCase<User, RegisterParams> {
  final UserRepository repository;

  RegisterUser({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, User>> call(RegisterParams params) async {
    return await repository.register(params);
  }
}
