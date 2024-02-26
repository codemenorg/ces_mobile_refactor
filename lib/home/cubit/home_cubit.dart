import 'package:api/api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading()) {
    get();
  }

  HomeRepository homeRepository = HomeRepository(
    flavor: Flavor.production,
  );

  Future<void> get() async {
    try {
      final home = await homeRepository.get();
      emit(HomeLoaded(home));
    } catch (exception) {
      emit(HomeLoadingError(exception.toString()));
    }
  }
}
