import 'dart:convert';

RequestModel requestModelFromJson(String str) =>
    RequestModel.fromJson(json.decode(str));

String requestModelToJson(RequestModel data) => json.encode(data.toJson());

class RequestModel {
  RequestModel(
      {this.id,
      this.dateReservation,
      this.startTime,
      this.veterinaryName,
      this.productTypeName,
      this.productName,
      this.petName,
      this.status,
      this.personName,
      this.personPhone,
      this.petPhoto,
      this.personPhoto});

  int id;
  String dateReservation;
  String startTime;
  String veterinaryName;
  String productTypeName;
  String productName;
  String petName;
  int status;
  String personName;
  String personPhone;
  String petPhoto;
  String personPhoto;

  factory RequestModel.fromJson(Map<String, dynamic> json) => RequestModel(
      id: json["id"],
      dateReservation: json["dateReservation"],
      startTime: json["startTime"],
      veterinaryName: json["veterinaryName"],
      productTypeName: json["productTypeName"],
      productName: json["productName"],
      petName: json["petName"],
      status: json["status"],
      personName: json["personName"],
      personPhone: json["personPhone"],
      petPhoto: json["petPhoto"],
      personPhoto: json["personPhoto"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "dateReservation": dateReservation,
        "startTime": startTime,
        "veterinaryName": veterinaryName,
        "productTypeName": productTypeName,
        "productName": productName,
        "petName": petName,
        "status": status,
        "personName": personName,
        "personPhone": personPhone,
        "petPhoto": petPhoto,
        "personPhoto": personPhoto
      };
}
