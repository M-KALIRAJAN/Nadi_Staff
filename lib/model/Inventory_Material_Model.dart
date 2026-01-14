class InventoryMaterial {
  List<InventoryItem> data;

  InventoryMaterial({required this.data});

  factory InventoryMaterial.fromJson(Map<String, dynamic> json) => InventoryMaterial(
        data: List<InventoryItem>.from(
            (json["data"] as List).map((x) => InventoryItem.fromJson(x))),
      );
}

class InventoryItem {
  String id;
  String technicianId;
  Product productId; // ✅ match JSON
  int count;

  InventoryItem({
    required this.id,
    required this.technicianId,
    required this.productId,
    required this.count,
  });

  factory InventoryItem.fromJson(Map<String, dynamic> json) => InventoryItem(
        id: json["_id"].toString(),
        technicianId: json["technicianId"].toString(),
        productId: Product.fromJson(json["productId"]),
        count: json["count"] is int
            ? json["count"]
            : int.tryParse(json["count"].toString()) ?? 0,
      );
}

class Product {
  String id;
  String productName;
  int quantity;
  int price;

  Product({
    required this.id,
    required this.productName,
    required this.quantity,
    required this.price,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"].toString(),
        productName: json["productName"].toString(),
        quantity: json["quantity"] is int
            ? json["quantity"]
            : int.tryParse(json["quantity"].toString()) ?? 0,
        price: json["price"] is int
            ? json["price"]
            : int.tryParse(json["price"].toString()) ?? 0,
      );
}

