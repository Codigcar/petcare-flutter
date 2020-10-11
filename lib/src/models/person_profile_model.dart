// To parse this JSON data, do
//
//     final personProfileModel = personProfileModelFromJson(jsonString);

import 'dart:convert';

PersonProfileModel personProfileModelFromJson(String str) => PersonProfileModel.fromJson(json.decode(str));

String personProfileModelToJson(PersonProfileModel data) => json.encode(data.toJson());

class PersonProfileModel {
    PersonProfileModel({
        this.name,
        this.password,
        this.lastName,
        this.document,
        this.email,
        this.phone,
        this.age,
        this.photo,
        this.id,
    });

    String name;
    String password;
    String lastName;
    String document;
    String email;
    String phone;
    String age;
    String photo;
    int id;

    factory PersonProfileModel.fromJson(Map<String, dynamic> json) => PersonProfileModel(
        id: json["id"],
        name: json["name"],
        password: json["password"],
        lastName: json["lastName"],
        document: json["document"],
        email: json["email"],
        phone: json["phone"],
        age: json["age"],
        photo: json["photo"],
    );

    Map<String, dynamic> toJson() => {
      "id":id,
        "name": name,
        "password": password,
        "lastName": lastName,
        "document": document,
        "email": email,
        "phone": phone,
        "age": age,
        "photo": photo,
    };
}
