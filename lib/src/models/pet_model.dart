// To parse this JSON data, do
//
//     final petModel = petModelFromJson(jsonString);

import 'dart:convert';

PetModel petModelFromJson(String str) => PetModel.fromJson(json.decode(str));

String petModelToJson(PetModel data) => json.encode(data.toJson());

class PetModel {
    PetModel({
        this.id,
        this.name,
        this.age = 0,
        this.breed,
        this.photo,
        this.gender,
    });

    int id;
    String name;
    int age;
    String breed;
    String photo;
    String gender;

    factory PetModel.fromJson(Map<String, dynamic> json) => PetModel(
        id: json["id"],
        name: json["name"],
        age: json["age"],
        breed: json["breed"],
        photo: json["photo"],
        gender: json["gender"],
    );

    Map<String, dynamic> toJson() => {
        "id":id,
        "name": name,
        "age": age,
        "breed": breed,
        "photo": photo,
        "gender": gender,
    };
}
