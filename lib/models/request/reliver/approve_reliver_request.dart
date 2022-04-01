// To parse this JSON data, do
//
//     final approveReliverRequest = approveReliverRequestFromJson(jsonString);

import 'dart:convert';

ApproveReliverRequest approveReliverRequestFromJson(String str) =>
    ApproveReliverRequest.fromJson(json.decode(str));

String approveReliverRequestToJson(ApproveReliverRequest data) =>
    json.encode(data.toJson());

class ApproveReliverRequest {
  ApproveReliverRequest({
    this.action,
    this.needAprroveEmployee,
    this.dateStartWorkEmployee,
    this.noteApproval,
  });

  String? action;
  int? needAprroveEmployee;
  String? dateStartWorkEmployee;
  String? noteApproval;

  factory ApproveReliverRequest.fromJson(Map<String, dynamic> json) =>
      ApproveReliverRequest(
        action: json["action"] == null ? null : json["action"],
        needAprroveEmployee: json["need_aprrove_employee"] == null
            ? null
            : json["need_aprrove_employee"],
        dateStartWorkEmployee: json["date_start_work_employee"] == null
            ? null
            : json["date_start_work_employee"],
        noteApproval:
            json["note_approval"] == null ? null : json["note_approval"],
      );

  Map<String, dynamic> toJson() => {
        "action": action == null ? null : action,
        "need_aprrove_employee":
            needAprroveEmployee == null ? null : needAprroveEmployee,
        "date_start_work_employee":
            dateStartWorkEmployee == null ? null : dateStartWorkEmployee,
        "note_approval": noteApproval == null ? null : noteApproval,
      };
}
