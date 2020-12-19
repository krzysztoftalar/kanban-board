import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/usecases/usecase.dart';
import '../models/user_model.dart';
import '../../../../core/api/api_client.dart';
import '../../../../core/error/exceptions.dart';
import '../params/index.dart';
import '../../domain/entities/user.dart';

abstract class UserRemoteDataSource {
  Future<Either<ServerException, User>> login(LoginParams params);

  Future<Either<ServerException, User>> currentUser(NoParams params);
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
  Future<Either<ServerException, User>> currentUser(NoParams params) async {
    return getRemoteData<User>(
      () => client.httpClient.get('/users'),
      ApiResponseType.Object,
      UserModel.fromJsonModel,
    );
  }
}
