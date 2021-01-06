import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../common/widgets/index.dart';
import '../../../../../core/routes/routes.dart';
import '../../../../../main.dart';
import '../../../../../style/index.dart';
import '../../../data/params/index.dart';
import '../../../domain/entities/index.dart';
import '../../../domain/usecases/index.dart';

part 'boards_event.dart';

part 'boards_state.dart';

const BOARDS_LIMIT = 20;

class BoardsBloc extends Bloc<BoardsEvent, BoardsState> {
  GetBoards getBoards;
  CreateBoard createBoard;
  EditBoard editBoard;
  DeleteBoard deleteBoard;

  BoardsBloc({
    @required this.getBoards,
    @required this.createBoard,
    @required this.editBoard,
    @required this.deleteBoard,
  }) : super(BoardsState());

  @override
  Stream<BoardsState> mapEventToState(
    BoardsEvent event,
  ) async* {
    if (event is GetBoardsEvent) {
      yield* _mapGetBoardsToState();
    } else if (event is CreateBoardEvent) {
      yield* _mapBoardCreatedToState(event);
    } else if (event is EditBoardEvent) {
      yield* _mapBoardEditedToState(event);
    } else if (event is DeleteBoardEvent) {
      yield* _mapBoardDeletedToState(event);
    }
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

  Stream<BoardsState> _mapBoardCreatedToState(CreateBoardEvent event) async* {
    final boardEither = await createBoard(CreateBoardParams(
      title: event.title,
      templateId: event.templateId,
    ));

    yield boardEither.fold(
        (failure) => state.copyWith(status: BoardsStatus.failure), (boardId) {
      KanbanApp.navigatorKey.currentState
          .pushNamed(Routes.BOARD_DETAIL_PAGE, arguments: boardId);

      return state;
    });
  }

  Stream<BoardsState> _mapBoardEditedToState(EditBoardEvent event) async* {
    final boardsEither = await editBoard(EditBoardParams(
      boardId: event.boardId,
      title: event.title,
    ));

    yield boardsEither.fold(
        (failure) => state.copyWith(status: BoardsStatus.failure), (success) {
      final boardsState = List.of(state.boards)
          .map(
            (board) => board.id == event.boardId
                ? board.copyWith(title: event.title)
                : board,
          )
          .toList();
      return state.copyWith(
        status: BoardsStatus.success,
        boards: boardsState,
      );
    });
  }

  Stream<BoardsState> _mapBoardDeletedToState(DeleteBoardEvent event) async* {
    final boardsEither =
        await deleteBoard(DeleteBoardParams(boardId: event.board.id));

    yield boardsEither.fold(
        (failure) => state.copyWith(status: BoardsStatus.failure), (success) {
      GlobalSnackBar.show(
        "${event.board.title} deleted",
        ThemeColor.snackBar_success_bg,
      );

      final boardsState =
          List.of(state.boards).where((x) => x.id != event.board.id).toList();
      return state.copyWith(
        status: BoardsStatus.success,
        boards: boardsState,
      );
    });
  }
}
