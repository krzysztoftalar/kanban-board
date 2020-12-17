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

class UpdateColumnTitleEvent extends ColumnEvent {
  final int columnId;
  final String title;

  UpdateColumnTitleEvent({
    @required this.columnId,
    @required this.title,
  });

  @override
  List<Object> get props => [columnId, title];
}

class DeleteColumnEvent extends ColumnEvent {
  final int columnId;

  DeleteColumnEvent({
    @required this.columnId,
  });

  @override
  List<Object> get props => [columnId];
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
