import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nft_deaa/src/features/home/domain/usecases/get_info_usecase.dart';

import '../../../../core/injections.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  late GetInfoUseCase transactionUseCase;

  HomeBloc() : super(HomeInitial()) {
    transactionUseCase = sl<GetInfoUseCase>();
    on<HomeEvent>((event, emit) async {
      if (event is TestEvent) {
        emit(HomeLoadingGetTransactionState());
        final allActiveBalancesResponse = await transactionUseCase.call(TransactionsParams());
        allActiveBalancesResponse.fold((l) {
          emit(HomeFailureGetTransactionState(l.errorMessage));
        }, (r) async {
          emit(HomeSuccessGetTransactionState());
        });
      }
    });
  }
}
