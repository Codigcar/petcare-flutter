// To parse this JSON data, do
//
//     final productTypeModel = productTypeModelFromJson(jsonString);

import 'dart:convert';

ProductTypeModel productTypeModelFromJson(String str) => ProductTypeModel.fromJson(json.decode(str));

String productTypeModelToJson(ProductTypeModel data) => json.encode(data.toJson());

class ProductTypeModel {
    ProductTypeModel({
        this.id,
        this.name,
    });

    int id;
    String name;

    factory ProductTypeModel.fromJson(Map<String, dynamic> json) => ProductTypeModel(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
