part of 'boards_bloc.dart';

abstract class BoardsEvent extends Equatable {
  const BoardsEvent();

  @override
  List<Object> get props => [];
}

class GetBoardsEvent extends BoardsEvent {}

class DeleteBoardEvent extends BoardsEvent {
  final int boardId;

  DeleteBoardEvent({
    @required this.boardId,
  });

  @override
  List<Object> get props => [boardId];
}
