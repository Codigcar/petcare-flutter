// To parse this JSON data, do
//
//     final accountModel = accountModelFromJson(jsonString);

import 'dart:convert';

AccountModel accountModelFromJson(String str) => AccountModel.fromJson(json.decode(str));

String accountModelToJson(AccountModel data) => json.encode(data.toJson());

class AccountModel {
    AccountModel({
        this.id,
        this.user,
        this.password,
    });

    int id;
    String user;
    String password;

    factory AccountModel.fromJson(Map<String, dynamic> json) => AccountModel(
        id: json["id"],
        user: json["user"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "user": user,
        "password": password,
    };
}
