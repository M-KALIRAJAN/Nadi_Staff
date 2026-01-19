

import 'dart:convert';

OurSpareParts ourSparePartsFromJson(String str) => OurSpareParts.fromJson(json.decode(str));

String ourSparePartsToJson(OurSpareParts data) => json.encode(data.toJson());

class OurSpareParts {
    bool success;
    List<Datum> data;

    OurSpareParts({
        required this.success,
        required this.data,
    });

    factory OurSpareParts.fromJson(Map<String, dynamic> json) => OurSpareParts(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String technicianId;
    ProductId productId;
    String count;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
        required this.technicianId,
        required this.productId,
        required this.count,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        technicianId: json["technicianId"],
        productId: ProductId.fromJson(json["productId"]),
        count: json["count"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "technicianId": technicianId,
        "productId": productId.toJson(),
        "count": count,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class ProductId {
    String id;
    String productName;
    String quantity;
    bool stock;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    int price;

    ProductId({
        required this.id,
        required this.productName,
        required this.quantity,
        required this.stock,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        required this.price,
    });

    factory ProductId.fromJson(Map<String, dynamic> json) => ProductId(
        id: json["_id"],
        productName: json["productName"],
        quantity: json["quantity"],
        stock: json["stock"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "productName": productName,
        "quantity": quantity,
        "stock": stock,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "price": price,
    };
}
