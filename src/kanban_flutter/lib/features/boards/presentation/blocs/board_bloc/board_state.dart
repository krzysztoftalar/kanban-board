part of 'board_bloc.dart';

abstract class BoardState {
  const BoardState();
}

class BoardInitial extends BoardState {}

class BoardLoading extends BoardState {}

class BoardLoaded extends BoardState {
  final Board board;

  BoardLoaded({
    @required this.board,
  });
}

class BoardError extends BoardState {
  final String message;

  BoardError({
    @required this.message,
  });
}
