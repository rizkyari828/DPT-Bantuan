// To parse this JSON data, do
//
//     final overtimeResponse = overtimeResponseFromJson(jsonString);

import 'dart:convert';

OvertimeResponse overtimeResponseFromJson(String str) =>
    OvertimeResponse.fromJson(json.decode(str));

String overtimeResponseToJson(OvertimeResponse data) =>
    json.encode(data.toJson());

class OvertimeResponse {
  OvertimeResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<DataOvertime>? data;

  factory OvertimeResponse.fromJson(Map<String, dynamic> json) =>
      OvertimeResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataOvertime>.from(
                json["data"].map((x) => DataOvertime.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataOvertime {
  DataOvertime({
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
    this.noteApproval,
    this.statusLabel,
    this.branchName,
    this.userTad,
    this.approvalHistory,
  });

  int? id;
  String? code;
  DateTime? dateRequest;
  DateTime? startTime;
  DateTime? endTime;
  String? note;
  String? actualTime;
  String? totalTime;
  dynamic userClientId;
  int? userClientBranchId;
  int? userCoordinatorId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? noteApproval;
  String? statusLabel;
  String? branchName;
  UserTad? userTad;
  List<ApprovalHistory>? approvalHistory;

  factory DataOvertime.fromJson(Map<String, dynamic> json) => DataOvertime(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        dateRequest: json["date_request"] == null
            ? null
            : DateTime.parse(json["date_request"]),
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        endTime:
            json["end_time"] == null ? null : DateTime.parse(json["end_time"]),
        note: json["note"] == null ? null : json["note"],
        actualTime: json["actual_time"] == null ? null : json["actual_time"],
        totalTime: json["total_time"] == null ? null : json["total_time"],
        userClientId: json["user_client_id"],
        userClientBranchId: json["user_client_branch_id"] == null
            ? null
            : json["user_client_branch_id"],
        userCoordinatorId: json["user_coordinator_id"] == null
            ? null
            : json["user_coordinator_id"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        noteApproval:
            json["note_approval"] == null ? null : json["note_approval"],
        statusLabel: json["status_label"] == null ? null : json["status_label"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
        userTad: json["user_tad"] == null
            ? null
            : UserTad.fromJson(json["user_tad"]),
        approvalHistory: json["approval_history"] == null
            ? null
            : List<ApprovalHistory>.from(json["approval_history"]
                .map((x) => ApprovalHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "date_request": dateRequest == null
            ? null
            : "${dateRequest?.year.toString().padLeft(4, '0')}-${dateRequest?.month.toString().padLeft(2, '0')}-${dateRequest?.day.toString().padLeft(2, '0')}",
        "start_time": startTime == null ? null : startTime?.toIso8601String(),
        "end_time": endTime == null ? null : endTime?.toIso8601String(),
        "note": note == null ? null : note,
        "actual_time": actualTime == null ? null : actualTime,
        "total_time": totalTime == null ? null : totalTime,
        "user_client_id": userClientId,
        "user_client_branch_id":
            userClientBranchId == null ? null : userClientBranchId,
        "user_coordinator_id":
            userCoordinatorId == null ? null : userCoordinatorId,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "note_approval": noteApproval == null ? null : noteApproval,
        "status_label": statusLabel == null ? null : statusLabel,
        "branch_name": branchName == null ? null : branchName,
        "user_tad": userTad == null ? null : userTad?.toJson(),
        "approval_history": approvalHistory == null
            ? null
            : List<dynamic>.from(approvalHistory!.map((x) => x.toJson())),
      };
}

class ApprovalHistory {
  ApprovalHistory({
    this.id,
    this.requestId,
    this.userApprovalId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.type,
    this.condition,
    this.currentLevel,
    this.level,
  });

  int? id;
  int? requestId;
  int? userApprovalId;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? type;
  dynamic condition;
  String? currentLevel;
  dynamic level;

  factory ApprovalHistory.fromJson(Map<String, dynamic> json) =>
      ApprovalHistory(
        id: json["id"] == null ? null : json["id"],
        requestId: json["request_id"] == null ? null : json["request_id"],
        userApprovalId:
            json["user_approval_id"] == null ? null : json["user_approval_id"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        type: json["type"] == null ? null : json["type"],
        condition: json["condition"],
        currentLevel:
            json["current_level"] == null ? null : json["current_level"],
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "request_id": requestId == null ? null : requestId,
        "user_approval_id": userApprovalId == null ? null : userApprovalId,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "type": type == null ? null : type,
        "condition": condition,
        "current_level": currentLevel == null ? null : currentLevel,
        "level": level,
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
    this.userTadInformation,
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
  String? fcmToken;
  UserTadInformation? userTadInformation;

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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
        userTadInformation: json["user_tad_information"] == null
            ? null
            : UserTadInformation.fromJson(json["user_tad_information"]),
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
        "fcm_token": fcmToken == null ? null : fcmToken,
        "user_tad_information":
            userTadInformation == null ? null : userTadInformation?.toJson(),
      };
}

class UserTadInformation {
  UserTadInformation({
    this.id,
    this.userId,
    this.branchId,
    this.typeZone,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.branch,
  });

  int? id;
  int? userId;
  int? branchId;
  String? typeZone;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  Branch? branch;

  factory UserTadInformation.fromJson(Map<String, dynamic> json) =>
      UserTadInformation(
        id: json["id"] == null ? null : json["id"],
        userId: json["user_id"] == null ? null : json["user_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        typeZone: json["type_zone"] == null ? null : json["type_zone"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_id": userId == null ? null : userId,
        "branch_id": branchId == null ? null : branchId,
        "type_zone": typeZone == null ? null : typeZone,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "branch": branch == null ? null : branch?.toJson(),
      };
}

class Branch {
  Branch({
    this.id,
    this.companyId,
    this.name,
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
        radius: json["radius"] == null ? null : json["radius"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        location: json["location"] == null ? null : json["location"],
        building: json["building"] == null ? null : json["building"],
        levelApprovalCnc: json["level_approval_cnc"] == null
            ? null
            : json["level_approval_cnc"],
        levelApprovalOvertime: json["level_approval_overtime"] == null
            ? null
            : json["level_approval_overtime"],
        levelApprovalLeave: json["level_approval_leave"] == null
            ? null
            : json["level_approval_leave"],
        code: json["code"] == null ? null : json["code"],
        conditionCnc:
            json["condition_cnc"] == null ? null : json["condition_cnc"],
        conditionOvertime: json["condition_overtime"] == null
            ? null
            : json["condition_overtime"],
        conditionLeave:
            json["condition_leave"] == null ? null : json["condition_leave"],
        timezone: json["timezone"] == null ? null : json["timezone"],
        companyName: json["company_name"] == null ? null : json["company_name"],
        timeZoneName:
            json["time_zone_name"] == null ? null : json["time_zone_name"],
        timeZoneCode:
            json["time_zone_code"] == null ? null : json["time_zone_code"],
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "company_id": companyId == null ? null : companyId,
        "name": name == null ? null : name,
        "radius": radius == null ? null : radius,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "location": location == null ? null : location,
        "building": building == null ? null : building,
        "level_approval_cnc":
            levelApprovalCnc == null ? null : levelApprovalCnc,
        "level_approval_overtime":
            levelApprovalOvertime == null ? null : levelApprovalOvertime,
        "level_approval_leave":
            levelApprovalLeave == null ? null : levelApprovalLeave,
        "code": code == null ? null : code,
        "condition_cnc": conditionCnc == null ? null : conditionCnc,
        "condition_overtime":
            conditionOvertime == null ? null : conditionOvertime,
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
