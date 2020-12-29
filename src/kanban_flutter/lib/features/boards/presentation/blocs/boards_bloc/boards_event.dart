part of 'boards_bloc.dart';

abstract class BoardsEvent extends Equatable {
  const BoardsEvent();

  @override
  List<Object> get props => [];
}

class GetBoardsEvent extends BoardsEvent {}

class CreateBoardEvent extends BoardsEvent {
  final String title;
  final int templateId;

  CreateBoardEvent({
    @required this.title,
    @required this.templateId,
  });

  @override
  List<Object> get props => [title, templateId];
}

class EditBoardEvent extends BoardsEvent {
  final int boardId;
  final String title;

  EditBoardEvent({
    @required this.boardId,
    @required this.title,
  });

  @override
  List<Object> get props => [boardId, title];
}

class DeleteBoardEvent extends BoardsEvent {
  final Board board;

  DeleteBoardEvent({
    @required this.board,
  });

  @override
  List<Object> get props => [board];
}
