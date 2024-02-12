// To parse this JSON data, do
//
//     final orderBook = orderBookFromJson(jsonString);

import 'dart:convert';

OrderBook orderBookFromJson(String str) => OrderBook.fromJson(json.decode(str));

String orderBookToJson(OrderBook data) => json.encode(data.toJson());

class OrderBook {
  OrderBookData data;

  OrderBook({
    required this.data,
  });

  factory OrderBook.fromJson(Map<String, dynamic> json) => OrderBook(
        data: OrderBookData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data.toJson(),
      };
}

class OrderBookData {
  List<ListExchangeOrder> listExchangeOrders;

  OrderBookData({
    required this.listExchangeOrders,
  });

  factory OrderBookData.fromJson(Map<String, dynamic> json) => OrderBookData(
        listExchangeOrders: List<ListExchangeOrder>.from(
            json["ListExchangeOrders"]
                .map((x) => ListExchangeOrder.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ListExchangeOrders":
            List<dynamic>.from(listExchangeOrders.map((x) => x.toJson())),
      };
}

class ListExchangeOrder {
  String id;
  String price;
  String quantity;
  String total;
  Type type;

  ListExchangeOrder({
    required this.id,
    required this.price,
    required this.quantity,
    required this.total,
    required this.type,
  });

  factory ListExchangeOrder.fromJson(Map<String, dynamic> json) =>
      ListExchangeOrder(
        id: json["ID"],
        price: json["Price"],
        quantity: json["Quantity"],
        total: json["Total"],
        type: typeValues.map[json["Type"]]!,
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Price": price,
        "Quantity": quantity,
        "Total": total,
        "Type": typeValues.reverse[type],
      };
}

enum Type { TYPE_UNKNOWN }

final typeValues = EnumValues({"TYPE_UNKNOWN": Type.TYPE_UNKNOWN});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
