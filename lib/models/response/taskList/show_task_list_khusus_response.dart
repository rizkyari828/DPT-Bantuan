// To parse this JSON data, do
//
//     final showTaskListKhususResponse = showTaskListKhususResponseFromJson(jsonString);

import 'dart:convert';

ShowTaskListKhususResponse showTaskListKhususResponseFromJson(String str) => ShowTaskListKhususResponse.fromJson(json.decode(str));

String showTaskListKhususResponseToJson(ShowTaskListKhususResponse data) => json.encode(data.toJson());

class ShowTaskListKhususResponse {
    ShowTaskListKhususResponse({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    ShowTaskListKhusus? data;

    factory ShowTaskListKhususResponse.fromJson(Map<String, dynamic> json) => ShowTaskListKhususResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : ShowTaskListKhusus.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
    };
}

class ShowTaskListKhusus {
    ShowTaskListKhusus({
        this.id,
        this.taskId,
        this.branchId,
        this.timestamp,
        this.note,
        this.startTime,
        this.endTime,
        this.task,
        this.branch,
        this.userTad,
    });

    int? id;
    int? taskId;
    int? branchId;
    DateTime? timestamp;
    String? note;
    String? startTime;
    String? endTime;
    Task? task;
    Branch? branch;
    UserTad? userTad;

    factory ShowTaskListKhusus.fromJson(Map<String, dynamic> json) => ShowTaskListKhusus(
        id: json["id"] == null ? null : json["id"],
        taskId: json["task_id"] == null ? null : json["task_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        timestamp: json["timestamp"] == null ? null : DateTime.parse(json["timestamp"]),
        note: json["note"] == null ? null : json["note"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        task: json["task"] == null ? null : Task.fromJson(json["task"]),
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
        userTad: json["user_tad"] == null ? null : UserTad.fromJson(json["user_tad"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "task_id": taskId == null ? null : taskId,
        "branch_id": branchId == null ? null : branchId,
        "timestamp": timestamp == null ? null : timestamp?.toIso8601String(),
        "note": note == null ? null : note,
        "start_time": startTime == null ? null : startTime,
        "end_time": endTime == null ? null : endTime,
        "task": task == null ? null : task?.toJson(),
        "branch": branch == null ? null : branch?.toJson(),
        "user_tad": userTad == null ? null : userTad?.toJson(),
    };
}

class Branch {
    Branch({
        this.id,
        this.companyId,
        this.name,
        this.longitude,
        this.latitude,
        this.radius,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.location,
        this.building,
        this.levelApprovalCnc,
        this.levelApprovalOvertime,
        this.levelApprovalLeave,
        this.code,
        this.conditionCnc,
        this.conditionOvertime,
        this.conditionLeave,
        this.timezone,
        this.companyName,
        this.timeZoneName,
        this.timeZoneCode,
        this.company,
    });

    int? id;
    int? companyId;
    String? name;
    double? longitude;
    double? latitude;
    int? radius;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    String? location;
    String? building;
    String? levelApprovalCnc;
    String? levelApprovalOvertime;
    String? levelApprovalLeave;
    String? code;
    String? conditionCnc;
    String? conditionOvertime;
    String? conditionLeave;
    String? timezone;
    String? companyName;
    String? timeZoneName;
    String? timeZoneCode;
    Company? company;

    factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"] == null ? null : json["id"],
        companyId: json["company_id"] == null ? null : json["company_id"],
        name: json["name"] == null ? null : json["name"],
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        radius: json["radius"] == null ? null : json["radius"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        location: json["location"] == null ? null : json["location"],
        building: json["building"] == null ? null : json["building"],
        levelApprovalCnc: json["level_approval_cnc"] == null ? null : json["level_approval_cnc"],
        levelApprovalOvertime: json["level_approval_overtime"] == null ? null : json["level_approval_overtime"],
        levelApprovalLeave: json["level_approval_leave"] == null ? null : json["level_approval_leave"],
        code: json["code"] == null ? null : json["code"],
        conditionCnc: json["condition_cnc"] == null ? null : json["condition_cnc"],
        conditionOvertime: json["condition_overtime"] == null ? null : json["condition_overtime"],
        conditionLeave: json["condition_leave"] == null ? null : json["condition_leave"],
        timezone: json["timezone"] == null ? null : json["timezone"],
        companyName: json["company_name"] == null ? null : json["company_name"],
        timeZoneName: json["time_zone_name"] == null ? null : json["time_zone_name"],
        timeZoneCode: json["time_zone_code"] == null ? null : json["time_zone_code"],
        company: json["company"] == null ? null : Company.fromJson(json["company"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "company_id": companyId == null ? null : companyId,
        "name": name == null ? null : name,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "radius": radius == null ? null : radius,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "location": location == null ? null : location,
        "building": building == null ? null : building,
        "level_approval_cnc": levelApprovalCnc == null ? null : levelApprovalCnc,
        "level_approval_overtime": levelApprovalOvertime == null ? null : levelApprovalOvertime,
        "level_approval_leave": levelApprovalLeave == null ? null : levelApprovalLeave,
        "code": code == null ? null : code,
        "condition_cnc": conditionCnc == null ? null : conditionCnc,
        "condition_overtime": conditionOvertime == null ? null : conditionOvertime,
        "condition_leave": conditionLeave == null ? null : conditionLeave,
        "timezone": timezone == null ? null : timezone,
        "company_name": companyName == null ? null : companyName,
        "time_zone_name": timeZoneName == null ? null : timeZoneName,
        "time_zone_code": timeZoneCode == null ? null : timeZoneCode,
        "company": company == null ? null : company?.toJson(),
    };
}

class Company {
    Company({
        this.id,
        this.code,
        this.name,
        this.email,
        this.contact,
        this.address,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    int? id;
    String? code;
    String? name;
    String? email;
    String? contact;
    dynamic address;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;

    factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        contact: json["contact"] == null ? null : json["contact"],
        address: json["address"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "contact": contact == null ? null : contact,
        "address": address,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
    };
}

class Task {
    Task({
        this.id,
        this.taskTypeId,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.taskType,
    });

    int? id;
    int? taskTypeId;
    String? name;
    DateTime? createdAt;
    dynamic updatedAt;
    dynamic deletedAt;
    TaskType? taskType;

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"] == null ? null : json["id"],
        taskTypeId: json["task_type_id"] == null ? null : json["task_type_id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        taskType: json["task_type"] == null ? null : TaskType.fromJson(json["task_type"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "task_type_id": taskTypeId == null ? null : taskTypeId,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "task_type": taskType == null ? null : taskType?.toJson(),
    };
}

class TaskType {
    TaskType({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.typeTask,
        this.isGeneralTask,
    });

    int? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    String? typeTask;
    bool? isGeneralTask;

    factory TaskType.fromJson(Map<String, dynamic> json) => TaskType(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        typeTask: json["type_task"] == null ? null : json["type_task"],
        isGeneralTask: json["is_general_task"] == null ? null : json["is_general_task"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "type_task": typeTask == null ? null : typeTask,
        "is_general_task": isGeneralTask == null ? null : isGeneralTask,
    };
}

class UserTad {
    UserTad({
        this.id,
        this.userTypeId,
        this.positionId,
        this.name,
        this.simid,
        this.email,
        this.emailVerifiedAt,
        this.currentTeamId,
        this.profilePhotoPath,
        this.createdAt,
        this.updatedAt,
        this.fcmToken,
    });

    int? id;
    int? userTypeId;
    int? positionId;
    String? name;
    String? simid;
    String? email;
    dynamic emailVerifiedAt;
    dynamic currentTeamId;
    dynamic profilePhotoPath;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic fcmToken;

    factory UserTad.fromJson(Map<String, dynamic> json) => UserTad(
        id: json["id"] == null ? null : json["id"],
        userTypeId: json["user_type_id"] == null ? null : json["user_type_id"],
        positionId: json["position_id"] == null ? null : json["position_id"],
        name: json["name"] == null ? null : json["name"],
        simid: json["simid"] == null ? null : json["simid"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        currentTeamId: json["current_team_id"],
        profilePhotoPath: json["profile_photo_path"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        fcmToken: json["fcm_token"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_type_id": userTypeId == null ? null : userTypeId,
        "position_id": positionId == null ? null : positionId,
        "name": name == null ? null : name,
        "simid": simid == null ? null : simid,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "current_team_id": currentTeamId,
        "profile_photo_path": profilePhotoPath,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "fcm_token": fcmToken,
    };
}
