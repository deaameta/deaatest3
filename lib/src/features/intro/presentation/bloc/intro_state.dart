part of 'intro_bloc.dart';

@immutable
abstract class IntroState {}

class IntroInitial extends IntroState {}

class IntroLoadingState extends IntroState {}

class IntroSuccessState extends IntroState {
  final IntroAction introAction;

  IntroSuccessState(this.introAction);
}

class  IntroFailureState extends IntroState {
  final String message;

  IntroFailureState(this.message);
}