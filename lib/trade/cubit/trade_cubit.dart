import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'trade_state.dart';

class TradeCubit extends Cubit<TradeState> {
  TradeCubit() : super(TradeLoading()) {
    // get();
  }

  // HomeRepository homeRepository = HomeRepository(
  //   flavor: Flavor.production,
  // );

  // Future<void> get() async {
  //   try {
  //     final home = await homeRepository.get();
  //     emit(HomeLoaded(home));
  //   } catch (exception) {
  //     emit(HomeLoadingError(exception.toString()));
  //   }
  // }
}
