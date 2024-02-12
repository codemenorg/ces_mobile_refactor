import 'package:api/src/api.dart';
import 'package:api/src/models/market_trades.dart';
import 'package:dio/dio.dart';

class MarketTradesRepository {
  MarketTradesRepository({required this.flavor, this.marketId}) {
    _api = Api(flavor: flavor);
  }

  final Flavor flavor;
  late Api _api;
  String? marketId;

  Future<MarketTrades> get() async {
    try {
      Response response = await _api.sendRequest
          .get("/exchange/marketTrades/list?ID=$marketId");
      return marketTradesFromJson(response.toString());
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
