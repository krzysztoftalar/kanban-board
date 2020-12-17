import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/error/exceptions.dart';
import '../params/index.dart';

abstract class ColumnRemoteDataSource {
  Future<Either<ServerException, bool>> updateColumnIndex(
      UpdateColumnIndexParams params);

  Future<Either<ServerException, bool>> updateColumnTitle(
      UpdateColumnTitleParams params);

  Future<Either<ServerException, bool>> deleteColumn(DeleteColumnParams params);

  Future<Either<ServerException, bool>> createColumn(CreateColumnParams params);
}

class ColumnRemoteDataSourceImpl implements ColumnRemoteDataSource {
  final ApiClient client;

  ColumnRemoteDataSourceImpl({
    @required this.client,
  });

  @override
  Future<Either<ServerException, bool>> updateColumnIndex(
      UpdateColumnIndexParams params) async {
    return getRemoteData<bool>(
      () => client.httpClient.put(
        '/columns/${params.columnId}/drag',
        data: params.toJson(),
      ),
      ApiResponseType.Unit,
    );
  }

  @override
  Future<Either<ServerException, bool>> updateColumnTitle(
      UpdateColumnTitleParams params) async {
    return getRemoteData<bool>(
      () => client.httpClient.put(
        '/columns/${params.columnId}',
        data: params.toJson(),
      ),
      ApiResponseType.Unit,
    );
  }

  @override
  Future<Either<ServerException, bool>> deleteColumn(
      DeleteColumnParams params) async {
    return getRemoteData<bool>(
      () => client.httpClient.delete('/columns/${params.columnId}'),
      ApiResponseType.Unit,
    );
  }

  @override
  Future<Either<ServerException, bool>> createColumn(
      CreateColumnParams params) async {
    return getRemoteData<bool>(
      () => client.httpClient.post(
        '/columns',
        data: params.toJson(),
      ),
      ApiResponseType.Unit,
    );
  }
}
