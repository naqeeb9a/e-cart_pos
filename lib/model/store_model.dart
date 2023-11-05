// To parse this JSON data, do
//
//     final storeModel = storeModelFromJson(jsonString);

import 'dart:convert';

StoreModel storeModelFromJson(String str) =>
    StoreModel.fromJson(json.decode(str));

String storeModelToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
  String? type;
  String? message;
  Stores? stores;

  StoreModel({
    this.type,
    this.message,
    this.stores,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
        type: json["type"],
        message: json["message"],
        stores: json["stores"] == null ? null : Stores.fromJson(json["stores"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "stores": stores?.toJson(),
      };
}

class Stores {
  List<StoreDatum>? data;
  int? currentPage;
  int? totoalPage;
  int? totalDocs;

  Stores({
    this.data,
    this.currentPage,
    this.totoalPage,
    this.totalDocs,
  });

  factory Stores.fromJson(Map<String, dynamic> json) => Stores(
        data: json["data"] == null
            ? []
            : List<StoreDatum>.from(json["data"]!.map((x) => StoreDatum.fromJson(x))),
        currentPage: json["currentPage"],
        totoalPage: json["totoalPage"],
        totalDocs: json["totalDocs"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "currentPage": currentPage,
        "totoalPage": totoalPage,
        "totalDocs": totalDocs,
      };
}

class StoreDatum {
  String? id;
  String? seller;
  List<dynamic>? product;
  String? name;
  String? city;
  String? state;
  String? zipCode;
  String? latitude;
  String? longitude;
  String? address;

  StoreDatum({
    this.id,
    this.seller,
    this.product,
    this.name,
    this.city,
    this.state,
    this.zipCode,
    this.latitude,
    this.longitude,
    this.address,
  });

  factory StoreDatum.fromJson(Map<String, dynamic> json) => StoreDatum(
        id: json["_id"],
        seller: json["seller"],
        product: json["product"] == null
            ? []
            : List<dynamic>.from(json["product"]!.map((x) => x)),
        name: json["name"],
        city: json["city"],
        state: json["state"],
        zipCode: json["zipCode"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "seller": seller,
        "product":
            product == null ? [] : List<dynamic>.from(product!.map((x) => x)),
        "name": name,
        "city": city,
        "state": state,
        "zipCode": zipCode,
        "latitude": latitude,
        "longitude": longitude,
        "address": address,
      };
}
