import 'package:api/src/api.dart';
import 'package:api/src/models/market.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class MarketsRepository {
  final Api _api = Api(flavor: Flavor.developmenmt);

  Future<List<Market>> get() async {
    try {
      Response response = await _api.sendRequest.get("/trade-pair/market/list");
      if (response.statusCode! <= 200) {
        return compute(_parse, response.data);
      } else {
        throw Exception('Failed to load posts.');
      }
    } catch (ex) {
      rethrow;
    }
  }

  static List<Market> _parse(dynamic responseBody) {
    List<dynamic> maps = responseBody;

    return maps.map<Market>((json) => Market.fromJson(json)).toList();
  }
}
