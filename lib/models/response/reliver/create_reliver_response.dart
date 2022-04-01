// To parse this JSON data, do
//
//     final createReliverResponse = createReliverResponseFromJson(jsonString);

import 'dart:convert';

CreateReliverResponse createReliverResponseFromJson(String str) =>
    CreateReliverResponse.fromJson(json.decode(str));

String createReliverResponseToJson(CreateReliverResponse data) =>
    json.encode(data.toJson());

class CreateReliverResponse {
  CreateReliverResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  DataCreateReliver? data;

  factory CreateReliverResponse.fromJson(Map<String, dynamic> json) =>
      CreateReliverResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : DataCreateReliver.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class DataCreateReliver {
  DataCreateReliver({
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
    this.branch,
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
  dynamic noteApproval;
  int? needEmployee;
  dynamic needAprroveEmployee;
  DateTime? dateStartWorkEmployee;
  String? status;
  String? statusLabel;
  Branch? branch;

  factory DataCreateReliver.fromJson(Map<String, dynamic> json) =>
      DataCreateReliver(
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
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
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
        "branch": branch == null ? null : branch?.toJson(),
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
    this.companyName,
    this.company,
  });

  int? id;
  int? companyId;
  String? name;
  dynamic longitude;
  dynamic latitude;
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
  dynamic conditionCnc;
  dynamic conditionOvertime;
  dynamic conditionLeave;
  String? companyName;
  Company? company;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"] == null ? null : json["id"],
        companyId: json["company_id"] == null ? null : json["company_id"],
        name: json["name"] == null ? null : json["name"],
        longitude: json["longitude"],
        latitude: json["latitude"],
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
        conditionCnc: json["condition_cnc"],
        conditionOvertime: json["condition_overtime"],
        conditionLeave: json["condition_leave"],
        companyName: json["company_name"] == null ? null : json["company_name"],
        company:
            json["company"] == null ? null : Company.fromJson(json["company"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "company_id": companyId == null ? null : companyId,
        "name": name == null ? null : name,
        "longitude": longitude,
        "latitude": latitude,
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
        "condition_cnc": conditionCnc,
        "condition_overtime": conditionOvertime,
        "condition_leave": conditionLeave,
        "company_name": companyName == null ? null : companyName,
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
  String? address;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  factory Company.fromJson(Map<String, dynamic> json) => Company(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
        email: json["email"] == null ? null : json["email"],
        contact: json["contact"] == null ? null : json["contact"],
        address: json["address"] == null ? null : json["address"],
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
        "address": address == null ? null : address,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
