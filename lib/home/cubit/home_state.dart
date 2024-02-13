part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoadingError extends HomeState {
  HomeLoadingError(this.error);

  final String error;
}

final class HomeLoaded extends HomeState {}
