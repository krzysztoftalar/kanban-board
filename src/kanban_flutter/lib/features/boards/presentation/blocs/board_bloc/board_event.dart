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
