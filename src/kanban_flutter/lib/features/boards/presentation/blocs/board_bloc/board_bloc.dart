import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import "../../../domain/entities/index.dart";
import '../../../data/params/index.dart';
import '../../../domain/usecases/index.dart';

part 'board_event.dart';

part 'board_state.dart';

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final GetBoardById getBoardById;
  final UpdateColumnIndex updateColumnIndex;
  final UpdateCardIndex updateCardIndex;

  BoardBloc({
    @required this.getBoardById,
    @required this.updateColumnIndex,
    @required this.updateCardIndex,
  }) : super(BoardInitial());

  @override
  Stream<BoardState> mapEventToState(BoardEvent event) async* {
    if (event is GetBoardByIdEvent) {
      yield* _mapBoardLoadedToState(event);
    }
  }

  Stream<BoardState> _mapBoardLoadedToState(GetBoardByIdEvent event) async* {
    if (event.setLoading) {
      yield BoardLoading();
    }

    final boardEither =
        await getBoardById(GetBoardByIdParams(id: event.boardId));

    yield boardEither.fold(
      (failure) => BoardError(message: failure.message),
      (board) => BoardLoaded(board: board),
    );
  }
}
