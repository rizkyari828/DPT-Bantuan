// To parse this JSON data, do
//
//     final showReviewRateResponse = showReviewRateResponseFromJson(jsonString);

import 'dart:convert';

ShowReviewRateResponse showReviewRateResponseFromJson(String str) => ShowReviewRateResponse.fromJson(json.decode(str));

String showReviewRateResponseToJson(ShowReviewRateResponse data) => json.encode(data.toJson());

class ShowReviewRateResponse {
    ShowReviewRateResponse({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    ShowReviewRateData? data;

    factory ShowReviewRateResponse.fromJson(Map<String, dynamic> json) => ShowReviewRateResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : ShowReviewRateData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
    };
}

class ShowReviewRateData {
    ShowReviewRateData({
        this.id,
        this.type,
        this.rate,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.branchId,
        this.companyId,
        this.branch,
    });

    int? id;
    String? type;
    int? rate;
    dynamic note;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    int? branchId;
    int? companyId;
    Branch? branch;

    factory ShowReviewRateData.fromJson(Map<String, dynamic> json) => ShowReviewRateData(
        id: json["id"] == null ? null : json["id"],
        type: json["type"] == null ? null : json["type"],
        rate: json["rate"] == null ? null : json["rate"],
        note: json["note"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
        companyId: json["company_id"] == null ? null : json["company_id"],
        branch: json["branch"] == null ? null : Branch.fromJson(json["branch"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "type": type == null ? null : type,
        "rate": rate == null ? null : rate,
        "note": note,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "branch_id": branchId == null ? null : branchId,
        "company_id": companyId == null ? null : companyId,
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
