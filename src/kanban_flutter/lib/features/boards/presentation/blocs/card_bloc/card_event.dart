part of 'card_bloc.dart';

abstract class CardEvent extends Equatable {
  const CardEvent();
}

class UpdateCardIndexEvent extends CardEvent {
  final int oldCardIndex;
  final int newCardIndex;
  final int oldColumnIndex;
  final int newColumnIndex;
  final int cardId;
  final int boardId;

  UpdateCardIndexEvent({
    @required this.oldCardIndex,
    @required this.newCardIndex,
    @required this.oldColumnIndex,
    @required this.newColumnIndex,
    @required this.cardId,
    @required this.boardId,
  });

  @override
  List<Object> get props => [
        oldCardIndex,
        newCardIndex,
        oldColumnIndex,
        newColumnIndex,
        cardId,
        boardId
      ];
}

class CreateCardEvent extends CardEvent {
  final int columnId;
  final int cardIndex;
  final String title;

  CreateCardEvent({
    @required this.columnId,
    @required this.cardIndex,
    @required this.title,
  });

  @override
  List<Object> get props => [columnId, cardIndex, title];
}
