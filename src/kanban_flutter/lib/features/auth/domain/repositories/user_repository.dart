import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../data/params/index.dart';
import '../entities/user.dart';

abstract class UserRepository {
  Future<Either<ServerException, User>> login(LoginParams params);

  Future<Either<ServerException, User>> register(RegisterParams params);

  Future<Either<ServerException, User>> currentUser(CurrentUserParams params);

  Future<Either<ServerException, bool>> logout(LogoutParams params);
}
