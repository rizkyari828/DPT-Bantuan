// To parse this JSON data, do
//
//     final attendanceValidateResponse = attendanceValidateResponseFromJson(jsonString);

import 'dart:convert';

AttendanceValidateResponse attendanceValidateResponseFromJson(String str) =>
    AttendanceValidateResponse.fromJson(json.decode(str));

String attendanceValidateResponseToJson(AttendanceValidateResponse data) =>
    json.encode(data.toJson());

class AttendanceValidateResponse {
  AttendanceValidateResponse({
    this.error,
    this.message,
    // this.data,
  });

  bool? error;
  String? message;
  // Data? data;

  factory AttendanceValidateResponse.fromJson(Map<String, dynamic> json) =>
      AttendanceValidateResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        // data: json["data"] == [] ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        // "data": data == null ? null : data?.toJson(),
      };
}

class Data {
  Data({
    this.distance,
    this.radius,
  });

  double? distance;
  int? radius;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        distance: json["distance"] == null ? null : json["distance"].toDouble(),
        radius: json["radius"] == null ? null : json["radius"],
      );

  Map<String, dynamic> toJson() => {
        "distance": distance == null ? null : distance,
        "radius": radius == null ? null : radius,
      };
}
