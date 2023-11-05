// To parse this JSON data, do
//
//     final addOutgoingStockModel = addOutgoingStockModelFromJson(jsonString);

import 'dart:convert';

AddOutgoingStockModel addOutgoingStockModelFromJson(String str) => AddOutgoingStockModel.fromJson(json.decode(str));

String addOutgoingStockModelToJson(AddOutgoingStockModel data) => json.encode(data.toJson());

class AddOutgoingStockModel {
    String? type;
    String? message;
    List<Result>? result;

    AddOutgoingStockModel({
        this.type,
        this.message,
        this.result,
    });

    factory AddOutgoingStockModel.fromJson(Map<String, dynamic> json) => AddOutgoingStockModel(
        type: json["type"],
        message: json["message"],
        result: json["result"] == null ? [] : List<Result>.from(json["result"]!.map((x) => Result.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "message": message,
        "result": result == null ? [] : List<dynamic>.from(result!.map((x) => x.toJson())),
    };
}

class Result {
    String? id;
    String? name;
    String? sku;
    Image? mainImage;
    List<Image>? images;
    String? description;
    String? shortDescription;
    String? unitType;
    String? unitValue;
    List<String>? tags;
    String? sellerInfo;
    int? price;
    int? priceAfterDiscount;
    int? priceDiscount;
    List<String>? colors;
    List<String>? sizes;
    List<String>? stores;
    int? quantity;
    int? sold;
    bool? isOutOfStock;
    bool? isFeatured;
    double? ratingsAverage;
    int? ratingsQuantity;
    List<dynamic>? attributes;
    String? slug;
    String? resultId;

    Result({
        this.id,
        this.name,
        this.sku,
        this.mainImage,
        this.images,
        this.description,
        this.shortDescription,
        this.unitType,
        this.unitValue,
        this.tags,
        this.sellerInfo,
        this.price,
        this.priceAfterDiscount,
        this.priceDiscount,
        this.colors,
        this.sizes,
        this.stores,
        this.quantity,
        this.sold,
        this.isOutOfStock,
        this.isFeatured,
        this.ratingsAverage,
        this.ratingsQuantity,
        this.attributes,
        this.slug,
        this.resultId,
    });

    factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["_id"],
        name: json["name"],
        sku: json["sku"],
        mainImage: json["mainImage"] == null ? null : Image.fromJson(json["mainImage"]),
        images: json["images"] == null ? [] : List<Image>.from(json["images"]!.map((x) => Image.fromJson(x))),
        description: json["description"],
        shortDescription: json["shortDescription"],
        unitType: json["unitType"],
        unitValue: json["unitValue"],
        tags: json["tags"] == null ? [] : List<String>.from(json["tags"]!.map((x) => x)),
        sellerInfo: json["sellerInfo"],
        price: json["price"],
        priceAfterDiscount: json["priceAfterDiscount"],
        priceDiscount: json["priceDiscount"],
        colors: json["colors"] == null ? [] : List<String>.from(json["colors"]!.map((x) => x)),
        sizes: json["sizes"] == null ? [] : List<String>.from(json["sizes"]!.map((x) => x)),
        stores: json["stores"] == null ? [] : List<String>.from(json["stores"]!.map((x) => x)),
        quantity: json["quantity"],
        sold: json["sold"],
        isOutOfStock: json["isOutOfStock"],
        isFeatured: json["isFeatured"],
        ratingsAverage: json["ratingsAverage"]?.toDouble(),
        ratingsQuantity: json["ratingsQuantity"],
        attributes: json["attributes"] == null ? [] : List<dynamic>.from(json["attributes"]!.map((x) => x)),
        slug: json["slug"],
        resultId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "sku": sku,
        "mainImage": mainImage?.toJson(),
        "images": images == null ? [] : List<dynamic>.from(images!.map((x) => x.toJson())),
        "description": description,
        "shortDescription": shortDescription,
        "unitType": unitType,
        "unitValue": unitValue,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
        "sellerInfo": sellerInfo,
        "price": price,
        "priceAfterDiscount": priceAfterDiscount,
        "priceDiscount": priceDiscount,
        "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
        "sizes": sizes == null ? [] : List<dynamic>.from(sizes!.map((x) => x)),
        "stores": stores == null ? [] : List<dynamic>.from(stores!.map((x) => x)),
        "quantity": quantity,
        "sold": sold,
        "isOutOfStock": isOutOfStock,
        "isFeatured": isFeatured,
        "ratingsAverage": ratingsAverage,
        "ratingsQuantity": ratingsQuantity,
        "attributes": attributes == null ? [] : List<dynamic>.from(attributes!.map((x) => x)),
        "slug": slug,
        "id": resultId,
    };
}

class Image {
    String? original;
    String? web;
    String? mobile;
    String? id;

    Image({
        this.original,
        this.web,
        this.mobile,
        this.id,
    });

    factory Image.fromJson(Map<String, dynamic> json) => Image(
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
