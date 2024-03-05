part of 'trade_cubit.dart';

@immutable
sealed class TradeState {}

final class TradeLoading extends TradeState {}

final class TradeLoadingError extends TradeState {
  TradeLoadingError(this.error);

  final String error;
}

final class TradeLoaded extends TradeState {
  // TradeLoaded(this.home);

  // final Home home;
}
