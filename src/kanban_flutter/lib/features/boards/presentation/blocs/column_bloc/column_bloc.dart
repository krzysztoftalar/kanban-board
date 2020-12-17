import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../../core/error/exceptions.dart';
import '../../../data/params/index.dart';
import '../../../domain/usecases/index.dart';

part 'column_event.dart';

part 'column_state.dart';

typedef Future<Either<ServerException, bool>> _ColumnRequest();

class ColumnBloc extends Bloc<ColumnEvent, ColumnState> {
  final UpdateColumnIndex updateColumnIndex;
  final UpdateColumnTitle updateColumnTitle;
  final DeleteColumn deleteColumn;
  final CreateColumn createColumn;

  ColumnBloc({
    @required this.updateColumnIndex,
    @required this.updateColumnTitle,
    @required this.deleteColumn,
    @required this.createColumn,
  }) : super(ColumnInitial());

  @override
  Stream<ColumnState> mapEventToState(
    ColumnEvent event,
  ) async* {
    if (event is UpdateColumnIndexEvent) {
      yield* _mapCardToState(
        event,
        () => updateColumnIndex(
          UpdateColumnIndexParams(
            oldIndex: event.oldIndex,
            newIndex: event.newIndex,
            columnId: event.columnId,
            boardId: event.boardId,
          ),
        ),
      );
    } else if (event is UpdateColumnTitleEvent) {
      yield* _mapCardToState(
        event,
        () => updateColumnTitle(
          UpdateColumnTitleParams(
            columnId: event.columnId,
            title: event.title,
          ),
        ),
      );
    } else if (event is DeleteColumnEvent) {
      yield* _mapCardToState(
        event,
        () => deleteColumn(DeleteColumnParams(columnId: event.columnId)),
      );
    } else if (event is CreateColumnEvent) {
      yield* _mapCardToState(
        event,
        () => createColumn(
          CreateColumnParams(
            boardId: event.boardId,
            columnIndex: event.columnIndex,
            title: event.title,
          ),
        ),
      );
    }
  }

  Stream<ColumnState> _mapCardToState(
      ColumnEvent event, _ColumnRequest _columnRequest) async* {
    yield ColumnLoading();

    final cardEither = await _columnRequest();

    yield cardEither.fold(
      (failure) => ColumnError(message: failure.message),
      (success) => ColumnSuccess(),
    );
  }
}
