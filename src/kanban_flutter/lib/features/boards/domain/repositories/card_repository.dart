import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../data/params/index.dart';

abstract class CardRepository {
  Future<Either<ServerException, bool>> updateCardIndex(
      UpdateCardIndexParams params);

  Future<Either<ServerException, bool>> createCard(CreateCardParams params);
}
