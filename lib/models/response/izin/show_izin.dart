// To parse this JSON data, do
//
//     final showIzinResponse = showIzinResponseFromJson(jsonString);

import 'dart:convert';

ShowIzinResponse showIzinResponseFromJson(String str) =>
    ShowIzinResponse.fromJson(json.decode(str));

String showIzinResponseToJson(ShowIzinResponse data) =>
    json.encode(data.toJson());

class ShowIzinResponse {
  ShowIzinResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  DataIzin? data;

  factory ShowIzinResponse.fromJson(Map<String, dynamic> json) =>
      ShowIzinResponse(
        error: json["error"],
        message: json["message"],
        data: DataIzin.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
      };
}

class DataIzin {
  DataIzin({
    this.id,
    this.leaveTypeId,
    this.code,
    this.documents,
    this.dateRequest,
    this.dateStart,
    this.dateEnd,
    this.note,
    this.noteApproval,
    this.status,
    this.statusLabel,
    this.branchName,
    this.leaveTypeName,
  });

  int? id;
  int? leaveTypeId;
  String? code;
  List<String>? documents;
  DateTime? dateRequest;
  DateTime? dateStart;
  DateTime? dateEnd;
  String? note;
  String? noteApproval;
  String? status;
  String? statusLabel;
  String? branchName;
  String? leaveTypeName;

  factory DataIzin.fromJson(Map<String, dynamic> json) => DataIzin(
        id: json["id"],
        leaveTypeId: json["leave_type_id"],
        code: json["code"],
        documents: List<String>.from(json["documents"].map((x) => x)),
        dateRequest: DateTime.parse(json["date_request"]),
        dateStart: DateTime.parse(json["date_start"]),
        dateEnd: DateTime.parse(json["date_end"]),
        note: json["note"],
        noteApproval: json["note_approval"],
        status: json["status"],
        statusLabel: json["status_label"],
        branchName: json["branch_name"],
        leaveTypeName: json["leave_type_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "leave_type_id": leaveTypeId,
        "code": code,
        "documents": List<dynamic>.from(documents!.map((x) => x)),
        "date_request": dateRequest?.toIso8601String(),
        "date_start": dateStart?.toIso8601String(),
        "date_end": dateEnd?.toIso8601String(),
        "note": note,
        "note_approval": noteApproval,
        "status": status,
        "status_label": statusLabel,
        "branch_name": branchName,
        "leave_type_name": leaveTypeName,
      };
}
