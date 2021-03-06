part of 'column_bloc.dart';

abstract class ColumnEvent extends Equatable {
  const ColumnEvent();
}

class UpdateColumnIndexEvent extends ColumnEvent {
  final int oldIndex;
  final int newIndex;
  final int columnId;
  final int boardId;

  UpdateColumnIndexEvent({
    @required this.oldIndex,
    @required this.newIndex,
    @required this.columnId,
    @required this.boardId,
  });

  @override
  List<Object> get props => [oldIndex, newIndex, columnId, boardId];
}

class EditColumnEvent extends ColumnEvent {
  final int columnId;
  final String title;

  EditColumnEvent({
    @required this.columnId,
    @required this.title,
  });

  @override
  List<Object> get props => [columnId, title];
}

class DeleteColumnEvent extends ColumnEvent {
  final ColumnItem column;

  DeleteColumnEvent({
    @required this.column,
  });

  @override
  List<Object> get props => [column];
}

class CreateColumnEvent extends ColumnEvent {
  final int boardId;
  final int columnIndex;
  final String title;

  CreateColumnEvent({
    @required this.boardId,
    @required this.columnIndex,
    @required this.title,
  });

  @override
  List<Object> get props => [boardId, columnIndex, title];
}
