// To parse this JSON data, do
//
//     final updateApprovalIzinRequest = updateApprovalIzinRequestFromJson(jsonString);

import 'dart:convert';

UpdateApprovalIzinRequest updateApprovalIzinRequestFromJson(String str) => UpdateApprovalIzinRequest.fromJson(json.decode(str));

String updateApprovalIzinRequestToJson(UpdateApprovalIzinRequest data) => json.encode(data.toJson());

class UpdateApprovalIzinRequest {
    UpdateApprovalIzinRequest({
        this.action,
        this.noteApproval,
    });

    String? action;
    String? noteApproval;

    factory UpdateApprovalIzinRequest.fromJson(Map<String, dynamic> json) => UpdateApprovalIzinRequest(
        action: json["action"],
        noteApproval: json["note_approval"],
    );

    Map<String, dynamic> toJson() => {
        "action": action,
        "note_approval": noteApproval,
    };
}
