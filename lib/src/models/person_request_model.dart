// To parse this JSON data, do
//
//     final personRequestModel = personRequestModelFromJson(jsonString);

import 'dart:convert';

PersonRequestModel personRequestModelFromJson(String str) =>
    PersonRequestModel.fromJson(json.decode(str));

String personRequestModelToJson(PersonRequestModel data) =>
    json.encode(data.toJson());

class PersonRequestModel {
  PersonRequestModel({
    this.dateReservation,
    this.startTime,
    this.endTime,
    this.status,
  });

  String dateReservation;
  String startTime;
  String endTime;
  int status;

  factory PersonRequestModel.fromJson(Map<String, dynamic> json) =>
      PersonRequestModel(
        dateReservation: json["dateReservation"],
        startTime: json["startTime"],
        endTime: json["endTime"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "dateReservation": dateReservation,
        "startTime": startTime,
        "endTime": endTime,
        "status": status,
      };
}
