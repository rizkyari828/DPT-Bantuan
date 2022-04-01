// To parse this JSON data, do
//
//     final updateApprovalCutiRequest = updateApprovalCutiRequestFromJson(jsonString);

import 'dart:convert';

UpdateApprovalCutiRequest updateApprovalCutiRequestFromJson(String str) => UpdateApprovalCutiRequest.fromJson(json.decode(str));

String updateApprovalCutiRequestToJson(UpdateApprovalCutiRequest data) => json.encode(data.toJson());

class UpdateApprovalCutiRequest {
    UpdateApprovalCutiRequest({
        this.action,
        this.noteApproval,
    });

    String? action;
    String? noteApproval;

    factory UpdateApprovalCutiRequest.fromJson(Map<String, dynamic> json) => UpdateApprovalCutiRequest(
        action: json["action"],
        noteApproval: json["note_approval"],
    );

    Map<String, dynamic> toJson() => {
        "action": action,
        "note_approval": noteApproval,
    };
}
