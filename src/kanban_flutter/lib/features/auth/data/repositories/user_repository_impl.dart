import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_data_source.dart';
import '../params/index.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({
    @required this.remoteDataSource,
  });

  Future<Either<ServerException, User>> login(LoginParams params) async {
    return await remoteDataSource.login(params);
  }

  @override
  Future<Either<ServerException, User>> register(RegisterParams params) async {
    return await remoteDataSource.register(params);
  }

  @override
  Future<Either<ServerException, User>> currentUser(NoParams params) async {
    return await remoteDataSource.currentUser(params);
  }

  @override
  Future<Either<ServerException, bool>> logout(NoParams params) async {
    return await remoteDataSource.logout(params);
  }

  @override
  Future<Either<ServerException, User>> refreshToken(NoParams params) async {
    return await remoteDataSource.refreshToken(params);
  }
}
