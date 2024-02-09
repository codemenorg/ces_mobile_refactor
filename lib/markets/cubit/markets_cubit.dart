import 'package:api/api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'markets_state.dart';

class MarketsCubit extends Cubit<MarketsState> {
  MarketsCubit() : super(MarketsLoading()) {
    get();
  }

  MarketsRepository marketRepository = MarketsRepository(
    flavor: Flavor.production,
  );

  Future<void> get() async {
    try {
      final market = await marketRepository.get();
      emit(MarketsLoaded(market));
    } catch (exception) {
      emit(MarketsLoadingError(exception.toString()));
    }
  }
}
