import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nft_deaa/src/core/core.dart';
import 'package:nft_deaa/src/features/intro/domain/usecases/get_intro_info.dart';
part 'intro_event.dart';
part 'intro_state.dart';

class IntroBloc extends Bloc<IntroEvent, IntroState> {
  final GetIntroInfoUseCase _getIntroInfoUseCase;
  bool isAutoUpdate = false;

  IntroBloc(this._getIntroInfoUseCase) : super(IntroInitial()) {
    on<IntroEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GetDataEvent>(_getDataEvent);

  }
  _getDataEvent(GetDataEvent event, Emitter<IntroState> emitter) async {
    final result = await _getIntroInfoUseCase.call(NoParams());
    result.fold((l) {
      emitter(IntroFailureState(l.errorMessage));
      }, (r) {
      emitter(IntroSuccessState(r));
    });
  }

}
