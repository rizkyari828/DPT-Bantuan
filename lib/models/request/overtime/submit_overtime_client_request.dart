// To parse this JSON data, do
//
//     final submitOvertimeRequest = submitOvertimeRequestFromJson(jsonString);

import 'dart:convert';

SubmitOvertimeClientRequest submitOvertimeRequestFromJson(String str) =>
    SubmitOvertimeClientRequest.fromJson(json.decode(str));

String submitOvertimeRequestToJson(SubmitOvertimeClientRequest data) =>
    json.encode(data.toJson());

class SubmitOvertimeClientRequest {
  SubmitOvertimeClientRequest({this.note, this.userId});

  String? note;
  int? userId;

  factory SubmitOvertimeClientRequest.fromJson(Map<String, dynamic> json) =>
      SubmitOvertimeClientRequest(
        note: json["note"] == null ? null : json["note"],
        userId: json["user_tad_id"] == null ? null : json["user_tad_id"],
      );

  Map<String, dynamic> toJson() => {
        "note": note == null ? null : note,
        "user_tad_id": userId == null ? null : userId,
      };
}
