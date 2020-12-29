import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../data/params/current_user_params.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class CurrentUser extends UseCase<User, CurrentUserParams> {
  final UserRepository repository;

  CurrentUser({
    @required this.repository,
  });

  @override
  Future<Either<ServerException, User>> call(CurrentUserParams params) async {
    return await repository.currentUser(params);
  }
}
