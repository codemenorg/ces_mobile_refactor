// To parse this JSON data, do
//
//     final profile = profileFromJson(jsonString);

import 'dart:convert';

Profile profileFromJson(String str) => Profile.fromJson(json.decode(str));

String profileToJson(Profile data) => json.encode(data.toJson());

class Profile {
  ProfileData? data;

  Profile({
    this.data,
  });

  factory Profile.fromJson(Map<String, dynamic> json) => Profile(
        data: json["Data"] == null ? null : ProfileData.fromJson(json["Data"]),
      );

  Map<String, dynamic> toJson() => {
        "Data": data?.toJson(),
      };
}

class ProfileData {
  GetProfileById? getProfileById;

  ProfileData({
    this.getProfileById,
  });

  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        getProfileById: json["GetProfileByID"] == null
            ? null
            : GetProfileById.fromJson(json["GetProfileByID"]),
      );

  Map<String, dynamic> toJson() => {
        "GetProfileByID": getProfileById?.toJson(),
      };
}

class GetProfileById {
  String? id;
  String? email;
  String? phoneNo;
  String? dateOfBirth;
  String? country;
  String? city;
  String? status;
  String? streetAddress;
  String? istwofa;
  String? firstName;
  String? lastName;
  String? isMfa;
  String? mfaType;
  String? kycLevel;
  String? isPhoneVerified;
  String? isEmailVerified;
  String? image;

  GetProfileById({
    this.id,
    this.email,
    this.phoneNo,
    this.dateOfBirth,
    this.country,
    this.city,
    this.status,
    this.streetAddress,
    this.istwofa,
    this.firstName,
    this.lastName,
    this.isMfa,
    this.mfaType,
    this.kycLevel,
    this.isPhoneVerified,
    this.isEmailVerified,
    this.image,
  });

  factory GetProfileById.fromJson(Map<String, dynamic> json) => GetProfileById(
        id: json["ID"],
        email: json["Email"],
        phoneNo: json["PhoneNo"],
        dateOfBirth: json["DateOfBirth"],
        country: json["Country"],
        city: json["City"],
        status: json["Status"],
        streetAddress: json["StreetAddress"],
        istwofa: json["Istwofa"],
        firstName: json["FirstName"],
        lastName: json["LastName"],
        isMfa: json["IsMfa"],
        mfaType: json["MfaType"],
        kycLevel: json["KYCLevel"],
        isPhoneVerified: json["IsPhoneVerified"],
        isEmailVerified: json["IsEmailVerified"],
        image: json["Image"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Email": email,
        "PhoneNo": phoneNo,
        "DateOfBirth": dateOfBirth,
        "Country": country,
        "City": city,
        "Status": status,
        "StreetAddress": streetAddress,
        "Istwofa": istwofa,
        "FirstName": firstName,
        "LastName": lastName,
        "IsMfa": isMfa,
        "MfaType": mfaType,
        "KYCLevel": kycLevel,
        "IsPhoneVerified": isPhoneVerified,
        "IsEmailVerified": isEmailVerified,
        "Image": image,
      };
}
