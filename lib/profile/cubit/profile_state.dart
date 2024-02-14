part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileLoading extends ProfileState {}

final class ProfileLoadingError extends ProfileState {
  ProfileLoadingError(this.error);

  final String error;
}

final class ProfileLoaded extends ProfileState {}
