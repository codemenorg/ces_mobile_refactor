// To parse this JSON data, do
//
//     final market = marketFromJson(jsonString);

import 'dart:convert';

Home homeFromJson(String str) => Home.fromJson(json.decode(str));

String homeToJson(Home data) => json.encode(data.toJson());

class Home {
  List<Datums> data;

  Home({
    required this.data,
  });

  factory Home.fromJson(Map<String, dynamic> json) => Home(
        data: List<Datums>.from(json["Data"].map((x) => Datums.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datums {
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

  Datums({
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

  factory Datums.fromJson(Map<String, dynamic> json) => Datums(
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
