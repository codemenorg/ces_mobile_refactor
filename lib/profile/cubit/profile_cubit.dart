import 'package:api/api.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileLoading()) {
    get();
  }

  ProfileRepository profileRepository = ProfileRepository(
    flavor: Flavor.production,
  );

  Future<void> get() async {
    try {
      final profile = await profileRepository.get();
      emit(ProfileLoaded(profile));
    } catch (exception) {
      emit(ProfileLoadingError(exception.toString()));
    }
  }
}
