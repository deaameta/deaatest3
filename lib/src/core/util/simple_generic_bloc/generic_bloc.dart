import 'package:dartz/dartz.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core.dart';

part 'generic_bloc_event.dart';
part 'generic_bloc_state.dart';

///Simple class aimed to provide mutual logic for simple blocs that ///only do async resource fetching
abstract class SimpleLoaderBloc<T> extends Bloc<SimpleBlocEvent, SimpleBlocState> {
  late final ScrollController scrollController;

  SimpleLoaderBloc({required this.eventParams, this.hideLoadingAfterFirstSuccess = false}) : super(InitialState()) {
    on<LoadEvent>(_onLoad);
    on<LoadMoreEvent>(_onLoadMore);
    scrollController = ScrollController();
    scrollController.addListener(_onScroll);
  }

  final eventParams;
  final bool hideLoadingAfterFirstSuccess;

  final _debouncer = Debouncer(milliseconds: 350);

  void _onScroll() {
    _debouncer.run(() {
      final maxScroll = scrollController.position.maxScrollExtent;
      final currentScroll = scrollController.position.pixels;
      if (maxScroll - currentScroll <= 50) {
        add(LoadMoreEvent(eventParams));
      }
    });
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }

  Future<void> _onLoadMore(LoadMoreEvent<dynamic> event, Emitter<SimpleBlocState> emit) async {
    if ((state is SuccessState && !((state as SuccessState).hasReachedMax))) {
      final result = await load(event);
      result.fold((l) {
        emit(SuccessState<T>((state as SuccessState).items, false)); // if error happen don't block the screen with the error
      }, (r) {
        emit(SuccessState<T>((state as SuccessState).items + r, isListReachedMax<T>(r)));
      });
    }
  }

  _onLoad(LoadEvent event, Emitter<SimpleBlocState> emit) async {
    if (hideLoadingAfterFirstSuccess && state is SuccessState) {
      emit((state as SuccessState).copyWith(isRefreshing: true));
    } else {
      emit(LoadingState());
    }

    final result = await load(event);
    result.fold((l) {
      emit(ErrorState(l.errorMessage));
    }, (r) {
      emit(SuccessState<T>(r, isListReachedMax<T>(r)));
    });
  }

  Future<Either<Failure, T>> load(SimpleBlocEvent event);
}

bool isListReachedMax<T>(T list) {
  return (list is List) && (list.isEmpty || list.length < 10);
}
