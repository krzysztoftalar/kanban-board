import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../data/params/index.dart';
import '../../../domain/usecases/index.dart';

part 'card_event.dart';

part 'card_state.dart';

typedef Future<Either<ServerException, bool>> _CardRequest();

class CardBloc extends Bloc<CardEvent, CardState> {
  final UpdateCardIndex updateCardIndex;
  final CreateCard createCard;

  CardBloc({
    @required this.updateCardIndex,
    @required this.createCard,
  }) : super(CardInitial());

  @override
  Stream<CardState> mapEventToState(
    CardEvent event,
  ) async* {
    if (event is UpdateCardIndexEvent) {
      yield* _mapCardToState(
        event,
        () => updateCardIndex(
          UpdateCardIndexParams(
            oldCardIndex: event.oldCardIndex,
            newCardIndex: event.newCardIndex,
            oldColumnIndex: event.oldColumnIndex,
            newColumnIndex: event.newColumnIndex,
            cardId: event.cardId,
            boardId: event.boardId,
          ),
        ),
      );
    } else if (event is CreateCardEvent) {
      yield* _mapCardToState(
        event,
        () => createCard(
          CreateCardParams(
            columnId: event.columnId,
            cardIndex: event.cardIndex,
            title: event.title,
          ),
        ),
      );
    }
  }

  Stream<CardState> _mapCardToState(
      CardEvent event, _CardRequest _cardRequest) async* {
    yield CardLoading();

    final cardEither = await _cardRequest();

    yield cardEither.fold(
      (failure) => CardError(message: failure.message),
      (success) => CardSuccess(),
    );
  }
}
