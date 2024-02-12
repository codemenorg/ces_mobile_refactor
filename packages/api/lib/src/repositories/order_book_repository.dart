import 'package:api/src/api.dart';
import 'package:api/src/models/order_book.dart';
import 'package:dio/dio.dart';

class OrderBoookRepository {
  OrderBoookRepository({
    required this.flavor,
  }) {
    _api = Api(flavor: flavor);
  }

  final Flavor flavor;
  late Api _api;

  Future<OrderBook> get() async {
    try {
      Response response =
          await _api.sendRequest.get("/exchange/listexchangeorders");
      return orderBookFromJson(response.toString());
    } catch (exception) {
      return Future.error(exception.toString());
    }
  }
}
