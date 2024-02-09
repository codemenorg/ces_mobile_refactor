import 'package:api/api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'markets_state.dart';

class MarketsCubit extends Cubit<MarketsState> {
  MarketsCubit() : super(MarketsLoading()){
    fetch();
  }

  MarketsRepository repository = MarketsRepository();

  Future<void> fetch() async {
    try {
      final List<Market> markets = await repository.get();
      emit(MarketsLoaded(markets: markets));
    } catch (ex) {
      emit(MarketsLoadingError(error: ex.toString()));
      print(ex.toString());
    }
  }
}
