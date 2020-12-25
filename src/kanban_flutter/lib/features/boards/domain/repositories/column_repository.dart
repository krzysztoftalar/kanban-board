import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../data/params/index.dart';

abstract class ColumnRepository {
  Future<Either<ServerException, bool>> updateColumnIndex(
      UpdateColumnIndexParams params);

  Future<Either<ServerException, bool>> editColumn(EditColumnParams params);

  Future<Either<ServerException, bool>> deleteColumn(DeleteColumnParams params);

  Future<Either<ServerException, bool>> createColumn(CreateColumnParams params);
}
