part of 'card_bloc.dart';

abstract class CardState extends Equatable {
  const CardState();

  @override
  List<Object> get props => [];
}

class CardInitial extends CardState {}

class CardLoading extends CardState {}

class CardSuccess extends CardState {}

class CardError extends CardState {
  final String message;

  CardError({
    @required this.message,
  });

  @override
  List<Object> get props => [message];
}
