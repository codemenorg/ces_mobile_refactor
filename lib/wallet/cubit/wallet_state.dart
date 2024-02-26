part of 'wallet_cubit.dart';

@immutable
sealed class WalletState {}

final class WalletLoading extends WalletState {}

final class WalletLoadingError extends WalletState {
  WalletLoadingError(this.error);

  final String error;
}

final class WalletLoaded extends WalletState {}
