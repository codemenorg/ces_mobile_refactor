import 'package:api/api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeLoading());

  MarketsRepository marketRepository = MarketsRepository(
    flavor: Flavor.production,
  );
}
