// To parse this JSON data, do
//
//     final showOvertimeResponse = showOvertimeResponseFromJson(jsonString);

import 'dart:convert';

ShowOvertimeResponse showOvertimeResponseFromJson(String str) => ShowOvertimeResponse.fromJson(json.decode(str));

String showOvertimeResponseToJson(ShowOvertimeResponse data) => json.encode(data.toJson());

class ShowOvertimeResponse {
    ShowOvertimeResponse({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    DataDetailOvertime? data;

    factory ShowOvertimeResponse.fromJson(Map<String, dynamic> json) => ShowOvertimeResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : DataDetailOvertime.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
    };
}

class DataDetailOvertime {
    DataDetailOvertime({
        this.id,
        this.code,
        this.dateRequest,
        this.startTime,
        this.endTime,
        this.note,
        this.actualTime,
        this.totalTime,
        this.userClientId,
        this.userClientBranchId,
        this.userCoordinatorId,
        this.status,
        this.createdAt,
        this.updatedAt,
        this.statusLabel,
        this.branchName,
        this.overtimeRoomPhotos,
    });

    int? id;
    String? code;
    DateTime? dateRequest;
    DateTime? startTime;
    DateTime? endTime;
    String? note;
    String? actualTime;
    String? totalTime;
    int? userClientId;
    int? userClientBranchId;
    int? userCoordinatorId;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? statusLabel;
    String? branchName;
    List<OvertimeRoomPhoto>? overtimeRoomPhotos;

    factory DataDetailOvertime.fromJson(Map<String, dynamic> json) => DataDetailOvertime(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        dateRequest: json["date_request"] == null ? null : DateTime.parse(json["date_request"]),
        startTime: json["start_time"] == null ? null : DateTime.parse(json["start_time"]),
        endTime: json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        note: json["note"] == null ? null : json["note"],
        actualTime: json["actual_time"],
        totalTime: json["total_time"] == null ? null : json["total_time"],
        userClientId: json["user_client_id"],
        userClientBranchId: json["user_client_branch_id"],
        userCoordinatorId: json["user_coordinator_id"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        statusLabel: json["status_label"] == null ? null : json["status_label"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
        overtimeRoomPhotos: json["overtime_room_photos"] == null ? null : List<OvertimeRoomPhoto>.from(json["overtime_room_photos"].map((x) => OvertimeRoomPhoto.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "date_request": dateRequest == null ? null : dateRequest?.toIso8601String(),
        "start_time": startTime == null ? null : startTime?.toIso8601String(),
        "end_time": endTime == null ? null : endTime?.toIso8601String(),
        "note": note == null ? null : note,
        "actual_time": actualTime,
        "total_time": totalTime == null ? null : totalTime,
        "user_client_id": userClientId,
        "user_client_branch_id": userClientBranchId,
        "user_coordinator_id": userCoordinatorId,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "status_label": statusLabel == null ? null : statusLabel,
        "branch_name": branchName == null ? null : branchName,
        "overtime_room_photos": overtimeRoomPhotos == null ? null : List<dynamic>.from(overtimeRoomPhotos!.map((x) => x.toJson())),
    };
}

class OvertimeRoomPhoto {
    OvertimeRoomPhoto({
        this.id,
        this.overtimeId,
        this.name,
        this.beforePhotos,
        this.afterPhotos,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    int? id;
    int? overtimeId;
    String? name;
    List<String>? beforePhotos;
    List<String>? afterPhotos;
    DateTime? createdAt;
    DateTime? updatedAt;
    DateTime? deletedAt;

    factory OvertimeRoomPhoto.fromJson(Map<String, dynamic> json) => OvertimeRoomPhoto(
        id: json["id"] == null ? null : json["id"],
        overtimeId: json["overtime_id"] == null ? null : json["overtime_id"],
        name: json["name"] == null ? null : json["name"],
        beforePhotos: json["before_photos"] == null ? null : List<String>.from(json["before_photos"].map((x) => x)),
        afterPhotos: json["after_photos"] == null ? null : List<String>.from(json["after_photos"].map((x) => x)),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "overtime_id": overtimeId == null ? null : overtimeId,
        "name": name == null ? null : name,
        "before_photos": beforePhotos == null ? null : List<dynamic>.from(beforePhotos!.map((x) => x)),
        "after_photos": afterPhotos == null ? null : List<dynamic>.from(afterPhotos!.map((x) => x)),
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}
