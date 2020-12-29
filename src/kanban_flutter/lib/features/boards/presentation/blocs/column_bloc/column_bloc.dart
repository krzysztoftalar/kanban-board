import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../../../common/widgets/index.dart';
import "../../../domain/entities/index.dart";
import '../../../../../style/theme_color.dart';
import '../../../../../core/error/exceptions.dart';
import '../../../data/params/index.dart';
import '../../../domain/usecases/index.dart';

part 'column_event.dart';

part 'column_state.dart';

typedef Future<Either<ServerException, bool>> _ColumnRequest();

class ColumnBloc extends Bloc<ColumnEvent, ColumnState> {
  final UpdateColumnIndex updateColumnIndex;
  final EditColumn editColumn;
  final CreateColumn createColumn;
  final DeleteColumn deleteColumn;

  ColumnBloc({
    @required this.updateColumnIndex,
    @required this.editColumn,
    @required this.createColumn,
    @required this.deleteColumn,
  }) : super(ColumnInitial());

  @override
  Stream<ColumnState> mapEventToState(
    ColumnEvent event,
  ) async* {
    if (event is UpdateColumnIndexEvent) {
      yield* _mapColumnToState(
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
    } else if (event is EditColumnEvent) {
      yield* _mapColumnToState(
        event,
        () => editColumn(
          EditColumnParams(
            columnId: event.columnId,
            title: event.title,
          ),
        ),
      );
    } else if (event is DeleteColumnEvent) {
      yield* _mapColumnToState(
        event,
        () => deleteColumn(DeleteColumnParams(columnId: event.column.id)),
      );
    } else if (event is CreateColumnEvent) {
      yield* _mapColumnToState(
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

  Stream<ColumnState> _mapColumnToState(
      ColumnEvent event, _ColumnRequest _columnRequest) async* {
    yield ColumnLoading();

    final cardEither = await _columnRequest();

    yield cardEither.fold(
      (failure) => ColumnError(message: failure.message),
      (success) {
        if (event is CreateColumnEvent) {
          GlobalSnackBar.show(
            "${event.title} column successfully created",
            ThemeColor.snackBar_success_bg,
          );
        } else if (event is DeleteColumnEvent) {
          GlobalSnackBar.show(
            "${event.column.title} deleted",
            ThemeColor.snackBar_success_bg,
          );
        }

        return ColumnSuccess();
      },
    );
  }
}
