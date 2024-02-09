class Market {
  String? iD;
  String? name;
  String? price;
  String? dailyChange;
  String? dailyHigh;
  String? dailyLow;
  String? baseVolume;
  String? quoteVolume;
  String? quoteIcon;
  String? createdAt;

  Market(
      {this.iD,
      this.name,
      this.price,
      this.dailyChange,
      this.dailyHigh,
      this.dailyLow,
      this.baseVolume,
      this.quoteVolume,
      this.quoteIcon,
      this.createdAt});

  Market.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['Name'];
    price = json['Price'];
    dailyChange = json['DailyChange'];
    dailyHigh = json['DailyHigh'];
    dailyLow = json['DailyLow'];
    baseVolume = json['BaseVolume'];
    quoteVolume = json['QuoteVolume'];
    quoteIcon = json['QuoteIcon'];
    createdAt = json['CreatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['Name'] = name;
    data['Price'] = price;
    data['DailyChange'] = dailyChange;
    data['DailyHigh'] = dailyHigh;
    data['DailyLow'] = dailyLow;
    data['BaseVolume'] = baseVolume;
    data['QuoteVolume'] = quoteVolume;
    data['QuoteIcon'] = quoteIcon;
    data['CreatedAt'] = createdAt;
    return data;
  }
}
