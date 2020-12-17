part of 'board_bloc.dart';

abstract class BoardEvent extends Equatable {
  final bool setLoading;

  const BoardEvent({
    this.setLoading = false,
  });

  @override
  List<Object> get props => [setLoading];
}

class GetBoardByIdEvent extends BoardEvent {
  final int boardId;
  final bool setLoading;

  GetBoardByIdEvent({
    @required this.boardId,
    this.setLoading = false,
  });

  @override
  List<Object> get props => [boardId, setLoading];
}

class CreateBoardEvent extends BoardEvent {
  final String title;
  final int templateId;

  CreateBoardEvent({
    @required this.title,
    @required this.templateId,
  });

  @override
  List<Object> get props => [title, templateId];
}
