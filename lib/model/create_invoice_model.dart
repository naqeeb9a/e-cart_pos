// To parse this JSON data, do
//
//     final createInvoiceModel = createInvoiceModelFromJson(jsonString);

import 'dart:convert';

CreateInvoiceModel createInvoiceModelFromJson(String str) => CreateInvoiceModel.fromJson(json.decode(str));

String createInvoiceModelToJson(CreateInvoiceModel data) => json.encode(data.toJson());

class CreateInvoiceModel {
    String? type;
    String? message;
    Bill? bill;

    CreateInvoiceModel({
        this.type,
        this.message,
        this.bill,
    });

    factory CreateInvoiceModel.fromJson(Map<String, dynamic> json) => CreateInvoiceModel(
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
    List<Item>? items;
    int? subtotal;
    int? tax;
    int? taxPercentage;
    int? total;
    int? priceDiscount;
    String? status;
    String? description;
    String? id;
    String? billId;

    Bill({
        this.invoiceNumber,
        this.items,
        this.subtotal,
        this.tax,
        this.taxPercentage,
        this.total,
        this.priceDiscount,
        this.status,
        this.description,
        this.id,
        this.billId,
    });

    factory Bill.fromJson(Map<String, dynamic> json) => Bill(
        invoiceNumber: json["invoiceNumber"],
        items: json["items"] == null ? [] : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
        subtotal: json["subtotal"],
        tax: json["tax"],
        taxPercentage: json["tax_percentage"],
        total: json["total"],
        priceDiscount: json["priceDiscount"],
        status: json["status"],
        description: json["description"],
        id: json["_id"],
        billId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "invoiceNumber": invoiceNumber,
        "items": items == null ? [] : List<dynamic>.from(items!.map((x) => x.toJson())),
        "subtotal": subtotal,
        "tax": tax,
        "tax_percentage": taxPercentage,
        "total": total,
        "priceDiscount": priceDiscount,
        "status": status,
        "description": description,
        "_id": id,
        "id": billId,
    };
}

class Item {
    String? product;
    int? quantity;
    int? unitPrice;
    int? priceDiscount;
    int? realPrice;
    int? totalPrice;
    String? id;

    Item({
        this.product,
        this.quantity,
        this.unitPrice,
        this.priceDiscount,
        this.realPrice,
        this.totalPrice,
        this.id,
    });

    factory Item.fromJson(Map<String, dynamic> json) => Item(
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
