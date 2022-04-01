import 'dart:convert';

class AttendanceSubmitRequest {
  AttendanceSubmitRequest({
    required this.latitude,
    required this.longitude,
  });

  String latitude;
  String longitude;

  factory AttendanceSubmitRequest.fromRawJson(String str) =>
      AttendanceSubmitRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AttendanceSubmitRequest.fromJson(Map<String, dynamic> json) =>
      AttendanceSubmitRequest(
        latitude: json["latitude"],
        longitude: json["longitude"],
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
      };
}
