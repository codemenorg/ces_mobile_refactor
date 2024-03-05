// To parse this JSON data, do
//
//     final marketTrades = marketTradesFromJson(jsonString);

import 'dart:convert';

MarketTrades marketTradesFromJson(String str) =>
    MarketTrades.fromJson(json.decode(str));

String marketTradesToJson(MarketTrades data) => json.encode(data.toJson());

class MarketTrades {
  MarketTradeData? data;
  String? marketId;

  MarketTrades({
    this.data,
    this.marketId,
  });

  factory MarketTrades.fromJson(Map<String, dynamic> json) => MarketTrades(
        data: json["Data"] == null
            ? null
            : MarketTradeData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class MarketTradeData {
  List<MarketTrade>? marketTrades;

  MarketTradeData({
    this.marketTrades,
  });

  factory MarketTradeData.fromJson(Map<String, dynamic> json) =>
      MarketTradeData(
        marketTrades: json["MarketTrades"] == null
            ? []
            : List<MarketTrade>.from(
                json["MarketTrades"]!.map((x) => MarketTrade.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "MarketTrades": marketTrades == null
            ? []
            : List<dynamic>.from(marketTrades!.map((x) => x.toJson())),
      };
}

class MarketTrade {
  String? id;
  String? price;
  String? amount;
  String? totalPrice;
  bool? isMakerSeller;
  DateTime? date;

  MarketTrade({
    this.id,
    this.price,
    this.amount,
    this.totalPrice,
    this.isMakerSeller,
    this.date,
  });

  factory MarketTrade.fromJson(Map<String, dynamic> json) => MarketTrade(
        id: json["ID"],
        price: json["Price"],
        amount: json["Amount"],
        totalPrice: json["TotalPrice"],
        isMakerSeller: json["IsMakerSeller"],
        date: json["Date"] == null ? null : DateTime.parse(json["Date"]),
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Price": price,
        "Amount": amount,
        "TotalPrice": totalPrice,
        "IsMakerSeller": isMakerSeller,
        "Date": date?.toIso8601String(),
      };
}
