import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../data/models/index.dart';
import '../../data/params/index.dart';
import '../entities/index.dart';

abstract class BoardRepository {
  Future<Either<ServerException, BoardsEnvelope>> getBoards(
      GetBoardsParams params);

  Future<Either<ServerException, Board>> getBoardById(int id);

  Future<Either<ServerException, int>> createBoard(CreateBoardParams params);

  Future<Either<ServerException, bool>> editBoard(EditBoardParams params);

  Future<Either<ServerException, bool>> deleteBoard(DeleteBoardParams params);
}
