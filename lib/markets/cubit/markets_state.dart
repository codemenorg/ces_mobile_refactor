part of 'markets_cubit.dart';

@immutable
sealed class MarketsState {}

final class MarketsLoading extends MarketsState {}

final class MarketsLoadingError extends MarketsState {
  MarketsLoadingError({required this.error});
  
  final String error;
}

final class MarketsLoaded extends MarketsState {
  MarketsLoaded({required this.markets});

  final List<Market> markets;
}
