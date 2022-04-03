// To parse this JSON data, do
//
//     final updateApprovalOvertimeRequest = updateApprovalOvertimeRequestFromJson(jsonString);

import 'dart:convert';

class UpdateApprovalOvertimeRequest {
  UpdateApprovalOvertimeRequest({
    this.action,
    this.actualTime,
    this.noteApproval,
  });

  String? action;
  double? actualTime;
  String? noteApproval;

  factory UpdateApprovalOvertimeRequest.fromRawJson(String str) =>
      UpdateApprovalOvertimeRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpdateApprovalOvertimeRequest.fromJson(Map<String, dynamic> json) =>
      UpdateApprovalOvertimeRequest(
        action: json["action"],
        actualTime: json["actual_time"],
        noteApproval: json["note_approval"],
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "actual_time": actualTime,
        "note_approval": noteApproval,
      };
}
