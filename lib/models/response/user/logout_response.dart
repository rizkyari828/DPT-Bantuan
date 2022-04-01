// To parse this JSON data, do
//
//     final logoutResponse = logoutResponseFromJson(jsonString);

import 'dart:convert';

LogoutResponse logoutResponseFromJson(String str) =>
    LogoutResponse.fromJson(json.decode(str));

String logoutResponseToJson(LogoutResponse data) => json.encode(data.toJson());

class LogoutResponse {
  LogoutResponse({
    this.error,
    this.message,
    this.data = const [],
  });

  bool? error;
  String? message;
  List<dynamic> data;

  factory LogoutResponse.fromJson(Map<String, dynamic> json) => LogoutResponse(
        error: json["error"],
        message: json["message"],
        data: List<dynamic>.from(json["data"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
      };
}
