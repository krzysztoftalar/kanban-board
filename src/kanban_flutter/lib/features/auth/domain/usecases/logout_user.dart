import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/index.dart';
import '../repositories/user_repository.dart';

class LogoutUser extends UseCase<bool, LogoutParams> {
  final UserRepository repository;

  LogoutUser({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, bool>> call(LogoutParams params) async {
    return await repository.logout(params);
  }
}
