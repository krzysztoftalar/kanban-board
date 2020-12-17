import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

const String SERVER_FAILURE_MESSAGE = 'Server failure';
const String UNEXPECTED_FAILURE_MESSAGE = 'Something went wrong';
const String GET_BOARDS_FAILURE_MASSAGE = 'Failed to fetch boards';