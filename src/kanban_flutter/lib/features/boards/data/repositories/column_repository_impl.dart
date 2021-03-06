import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../../../../core/error/exceptions.dart';
import '../../domain/repositories/column_repository.dart';
import '../datasources/index.dart';
import '../params/index.dart';

class ColumnRepositoryImpl implements ColumnRepository {
  final ColumnRemoteDataSource remoteDataSource;

  ColumnRepositoryImpl({
    @required this.remoteDataSource,
  });

  @override
  Future<Either<ServerException, bool>> updateColumnIndex(
      UpdateColumnIndexParams params) async {
    return await remoteDataSource.updateColumnIndex(params);
  }

  @override
  Future<Either<ServerException, bool>> editColumn(
      EditColumnParams params) async {
    return await remoteDataSource.editColumn(params);
  }

  @override
  Future<Either<ServerException, bool>> deleteColumn(
      DeleteColumnParams params) async {
    return await remoteDataSource.deleteColumn(params);
  }

  @override
  Future<Either<ServerException, bool>> createColumn(
      CreateColumnParams params) async {
    return await remoteDataSource.createColumn(params);
  }
}
