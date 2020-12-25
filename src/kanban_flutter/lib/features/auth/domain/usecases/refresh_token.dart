import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class RefreshToken extends UseCase<User, NoParams> {
  final UserRepository repository;

  RefreshToken({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, User>> call(NoParams params) async {
    return await repository.refreshToken(params);
  }
}
