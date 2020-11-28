import 'dart:convert';

RolModel rolModelFromJson(String str) => RolModel.fromJson(json.decode(str));

String rolModelToJson(RolModel data) => json.encode(data.toJson());

class RolModel {
  RolModel({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory RolModel.fromJson(Map<String, dynamic> json) => RolModel(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
