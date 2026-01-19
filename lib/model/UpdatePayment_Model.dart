

import 'dart:convert';

UpdatePayment updatePaymentFromJson(String str) => UpdatePayment.fromJson(json.decode(str));

String updatePaymentToJson(UpdatePayment data) => json.encode(data.toJson());

class UpdatePayment {
    String userServiceId;
    bool sparePartsUsed;
    List<SelectedSparePart> selectedSpareParts;

    UpdatePayment({
        required this.userServiceId,
        required this.sparePartsUsed,
        required this.selectedSpareParts,
    });

    factory UpdatePayment.fromJson(Map<String, dynamic> json) => UpdatePayment(
        userServiceId: json["userServiceId"],
        sparePartsUsed: json["sparePartsUsed"],
        selectedSpareParts: List<SelectedSparePart>.from(json["selectedSpareParts"].map((x) => SelectedSparePart.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "userServiceId": userServiceId,
        "sparePartsUsed": sparePartsUsed,
        "selectedSpareParts": List<dynamic>.from(selectedSpareParts.map((x) => x.toJson())),
    };
}

class SelectedSparePart {
    String productId;
    int count;

    SelectedSparePart({
        required this.productId,
        required this.count,
    });

    factory SelectedSparePart.fromJson(Map<String, dynamic> json) => SelectedSparePart(
        productId: json["productId"],
        count: json["count"],
    );

    Map<String, dynamic> toJson() => {
        "productId": productId,
        "count": count,
    };
}
