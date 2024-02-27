import 'package:api/src/api.dart';
import 'package:api/src/models/wallets.dart';
import 'package:dio/dio.dart';

class WalletsRepository {
  WalletsRepository({
    required this.flavor,
  }) {
    _api = Api(flavor: flavor);
  }

  final Flavor flavor;
  late Api _api;

  Future<WalletList> get() async {
    try {
      Response response = await _api.sendRequest.get("/wallet/user/list");
      return walletListFromJson(response.toString());
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
