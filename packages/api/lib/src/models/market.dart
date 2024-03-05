// To parse this JSON data, do
//
//     final market = marketFromJson(jsonString);

import 'dart:convert';

Market marketFromJson(String str) => Market.fromJson(json.decode(str));

String marketToJson(Market data) => json.encode(data.toJson());

class Market {
  List<Datum> data;

  Market({
    required this.data,
  });

  factory Market.fromJson(Map<String, dynamic> json) => Market(
        data: List<Datum>.from(json["Data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  String id;
  String name;
  String price;
  String dailyChange;
  String dailyHigh;
  String dailyLow;
  String baseVolume;
  String quoteVolume;
  String quoteIcon;
  DateTime createdAt;

  Datum({
    required this.id,
    required this.name,
    required this.price,
    required this.dailyChange,
    required this.dailyHigh,
    required this.dailyLow,
    required this.baseVolume,
    required this.quoteVolume,
    required this.quoteIcon,
    required this.createdAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["ID"],
    name: json["Name"],
    price: json["Price"],
    dailyChange: json["DailyChange"],
    dailyHigh: json["DailyHigh"],
    dailyLow: json["DailyLow"],
    baseVolume: json["BaseVolume"],
    quoteVolume: json["QuoteVolume"],
    quoteIcon: json["QuoteIcon"],
    createdAt: DateTime.parse(json["CreatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "ID": id,
    "Name": name,
    "Price": price,
    "DailyChange": dailyChange,
    "DailyHigh": dailyHigh,
    "DailyLow": dailyLow,
    "BaseVolume": baseVolume,
    "QuoteVolume": quoteVolume,
    "QuoteIcon": quoteIcon,
    "CreatedAt": createdAt.toIso8601String(),
  };
}
