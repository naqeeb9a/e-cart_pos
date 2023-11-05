// To parse this JSON data, do
//
//     final invoiceByNumberModel = invoiceByNumberModelFromJson(jsonString);

import 'dart:convert';

InvoiceByNumberModel invoiceByNumberModelFromJson(String str) =>
    InvoiceByNumberModel.fromJson(json.decode(str));

String invoiceByNumberModelToJson(InvoiceByNumberModel data) =>
    json.encode(data.toJson());

class InvoiceByNumberModel {
  String? type;
  String? message;
  Bill? bill;

  InvoiceByNumberModel({
    this.type,
    this.message,
    this.bill,
  });

  factory InvoiceByNumberModel.fromJson(Map<String, dynamic> json) =>
      InvoiceByNumberModel(
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
  String? id;
  int? invoiceNumber;
  List<InvoiceItem>? items;
  int? subtotal;
  int? tax;
  int? taxPercentage;
  int? total;
  int? priceDiscount;
  String? status;
  String? description;
  String? billId;

  Bill({
    this.id,
    this.invoiceNumber,
    this.items,
    this.subtotal,
    this.tax,
    this.taxPercentage,
    this.total,
    this.priceDiscount,
    this.status,
    this.description,
    this.billId,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        id: json["_id"],
        invoiceNumber: json["invoiceNumber"],
        items: json["items"] == null
            ? []
            : List<InvoiceItem>.from(json["items"]!.map((x) => InvoiceItem.fromJson(x))),
        subtotal: json["subtotal"],
        tax: json["tax"],
        taxPercentage: json["tax_percentage"],
        total: json["total"],
        priceDiscount: json["priceDiscount"],
        status: json["status"],
        description: json["description"],
        billId: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "invoiceNumber": invoiceNumber,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "subtotal": subtotal,
        "tax": tax,
        "tax_percentage": taxPercentage,
        "total": total,
        "priceDiscount": priceDiscount,
        "status": status,
        "description": description,
        "id": billId,
      };
}

class InvoiceItem {
  String? product;
  int? quantity;
  int? unitPrice;
  int? priceDiscount;
  int? realPrice;
  int? totalPrice;
  String? id;

  InvoiceItem({
    this.product,
    this.quantity,
    this.unitPrice,
    this.priceDiscount,
    this.realPrice,
    this.totalPrice,
    this.id,
  });

  factory InvoiceItem.fromJson(Map<String, dynamic> json) => InvoiceItem(
        product: json["product"],
        quantity: json["quantity"],
        unitPrice: json["unitPrice"],
        priceDiscount: json["priceDiscount"],
        realPrice: json["realPrice"],
        totalPrice: json["totalPrice"],
        id: json["_id"],
      );

  Map<String, dynamic> toJson() => {
        "product": product,
        "quantity": quantity,
        "unitPrice": unitPrice,
        "priceDiscount": priceDiscount,
        "realPrice": realPrice,
        "totalPrice": totalPrice,
        "_id": id,
      };
}
