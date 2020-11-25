// To parse this JSON data, do
//
//     final businessRequestModel = businessRequestModelFromJson(jsonString);

import 'dart:convert';

BusinessRequestModel businessRequestModelFromJson(String str) =>
    BusinessRequestModel.fromJson(json.decode(str));

String businessRequestModelToJson(BusinessRequestModel data) =>
    json.encode(data.toJson());

class BusinessRequestModel {
  BusinessRequestModel({
    this.id,
    this.name,
    this.password,
    this.lastName,
    this.document,
    this.email,
    this.age,
    this.phone,
    this.photo,
  });

  int id;
  String name;
  String password;
  String lastName;
  int document;
  String email;
  int age;
  int phone;
  String photo;

  factory BusinessRequestModel.fromJson(Map<String, dynamic> json) =>
      BusinessRequestModel(
        id: json["id"],
        name: json["name"],
        password: json["password"],
        lastName: json["lastName"],
        document: json["document"],
        email: json["email"],
        age: json["age"],
        phone: json["phone"],
        photo: json["photo"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "password": password,
        "lastName": lastName,
        "document": document,
        "email": email,
        "age": age,
        "phone": phone,
        "photo": photo,
      };
}
