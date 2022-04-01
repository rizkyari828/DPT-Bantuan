// To parse this JSON data, do
//
//     final submitIzinRequest = submitIzinRequestFromJson(jsonString);

import 'dart:convert';

SubmitIzinRequest submitIzinRequestFromJson(String str) => SubmitIzinRequest.fromJson(json.decode(str));

String submitIzinRequestToJson(SubmitIzinRequest data) => json.encode(data.toJson());

class SubmitIzinRequest {
    SubmitIzinRequest({
        this.leaveTypeId,
        this.dateStart,
        this.dateEnd,
        this.note,
        this.base64Documents,
    });

    String? leaveTypeId;
    String? dateStart;
    String? dateEnd;
    String? note;
    List<String>? base64Documents;

    factory SubmitIzinRequest.fromJson(Map<String, dynamic> json) => SubmitIzinRequest(
        leaveTypeId: json["leave_type_id"],
        dateStart: json["date_start"],
        dateEnd: json["date_end"],
        note: json["note"],
        base64Documents: List<String>.from(json["base64_documents"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "leave_type_id": leaveTypeId,
        "date_start": dateStart,
        "date_end": dateEnd,
        "note": note,
        "base64_documents": List<dynamic>.from(base64Documents!.map((x) => x)),
    };
}
