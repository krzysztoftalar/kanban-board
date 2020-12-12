part of 'board_bloc.dart';

abstract class BoardEvent extends Equatable {
  const BoardEvent();
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
