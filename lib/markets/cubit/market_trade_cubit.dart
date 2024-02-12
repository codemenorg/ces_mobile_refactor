import 'package:api/api.dart';
import 'package:bloc/bloc.dart';

part 'market_trade_state.dart';

class MarketTradeCubit extends Cubit<MarketTradeState> {
  MarketTradeCubit({this.marketId}) : super(MarketTradeLoading()) {
    marketTradeRepository = MarketTradesRepository(
      flavor: Flavor.production,
      marketId: marketId,
    );
    get();
  }

  final String? marketId;
  late final MarketTradesRepository marketTradeRepository;

  Future<void> get() async {
    try {
      final market = await marketTradeRepository.get();
      emit(MarketTradeLoaded(market));
    } catch (exception) {
      emit(MarketTradeLoadingError(exception.toString()));
    }
  }
}
