import 'dart:convert';

class LogoutRequest {
  LogoutRequest({
    this.username,
  });

  String? username;

  factory LogoutRequest.fromRawJson(String str) =>
      LogoutRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory LogoutRequest.fromJson(Map<String, dynamic> json) => LogoutRequest(
        username: json["username"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
      };
}
