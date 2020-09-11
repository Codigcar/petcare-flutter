// To parse this JSON data, do
//
//     final providerModel = providerModelFromJson(jsonString);

import 'dart:convert';

ProviderModel providerModelFromJson(String str) => ProviderModel.fromJson(json.decode(str));

String providerModelToJson(ProviderModel data) => json.encode(data.toJson());

class ProviderModel {
    ProviderModel({
        this.id,
        this.businessName,
        this.region,
        this.address,
        this.field,
        this.email,
        this.description,
        this.photo,
    });

    int id;
    String businessName;
    String region;
    String address;
    String field;
    String email;
    String description;
    String photo;

    factory ProviderModel.fromJson(Map<String, dynamic> json) => ProviderModel(
        id: json["id"],
        businessName: json["businessName"],
        region: json["region"],
        address: json["address"],
        field: json["field"],
        email: json["email"],
        description: json["description"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
        "id":id,
        "businessName": businessName,
        "region": region,
        "address": address,
        "field": field,
        "email": email,
        "description": description,
        "photo": photo,
    };
}
