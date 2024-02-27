import 'package:api/api.dart';
import 'package:bloc/bloc.dart';

part 'wallets_state.dart';

class WalletsCubit extends Cubit<WalletsState> {
  WalletsCubit() : super(WalletsLoading()) {
    get();
  }

  WalletsRepository walletsRepository = WalletsRepository(
    flavor: Flavor.production,
  );

  Future<void> get() async {
    try {
      final wallet = await walletsRepository.get();
      emit(WalletsLoaded(wallet));
    } catch (exception) {
      emit(WalletsLoadingError(exception.toString()));
    }
  }
}
