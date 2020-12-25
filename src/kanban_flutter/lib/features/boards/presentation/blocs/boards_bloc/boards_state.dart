part of 'boards_bloc.dart';

enum BoardsStatus { initial, success, failure }

class BoardsState extends Equatable {
  final BoardsStatus status;
  final List<Board> boards;
  final bool hasReachedMax;

  BoardsState({
    this.status = BoardsStatus.initial,
    this.boards = const <Board>[],
    this.hasReachedMax = false,
  });

  BoardsState copyWith({
    BoardsStatus status,
    List<Board> boards,
    bool hasReachedMax,
  }) =>
      BoardsState(
        status: status ?? this.status,
        boards: boards ?? this.boards,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      );

  @override
  List<Object> get props => [status, boards, hasReachedMax];
}

