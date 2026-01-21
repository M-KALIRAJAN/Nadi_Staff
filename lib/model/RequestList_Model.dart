

import 'dart:convert';

RequestList requestListFromJson(String str) => RequestList.fromJson(json.decode(str));

String requestListToJson(RequestList data) => json.encode(data.toJson());

class RequestList {
    bool success;
    List<Datum> data;

    RequestList({
        required this.success,
        required this.data,
    });

    factory RequestList.fromJson(Map<String, dynamic> json) => RequestList(
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
    String quantity;
    String status;
    int v;
    String? notes;

    Datum({
        required this.id,
        required this.technicianId,
        required this.productId,
        required this.quantity,
        required this.status,
        required this.v,
        this.notes,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        technicianId: json["technicianId"],
        productId: ProductId.fromJson(json["productId"]),
        quantity: json["quantity"],
        status: json["status"],
        v: json["__v"],
        notes: json["notes"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "technicianId": technicianId,
        "productId": productId.toJson(),
        "quantity": quantity,
        "status": status,
        "__v": v,
        "notes": notes,
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
