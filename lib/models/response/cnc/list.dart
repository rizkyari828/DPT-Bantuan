// To parse this JSON data, do
//
//     final cnCResponse = cnCResponseFromJson(jsonString);

import 'dart:convert';

CnCResponse cnCResponseFromJson(String str) =>
    CnCResponse.fromJson(json.decode(str));

String cnCResponseToJson(CnCResponse data) => json.encode(data.toJson());

class CnCResponse {
  CnCResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<ListCnC>? data;

  factory CnCResponse.fromJson(Map<String, dynamic> json) => CnCResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<ListCnC>.from(json["data"].map((x) => ListCnC.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class ListCnC {
  ListCnC({
    this.id,
    this.code,
    this.userClientId,
    this.userClientBranchId,
    this.userCoordinatorId,
    this.branchName,
    this.date,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.statusLabel,
  });

  int? id;
  String? code;
  int? userClientId;
  int? userClientBranchId;
  int? userCoordinatorId;
  String? branchName;
  DateTime? date;
  String? note;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? statusLabel;

  factory ListCnC.fromJson(Map<String, dynamic> json) => ListCnC(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        userClientId: json["user_client_id"],
        userClientBranchId: json["user_client_branch_id"] == null
            ? null
            : json["user_client_branch_id"],
        userCoordinatorId: json["user_coordinator_id"] == null
            ? null
            : json["user_coordinator_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        note: json["note"] == null ? null : json["note"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        statusLabel: json["status_label"] == null ? null : json["status_label"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "user_client_id": userClientId,
        "user_client_branch_id":
            userClientBranchId == null ? null : userClientBranchId,
        "user_coordinator_id":
            userCoordinatorId == null ? null : userCoordinatorId,
        "date": date == null ? null : date?.toIso8601String(),
        "note": note == null ? null : note,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "status_label": statusLabel == null ? null : statusLabel,
        "branch_name": branchName == null ? null : branchName,
      };
}