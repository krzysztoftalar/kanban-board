part of 'column_bloc.dart';

abstract class ColumnState extends Equatable {
  const ColumnState();

  @override
  List<Object> get props => [];
}

class ColumnInitial extends ColumnState {}

class ColumnLoading extends ColumnState {}

class ColumnSuccess extends ColumnState {}

class ColumnError extends ColumnState {
  final String message;

  ColumnError({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
