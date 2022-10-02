part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

/// State when success get transaction
class HomeLoadingGetTransactionState extends HomeState {}

/// State when success get transaction
class HomeSuccessGetTransactionState extends HomeState {

  HomeSuccessGetTransactionState();
}

/// State when failure get transaction
class HomeFailureGetTransactionState extends HomeState {
  final String message;

  HomeFailureGetTransactionState(this.message);
}
