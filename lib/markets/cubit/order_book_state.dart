part of 'order_book_cubit.dart';

sealed class OrderBookState {}

final class OrderBookLoading extends OrderBookState {}

final class OrderBookLoadingError extends OrderBookState {
  OrderBookLoadingError(this.error);

  final String error;
}

final class OrderBookLoaded extends OrderBookState {
  OrderBookLoaded(this.orderBook);

  final OrderBook orderBook;
}
