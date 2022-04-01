// To parse this JSON data, do
//
//     final submitCutiRequest = submitCutiRequestFromJson(jsonString);

import 'dart:convert';

SubmitCutiRequest submitCutiRequestFromJson(String str) => SubmitCutiRequest.fromJson(json.decode(str));

String submitCutiRequestToJson(SubmitCutiRequest data) => json.encode(data.toJson());

class SubmitCutiRequest {
    SubmitCutiRequest({
        this.leaveTypeId,
        this.dateStart,
        this.dateEnd,
        this.note,
    });

    String? leaveTypeId;
    String? dateStart;
    String? dateEnd;
    String? note;

    factory SubmitCutiRequest.fromJson(Map<String, dynamic> json) => SubmitCutiRequest(
        leaveTypeId: json["leave_type_id"],
        dateStart: json["date_start"],
        dateEnd: json["date_end"],
        note: json["note"],
    );

    Map<String, dynamic> toJson() => {
        "leave_type_id": leaveTypeId,
        "date_start": dateStart,
        "date_end": dateEnd,
        "note": note,
    };
}
