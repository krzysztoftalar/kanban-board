import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/user.dart';
import '../models/user_model.dart';
import '../params/index.dart';

abstract class UserRemoteDataSource {
  Future<Either<ServerException, User>> login(LoginParams params);

  Future<Either<ServerException, User>> register(RegisterParams params);

  Future<Either<ServerException, User>> currentUser(NoParams params);

  Future<Either<ServerException, bool>> logout(NoParams params);

  Future<Either<ServerException, User>> refreshToken(NoParams params);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient client;

  UserRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<Either<ServerException, User>> login(LoginParams params) async {
    return getRemoteData<User>(
      () => client.httpClient.post(
        '/users/login',
        data: params.toJson(),
      ),
      ApiResponseType.Object,
      UserModel.fromJsonModel,
    );
  }

  @override
  Future<Either<ServerException, User>> register(RegisterParams params) async {
    return getRemoteData<User>(
      () => client.httpClient.post(
        '/users/register',
        data: params.toJson(),
      ),
      ApiResponseType.Object,
      UserModel.fromJsonModel,
    );
  }

  @override
  Future<Either<ServerException, User>> currentUser(NoParams params) async {
    return getRemoteData<User>(
      () => client.httpClient.get('/users'),
      ApiResponseType.Object,
      UserModel.fromJsonModel,
    );
  }

  @override
  Future<Either<ServerException, bool>> logout(NoParams params) async {
    return getRemoteData<bool>(
      () => client.httpClient.post('/users/logout'),
      ApiResponseType.Unit,
    );
  }

  @override
  Future<Either<ServerException, User>> refreshToken(NoParams params) async {
    return getRemoteData<User>(
      () => client.httpClient.post('/users/refreshToken'),
      ApiResponseType.Object,
      UserModel.fromJsonModel,
    );
  }
}
