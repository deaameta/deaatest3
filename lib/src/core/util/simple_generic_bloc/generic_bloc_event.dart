part of 'generic_bloc.dart';

abstract class SimpleBlocEvent {}

class LoadEvent<T> extends SimpleBlocEvent {
  final T params;

  LoadEvent(this.params);
}

class LoadMoreEvent<T> extends SimpleBlocEvent {
  final T params;

  LoadMoreEvent(this.params);
}
