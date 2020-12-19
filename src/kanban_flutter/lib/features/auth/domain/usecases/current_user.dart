import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../entities/user.dart';
import '../repositories/user_repository.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/exceptions.dart';

class CurrentUser extends UseCase<User, NoParams> {
  final UserRepository repository;

  CurrentUser({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, User>> call(NoParams params) async {
    return await repository.currentUser(params);
  }
}
