// To parse this JSON data, do
//
//     final addIncomingStockModel = addIncomingStockModelFromJson(jsonString);

import 'dart:convert';

AddIncomingStockModel addIncomingStockModelFromJson(String str) =>
    AddIncomingStockModel.fromJson(json.decode(str));

String addIncomingStockModelToJson(AddIncomingStockModel data) =>
    json.encode(data.toJson());

class AddIncomingStockModel {
  String? type;
  String? message;
  List<ProductsArray>? productsArray;

  AddIncomingStockModel({
    this.type,
    this.message,
    this.productsArray,
  });

  factory AddIncomingStockModel.fromJson(Map<String, dynamic> json) =>
      AddIncomingStockModel(
        type: json["type"],
        message: json["message"],
        productsArray: json["productsArray"] == null
            ? []
            : List<ProductsArray>.from(
                json["productsArray"]!.map((x) => ProductsArray.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "productsArray": productsArray == null
            ? []
            : List<dynamic>.from(productsArray!.map((x) => x.toJson())),
      };
}

class ProductsArray {
  String? id;
  String? name;
  String? sku;
  int? quantity;
  String? productsArrayId;

  ProductsArray({
    this.id,
    this.name,
    this.sku,
    this.quantity,
    this.productsArrayId,
  });

  factory ProductsArray.fromJson(Map<String, dynamic> json) => ProductsArray(
        id: json["_id"],
        name: json["name"],
        sku: json["sku"],
        quantity: json["quantity"],
        productsArrayId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "sku": sku,
        "quantity": quantity,
        "id": productsArrayId,
      };
}
