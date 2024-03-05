import 'package:api/api.dart';
import 'package:bloc/bloc.dart';

part 'order_book_state.dart';

class OrderBookCubit extends Cubit<OrderBookState> {
  OrderBookCubit() : super(OrderBookLoading()) {
    get();
  }

  OrderBoookRepository orderBoookRepository = OrderBoookRepository(
    flavor: Flavor.production,
  );

  Future<void> get() async {
    try {
      final orderBook = await orderBoookRepository.get();
      emit(OrderBookLoaded(orderBook));
    } catch (exception) {
      emit(OrderBookLoadingError(exception.toString()));
    }
  }
}
