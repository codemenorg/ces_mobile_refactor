import 'package:api/src/api.dart';
import 'package:api/src/models/market.dart';
import 'package:dio/dio.dart';

class MarketsRepository {
  MarketsRepository({
    required this.flavor,
  }) {
    _api = Api(flavor: flavor);
  }

  final Flavor flavor;
  late Api _api;

  Future<Market> get() async {
    try {
      Response response = await _api.sendRequest.get("/trade-pair/market/list");
      return marketFromJson(response.toString());
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
