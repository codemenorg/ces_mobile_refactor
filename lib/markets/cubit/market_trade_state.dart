part of 'market_trade_cubit.dart';

sealed class MarketTradeState {}

final class MarketTradeLoading extends MarketTradeState {}

final class MarketTradeLoadingError extends MarketTradeState {
  MarketTradeLoadingError(this.error);

  final String error;
}

final class MarketTradeLoaded extends MarketTradeState {
  MarketTradeLoaded(this.marketDetail);

  final MarketTrades marketDetail;
}
