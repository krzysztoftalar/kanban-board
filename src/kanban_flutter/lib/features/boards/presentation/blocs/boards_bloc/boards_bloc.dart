import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../domain/usecases/index.dart';
import '../../../data/params/index.dart';
import '../../../domain/entities/index.dart';

part 'boards_event.dart';

part 'boards_state.dart';

const BOARDS_LIMIT = 20;

class BoardsBloc extends Bloc<BoardsEvent, BoardsState> {
  GetBoards getBoards;
  DeleteBoard deleteBoard;

  BoardsBloc({
    @required this.getBoards,
    @required this.deleteBoard,
  }) : super(BoardsState());

  @override
  Stream<BoardsState> mapEventToState(
    BoardsEvent event,
  ) async* {
    if (event is GetBoardsEvent) {
      yield* _mapGetBoardsToState();
    } else if (event is DeleteBoardEvent) {
      yield* _mapBoardDeletedToState(event);
    }
  }

  Stream<BoardsState> _mapBoardDeletedToState(DeleteBoardEvent event) async* {
    final boardsEither =
        await deleteBoard(DeleteBoardParams(boardId: event.boardId));

    yield boardsEither.fold(
        (failure) => state.copyWith(status: BoardsStatus.failure), (success) {
      final boardsState =
          List.of(state.boards).where((x) => x.id != event.boardId).toList();
      return state.copyWith(
        status: BoardsStatus.success,
        boards: boardsState,
      );
    });
  }

  Stream<BoardsState> _mapGetBoardsToState() async* {
    if (state.hasReachedMax) {
      yield state;
    }

    final boardsEither = await getBoards(
      GetBoardsParams(
        limit: BOARDS_LIMIT,
        skip: state.boards.length,
      ),
    );

    yield boardsEither
        .fold((failure) => state.copyWith(status: BoardsStatus.failure),
            (boardsEnvelope) {
      final boardsState = List.of(state.boards)..addAll(boardsEnvelope.boards);
      return state.copyWith(
        status: BoardsStatus.success,
        boards: boardsState,
        hasReachedMax: boardsState.length == boardsEnvelope.boardsCount,
      );
    });
  }
}
