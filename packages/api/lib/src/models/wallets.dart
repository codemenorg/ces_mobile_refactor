// To parse this JSON data, do
//
//     final walletList = walletListFromJson(jsonString);

import 'dart:convert';

WalletList walletListFromJson(String str) =>
    WalletList.fromJson(json.decode(str));

String walletListToJson(WalletList data) => json.encode(data.toJson());

class WalletList {
  Data? data;

  WalletList({
    this.data,
  });

  factory WalletList.fromJson(Map<String, dynamic> json) => WalletList(
        data: json["Data"] == null ? null : Data.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class Data {
  List<WalletElement>? wallet;

  Data({
    this.wallet,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        wallet: json["Wallet"] == null
            ? []
            : List<WalletElement>.from(
                json["Wallet"]!.map((x) => WalletElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "Wallet": wallet == null
            ? []
            : List<dynamic>.from(wallet!.map((x) => x.toJson())),
      };
}

class WalletElement {
  WalletWallet? wallet;

  WalletElement({
    this.wallet,
  });

  factory WalletElement.fromJson(Map<String, dynamic> json) => WalletElement(
        wallet: json["Wallet"] == null
            ? null
            : WalletWallet.fromJson(json["Wallet"]),
      );

  Map<String, dynamic> toJson() => {
        "Wallet": wallet?.toJson(),
      };
}

class WalletWallet {
  String? id;
  String? userId;
  String? name;
  String? currencyId;
  String? currencySymbol;
  String? icon;
  double? balance;
  String? isDefault;
  String? isActive;
  String? isSystem;
  DateTime? lastDeposit;
  DateTime? lastWithdrawal;
  DateTime? createdAt;
  String? createdBy;
  DateTime? updatedAt;
  String? updatedBy;
  UserInfo? userInfo;
  String? currencyName;
  int? onOrder;
  String? address;
  String? currencyType;
  List<dynamic>? paymentMethods;
  String? currencyActiveStatus;
  String? currencyDepositStatus;
  String? currencyWithdrawalStatus;
  String? currencyIcon;

  WalletWallet({
    this.id,
    this.userId,
    this.name,
    this.currencyId,
    this.currencySymbol,
    this.icon,
    this.balance,
    this.isDefault,
    this.isActive,
    this.isSystem,
    this.lastDeposit,
    this.lastWithdrawal,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.userInfo,
    this.currencyName,
    this.onOrder,
    this.address,
    this.currencyType,
    this.paymentMethods,
    this.currencyActiveStatus,
    this.currencyDepositStatus,
    this.currencyWithdrawalStatus,
    this.currencyIcon,
  });

  factory WalletWallet.fromJson(Map<String, dynamic> json) => WalletWallet(
        id: json["ID"],
        userId: json["UserID"],
        name: json["Name"],
        currencyId: json["CurrencyID"],
        currencySymbol: json["CurrencySymbol"],
        icon: json["Icon"],
        balance: json["Balance"]?.toDouble(),
        isDefault: json["IsDefault"],
        isActive: json["IsActive"],
        isSystem: json["IsSystem"],
        lastDeposit: json["LastDeposit"] == null
            ? null
            : DateTime.parse(json["LastDeposit"]),
        lastWithdrawal: json["LastWithdrawal"] == null
            ? null
            : DateTime.parse(json["LastWithdrawal"]),
        createdAt: json["CreatedAt"] == null
            ? null
            : DateTime.parse(json["CreatedAt"]),
        createdBy: json["CreatedBy"],
        updatedAt: json["UpdatedAt"] == null
            ? null
            : DateTime.parse(json["UpdatedAt"]),
        updatedBy: json["UpdatedBy"],
        userInfo: json["UserInfo"] == null
            ? null
            : UserInfo.fromJson(json["UserInfo"]),
        currencyName: json["CurrencyName"],
        onOrder: json["OnOrder"],
        address: json["Address"],
        currencyType: json["CurrencyType"],
        paymentMethods: json["PaymentMethods"] == null
            ? []
            : List<dynamic>.from(json["PaymentMethods"]!.map((x) => x)),
        currencyActiveStatus: json["CurrencyActiveStatus"],
        currencyDepositStatus: json["CurrencyDepositStatus"],
        currencyWithdrawalStatus: json["CurrencyWithdrawalStatus"],
        currencyIcon: json["CurrencyIcon"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "UserID": userId,
        "Name": name,
        "CurrencyID": currencyId,
        "CurrencySymbol": currencySymbol,
        "Icon": icon,
        "Balance": balance,
        "IsDefault": isDefault,
        "IsActive": isActive,
        "IsSystem": isSystem,
        "LastDeposit": lastDeposit?.toIso8601String(),
        "LastWithdrawal": lastWithdrawal?.toIso8601String(),
        "CreatedAt": createdAt?.toIso8601String(),
        "CreatedBy": createdBy,
        "UpdatedAt": updatedAt?.toIso8601String(),
        "UpdatedBy": updatedBy,
        "UserInfo": userInfo?.toJson(),
        "CurrencyName": currencyName,
        "OnOrder": onOrder,
        "Address": address,
        "CurrencyType": currencyType,
        "PaymentMethods": paymentMethods == null
            ? []
            : List<dynamic>.from(paymentMethods!.map((x) => x)),
        "CurrencyActiveStatus": currencyActiveStatus,
        "CurrencyDepositStatus": currencyDepositStatus,
        "CurrencyWithdrawalStatus": currencyWithdrawalStatus,
        "CurrencyIcon": currencyIcon,
      };
}

class UserInfo {
  String? firstName;
  String? lastName;

  UserInfo({
    this.firstName,
    this.lastName,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        firstName: json["FirstName"],
        lastName: json["LastName"],
      );

  Map<String, dynamic> toJson() => {
        "FirstName": firstName,
        "LastName": lastName,
      };
}
