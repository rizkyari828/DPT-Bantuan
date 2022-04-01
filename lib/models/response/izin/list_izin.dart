// To parse this JSON data, do
//
//     final izinRespons = izinResponsFromJson(jsonString);

import 'dart:convert';

IzinResponse izinResponsFromJson(String str) => IzinResponse.fromJson(json.decode(str));

String izinResponsToJson(IzinResponse data) => json.encode(data.toJson());

class IzinResponse {
    IzinResponse({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    List<DataIzin>? data;

    factory IzinResponse.fromJson(Map<String, dynamic> json) => IzinResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<DataIzin>.from(json["data"].map((x) => DataIzin.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
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
        id: json["id"] == null ? null : json["id"],
        leaveTypeId: json["leave_type_id"] == null ? null : json["leave_type_id"],
        code: json["code"] == null ? null : json["code"],
        documents: json["documents"] == null ? null : List<String>.from(json["documents"].map((x) => x)),
        dateRequest: json["date_request"] == null ? null : DateTime.parse(json["date_request"]),
        dateStart: json["date_start"] == null ? null : DateTime.parse(json["date_start"]),
        dateEnd: json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
        note: json["note"] == null ? null : json["note"],
        noteApproval: json["note_approval"] == null ? null : json["note_approval"],
        status: json["status"] == null ? null : json["status"],
        statusLabel: json["status_label"] == null ? null : json["status_label"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
        leaveTypeName: json["leave_type_name"] == null ? null : json["leave_type_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "leave_type_id": leaveTypeId == null ? null : leaveTypeId,
        "code": code == null ? null : code,
        "documents": documents == null ? null : List<dynamic>.from(documents!.map((x) => x)),
        "date_request": dateRequest == null ? null : dateRequest?.toIso8601String(),
        "date_start": dateStart == null ? null : dateStart?.toIso8601String(),
        "date_end": dateEnd == null ? null : dateEnd?.toIso8601String(),
        "note": note == null ? null : note,
        "note_approval": noteApproval == null ? null : noteApproval,
        "status": status == null ? null : status,
        "status_label": statusLabel == null ? null : statusLabel,
        "branch_name": branchName == null ? null : branchName,
        "leave_type_name": leaveTypeName == null ? null : leaveTypeName,
    };
}
