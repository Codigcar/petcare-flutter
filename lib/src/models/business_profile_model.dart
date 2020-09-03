// To parse this JSON data, do
//
//     final businessProfileModel = businessProfileModelFromJson(jsonString);

import 'dart:convert';

BusinessProfileModel businessProfileModelFromJson(String str) => BusinessProfileModel.fromJson(json.decode(str));

String businessProfileModelToJson(BusinessProfileModel data) => json.encode(data.toJson());

class BusinessProfileModel {
    BusinessProfileModel({
        this.name,
        this.password,
        this.lastName,
        this.document,
        this.email,
        this.phone,
        this.age,
        this.owner,
    });

    String name;
    String password;
    String lastName;
    String document;
    String email;
    String phone;
    String age;
    bool owner;

    factory BusinessProfileModel.fromJson(Map<String, dynamic> json) => BusinessProfileModel(
        name: json["name"],
        password: json["password"],
        lastName: json["lastName"],
        document: json["document"],
        email: json["email"],
        phone: json["phone"],
        age: json["age"],
        owner: json["owner"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "password": password,
        "lastName": lastName,
        "document": document,
        "email": email,
        "phone": phone,
        "age": age,
        "owner": owner,
    };
}
