import 'package:api/src/api.dart';
import 'package:api/src/models/home.dart';
import 'package:dio/dio.dart';

class HomeRepository {
  HomeRepository({
    required this.flavor,
  }) {
    _api = Api(flavor: flavor);
  }

  final Flavor flavor;
  late Api _api;

  Future<Home> get() async {
    try {
      Response response = await _api.sendRequest.get("/trade-pair/market/list");
      return homeFromJson(response.toString());
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
