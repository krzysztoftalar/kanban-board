import 'package:dartz/dartz.dart';

import '../../../../core/usecases/usecase.dart';
import '../../../../core/error/exceptions.dart';
import '../entities/user.dart';
import '../../data/params/login_params.dart';

abstract class UserRepository {
  Future<Either<ServerException, User>> login(LoginParams params);
  Future<Either<ServerException, User>> currentUser(NoParams params);
}