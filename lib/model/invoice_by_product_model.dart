// To parse this JSON data, do
//
//     final invoicesByProductsModel = invoicesByProductsModelFromJson(jsonString);

import 'dart:convert';

InvoicesByProductsModel invoicesByProductsModelFromJson(String str) =>
    InvoicesByProductsModel.fromJson(json.decode(str));

String invoicesByProductsModelToJson(InvoicesByProductsModel data) =>
    json.encode(data.toJson());

class InvoicesByProductsModel {
  String? type;
  String? message;
  Bill? bill;

  InvoicesByProductsModel({
    this.type,
    this.message,
    this.bill,
  });

  factory InvoicesByProductsModel.fromJson(Map<String, dynamic> json) =>
      InvoicesByProductsModel(
        type: json["type"],
        message: json["message"],
        bill: json["bill"] == null ? null : Bill.fromJson(json["bill"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "bill": bill?.toJson(),
      };
}

class Bill {
  int? invoiceNumber;
  List<InvoiceItem>? items;
  int? subtotal;
  int? tax;
  int? taxPercentage;
  int? total;
  String? description;
  int? priceDiscount;

  Bill({
    this.invoiceNumber,
    this.items,
    this.subtotal,
    this.tax,
    this.taxPercentage,
    this.total,
    this.description,
    this.priceDiscount,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        invoiceNumber: json["invoiceNumber"],
        items: json["items"] == null
            ? []
            : List<InvoiceItem>.from(json["items"]!.map((x) => InvoiceItem.fromJson(x))),
        subtotal: json["subtotal"],
        tax: json["tax"],
        taxPercentage: json["tax_percentage"],
        total: json["total"],
        description: json["description"],
        priceDiscount: json["priceDiscount"],
      );

  Map<String, dynamic> toJson() => {
        "invoiceNumber": invoiceNumber,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "subtotal": subtotal,
        "tax": tax,
        "tax_percentage": taxPercentage,
        "total": total,
        "description": description,
        "priceDiscount": priceDiscount,
      };
}

class InvoiceItem {
  String? product;
  String? id;
  String? name;
  String? sku;
  InvoiceItemImage? mainImage;
  List<InvoiceItemImage>? images;
  int? price;
  int? priceDiscount;
  int? quantity;
  int? unitPrice;
  int? realPrice;
  int? totalPrice;
  int? availableQuantity;

  InvoiceItem({
    this.product,
    this.id,
    this.name,
    this.sku,
    this.mainImage,
    this.images,
    this.price,
    this.priceDiscount,
    this.quantity,
    this.unitPrice,
    this.realPrice,
    this.totalPrice,
    this.availableQuantity,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) => InvoiceItem(
        product: json["product"],
        id: json["_id"],
        name: json["name"],
        sku: json["sku"],
        mainImage: json["mainImage"] == null
            ? null
            : InvoiceItemImage.fromJson(json["mainImage"]),
        images: json["images"] == null
            ? []
            : List<InvoiceItemImage>.from(json["images"]!.map((x) => InvoiceItemImage.fromJson(x))),
        price: json["price"],
        priceDiscount: json["priceDiscount"],
        quantity: json["quantity"],
        unitPrice: json["unitPrice"],
        realPrice: json["realPrice"],
        totalPrice: json["totalPrice"],
        availableQuantity: json["availableQuantity"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "_id": id,
        "name": name,
        "sku": sku,
        "mainImage": mainImage?.toJson(),
        "images": images == null
            ? []
            : List<dynamic>.from(images!.map((x) => x.toJson())),
        "price": price,
        "priceDiscount": priceDiscount,
        "quantity": quantity,
        "unitPrice": unitPrice,
        "realPrice": realPrice,
        "totalPrice": totalPrice,
        "availableQuantity": availableQuantity,
      };
}

class InvoiceItemImage {
  String? original;
  String? web;
  String? mobile;
  String? id;

  InvoiceItemImage({
    this.original,
    this.web,
    this.mobile,
    this.id,
  });

  factory InvoiceItemImage.fromJson(Map<String, dynamic> json) => InvoiceItemImage(
        original: json["original"],
        web: json["web"],
        mobile: json["mobile"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "original": original,
        "web": web,
        "mobile": mobile,
        "_id": id,
      };
}
