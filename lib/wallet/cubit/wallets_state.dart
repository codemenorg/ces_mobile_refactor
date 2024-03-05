part of 'wallets_cubit.dart';

sealed class WalletsState {}

final class WalletsLoading extends WalletsState {}

final class WalletsLoadingError extends WalletsState {
  WalletsLoadingError(this.error);

  final String error;
}

final class WalletsLoaded extends WalletsState {
  WalletsLoaded(this.walletList);

  final WalletList walletList;
}
