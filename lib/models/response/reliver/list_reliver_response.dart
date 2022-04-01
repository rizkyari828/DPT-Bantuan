// To parse this JSON data, do
//
//     final listReliverResponse = listReliverResponseFromJson(jsonString);

import 'dart:convert';

ListReliverResponse listReliverResponseFromJson(String str) =>
    ListReliverResponse.fromJson(json.decode(str));

String listReliverResponseToJson(ListReliverResponse data) =>
    json.encode(data.toJson());

class ListReliverResponse {
  ListReliverResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<DataListReliver>? data;

  factory ListReliverResponse.fromJson(Map<String, dynamic> json) =>
      ListReliverResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataListReliver>.from(
                json["data"].map((x) => DataListReliver.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataListReliver {
  DataListReliver({
    this.id,
    this.code,
    this.dateRequest,
    this.dateNeeded,
    this.dateEndNeeded,
    this.branchId,
    this.userClientId,
    this.userClientBranchId,
    this.userCoordinatorId,
    this.note,
    this.noteApproval,
    this.needEmployee,
    this.needAprroveEmployee,
    this.dateStartWorkEmployee,
    this.status,
    this.statusLabel,
  });

  int? id;
  String? code;
  DateTime? dateRequest;
  DateTime? dateNeeded;
  DateTime? dateEndNeeded;
  int? branchId;
  dynamic userClientId;
  int? userClientBranchId;
  dynamic userCoordinatorId;
  String? note;
  String? noteApproval;
  int? needEmployee;
  dynamic needAprroveEmployee;
  DateTime? dateStartWorkEmployee;
  String? status;
  String? statusLabel;

  factory DataListReliver.fromJson(Map<String, dynamic> json) =>
      DataListReliver(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        dateRequest: json["date_request"] == null
            ? null
            : DateTime.parse(json["date_request"]),
        dateNeeded: json["date_needed"] == null
            ? null
            : DateTime.parse(json["date_needed"]),
        dateEndNeeded: json["date_end_needed"] == null
            ? null
            : DateTime.parse(json["date_end_needed"]),
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        userClientId: json["user_client_id"],
        userClientBranchId: json["user_client_branch_id"] == null
            ? null
            : json["user_client_branch_id"],
        userCoordinatorId: json["user_coordinator_id"],
        note: json["note"] == null ? null : json["note"],
        noteApproval: json["note_approval"],
        needEmployee:
            json["need_employee"] == null ? null : json["need_employee"],
        needAprroveEmployee: json["need_aprrove_employee"],
        dateStartWorkEmployee: json["date_start_work_employee"] == null
            ? null
            : DateTime.parse(json["date_start_work_employee"]),
        status: json["status"] == null ? null : json["status"],
        statusLabel: json["status_label"] == null ? null : json["status_label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "date_request":
            dateRequest == null ? null : dateRequest?.toIso8601String(),
        "date_needed": dateNeeded == null
            ? null
            : "${dateNeeded?.year.toString().padLeft(4, '0')}-${dateNeeded?.month.toString().padLeft(2, '0')}-${dateNeeded?.day.toString().padLeft(2, '0')}",
        "date_end_needed": dateEndNeeded == null
            ? null
            : "${dateEndNeeded?.year.toString().padLeft(4, '0')}-${dateEndNeeded?.month.toString().padLeft(2, '0')}-${dateEndNeeded?.day.toString().padLeft(2, '0')}",
        "branch_id": branchId == null ? null : branchId,
        "user_client_id": userClientId,
        "user_client_branch_id":
            userClientBranchId == null ? null : userClientBranchId,
        "user_coordinator_id": userCoordinatorId,
        "note": note == null ? null : note,
        "note_approval": noteApproval,
        "need_employee": needEmployee == null ? null : needEmployee,
        "need_aprrove_employee": needAprroveEmployee,
        "date_start_work_employee": dateStartWorkEmployee == null
            ? null
            : "${dateStartWorkEmployee?.year.toString().padLeft(4, '0')}-${dateStartWorkEmployee?.month.toString().padLeft(2, '0')}-${dateStartWorkEmployee?.day.toString().padLeft(2, '0')}",
        "status": status == null ? null : status,
        "status_label": statusLabel == null ? null : statusLabel,
      };
}
