part of 'board_bloc.dart';

abstract class BoardState extends Equatable {
  const BoardState();

  @override
  List<Object> get props => [];
}

class BoardInitial extends BoardState {}

class BoardLoading extends BoardState {}

class BoardLoaded extends BoardState {
  final Board board;

  BoardLoaded({
    @required this.board,
  });

  @override
  List<Object> get props => [board];
}

class BoardError extends BoardState {
  final String message;

  BoardError({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
