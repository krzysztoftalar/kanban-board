import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/user_repository.dart';

class LogoutUser extends UseCase<bool, NoParams> {
  final UserRepository repository;

  LogoutUser({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, bool>> call(NoParams params) async {
    return await repository.logout(params);
  }
}
