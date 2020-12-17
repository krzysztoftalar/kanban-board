import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/error/exceptions.dart';
import "../../../domain/entities/index.dart";
import '../../../data/params/index.dart';
import '../../../domain/usecases/index.dart';

part 'board_event.dart';

part 'board_state.dart';

typedef Future<Either<ServerException, Board>> _BoardRequest();

class BoardBloc extends Bloc<BoardEvent, BoardState> {
  final GetBoardById getBoardById;
  final CreateBoard createBoard;

  BoardBloc({
    @required this.getBoardById,
    @required this.createBoard,
  }) : super(BoardInitial());

  @override
  Stream<BoardState> mapEventToState(BoardEvent event) async* {
    if (event is GetBoardByIdEvent) {
      yield* _mapBoardLoadedToState(
        event,
        () => getBoardById(GetBoardByIdParams(id: event.boardId)),
      );
    } else if (event is CreateBoardEvent) {
      yield BoardLoading();

      final boardEither = await createBoard(CreateBoardParams(
        title: event.title,
        templateId: event.templateId,
      ));

      yield boardEither.fold(
        (failure) => BoardError(message: failure.message),
        (boardId) => BoardCreated(boardId: boardId),
      );
    }
  }

  Stream<BoardState> _mapBoardLoadedToState(
      BoardEvent event, _BoardRequest _boardRequest) async* {
    if (event.setLoading) {
      yield BoardLoading();
    }

    final boardEither = await _boardRequest();

    yield boardEither.fold(
      (failure) => BoardError(message: failure.message),
      (board) => BoardLoaded(board: board),
    );
  }
}
