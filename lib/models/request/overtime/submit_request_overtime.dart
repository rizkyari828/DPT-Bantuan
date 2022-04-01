// To parse this JSON data, do
//
//     final submitOvertimeRequest = submitOvertimeRequestFromJson(jsonString);

import 'dart:convert';

SubmitOvertimeRequest submitOvertimeRequestFromJson(String str) => SubmitOvertimeRequest.fromJson(json.decode(str));

String submitOvertimeRequestToJson(SubmitOvertimeRequest data) => json.encode(data.toJson());

class SubmitOvertimeRequest {
    SubmitOvertimeRequest({
        this.note,
    });

    String? note;

    factory SubmitOvertimeRequest.fromJson(Map<String, dynamic> json) => SubmitOvertimeRequest(
        note: json["note"] == null ? null : json["note"],
    );

    Map<String, dynamic> toJson() => {
        "note": note == null ? null : note,
    };
}
