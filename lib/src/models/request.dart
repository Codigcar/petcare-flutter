import 'dart:convert';

RequestModel requestModelFromJson(String str) => RequestModel.fromJson(json.decode(str));

String requestModelToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
    RequestModel({
        this.id,
        this.dateReservation,
        this.startTime,
        this.endTime,
        this.veterinaryName,
        this.productTypeName,
        this.productName,
        this.petName,
        this.status,
        this.personName,
    });

    int id;
    DateTime dateReservation;
    String startTime;
    String endTime;
    String veterinaryName;
    String productTypeName;
    String productName;
    String petName;
    int status;
    String personName;

    factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
        id: json["id"],
        dateReservation: DateTime.parse(json["dateReservation"]),
        startTime: json["startTime"],
        endTime: json["endTime"],
        veterinaryName: json["veterinaryName"],
        productTypeName: json["productTypeName"],
        productName: json["productName"],
        petName: json["petName"],
        status: json["status"],
        personName: json["personName"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "dateReservation": dateReservation.toIso8601String(),
        "startTime": startTime,
        "endTime": endTime,
        "veterinaryName": veterinaryName,
        "productTypeName": productTypeName,
        "productName": productName,
        "petName": petName,
        "status": status,
        "personName": personName,
    };
}