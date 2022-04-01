// To parse this JSON data, do
//
//     final cutiRespons = cutiResponsFromJson(jsonString);

import 'dart:convert';

CutiResponse cutiResponsFromJson(String str) => CutiResponse.fromJson(json.decode(str));

String cutiResponsToJson(CutiResponse data) => json.encode(data.toJson());

class CutiResponse {
    CutiResponse({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    List<DataCuti>? data;

    factory CutiResponse.fromJson(Map<String, dynamic> json) => CutiResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<DataCuti>.from(json["data"].map((x) => DataCuti.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataCuti {
    DataCuti({
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
    String? documents;
    DateTime? dateRequest;
    DateTime? dateStart;
    DateTime? dateEnd;
    String? note;
    String? noteApproval;
    String? status;
    String? statusLabel;
    String? branchName;
    String? leaveTypeName;

    factory DataCuti.fromJson(Map<String, dynamic> json) => DataCuti(
        id: json["id"] == null ? null : json["id"],
        leaveTypeId: json["leave_type_id"] == null ? null : json["leave_type_id"],
        code: json["code"] == null ? null : json["code"],
        documents: json["documents"],
        dateRequest: json["date_request"] == null ? null : DateTime.parse(json["date_request"]),
        dateStart: json["date_start"] == null ? null : DateTime.parse(json["date_start"]),
        dateEnd: json["date_end"] == null ? null : DateTime.parse(json["date_end"]),
        note: json["note"] == null ? null : json["note"],
        noteApproval: json["note_approval"],
        status: json["status"] == null ? null : json["status"],
        statusLabel: json["status_label"] == null ? null : json["status_label"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
        leaveTypeName: json["leave_type_name"] == null ? null : json["leave_type_name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "leave_type_id": leaveTypeId == null ? null : leaveTypeId,
        "code": code == null ? null : code,
        "documents": documents,
        "date_request": dateRequest == null ? null : dateRequest?.toIso8601String(),
        "date_start": dateStart == null ? null : dateStart?.toIso8601String(),
        "date_end": dateEnd == null ? null : dateEnd?.toIso8601String(),
        "note": note == null ? null : note,
        "note_approval": noteApproval,
        "status": status == null ? null : status,
        "status_label": statusLabel == null ? null : statusLabel,
        "branch_name": branchName == null ? null : branchName,
        "leave_type_name": leaveTypeName == null ? null : leaveTypeName,
    };
}
