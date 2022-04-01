// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String? loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
    LoginResponse({
        this.error,
        this.message,
        required this.token,
        this.tokenType,
        this.data,
    });

    bool? error;
    String? message;
    String token;
    String? tokenType;
    Data? data;

    factory LoginResponse.fromJson(Map<String?, dynamic> json) => LoginResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        token: json["access_token"] == null ? null : json["access_token"],
        tokenType: json["token_type"] == null ? null : json["token_type"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String?, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "access_token": token,
        "token_type": tokenType == null ? null : tokenType,
        "data": data == null ? null : data?.toJson(),
    };
}

class Data {
    Data({
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
        this.branch,
        this.company,
        this.userType,
    });

    int? id;
    int? userTypeId;
    int? positionId;
    String? name;
    String? simid;
    String? email;
    dynamic emailVerifiedAt;
    dynamic currentTeamId;
    String? profilePhotoPath;
    DateTime? createdAt;
    DateTime? updatedAt;
    List<Branch>? branch;
    Company? company;
    Company? userType;

    factory Data.fromJson(Map<String?, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        userTypeId: json["user_type_id"] == null ? null : json["user_type_id"],
        positionId: json["position_id"],
        name: json["name"] == null ? null : json["name"],
        simid: json["simid"] == null ? null : json["simid"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        currentTeamId: json["current_team_id"],
        profilePhotoPath: json["profile_photo_path"] == null ? null : json["profile_photo_path"],
        createdAt: json["created_at"] == null ? null : DateTime?.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime?.parse(json["updated_at"]),
        branch: json["branch"] == null ? null : List<Branch>.from(json["branch"].map((x) => Branch.fromJson(x))),
        company: json["company"] == null ? null : Company.fromJson(json["company"]),
        userType: json["user_type"] == null ? null : Company.fromJson(json["user_type"]),
    );

    Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "user_type_id": userTypeId == null ? null : userTypeId,
        "position_id": positionId,
        "name": name == null ? null : name,
        "simid": simid == null ? null : simid,
        "email": email == null ? null : email,
        "email_verified_at": emailVerifiedAt,
        "current_team_id": currentTeamId,
        "profile_photo_path": profilePhotoPath == null ? null : profilePhotoPath,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "branch": branch == null ? null : List<dynamic>.from(branch!.map((x) => x.toJson())),
        "company": company == null ? null : company?.toJson(),
        "user_type": userType == null ? null : userType?.toJson(),
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
        this.pivot,
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
    DateTime? deletedAt;
    String? location;
    String? building;
    String? levelApprovalCnc;
    String? levelApprovalOvertime;
    String? levelApprovalLeave;
    Pivot? pivot;
    Company? company;

    factory Branch.fromJson(Map<String?, dynamic> json) => Branch(
        id: json["id"] == null ? null : json["id"],
        companyId: json["company_id"] == null ? null : json["company_id"],
        name: json["name"] == null ? null : json["name"],
        longitude: json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        radius: json["radius"] == null ? null : json["radius"],
        createdAt: json["created_at"] == null ? null : DateTime?.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime?.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null ? null : DateTime?.parse(json["delete_at"]),
        location: json["location"] == null ? null : json["location"],
        building: json["building"] == null ? null : json["building"],
        levelApprovalCnc: json["level_approval_cnc"] == null ? null : json["level_approval_cnc"],
        levelApprovalOvertime: json["level_approval_overtime"] == null ? null : json["level_approval_overtime"],
        levelApprovalLeave: json["level_approval_leave"] == null ? null : json["level_approval_leave"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
        company: json["company"] == null ? null : Company.fromJson(json["company"]),
    );

    Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "company_id": companyId == null ? null : companyId,
        "name": name == null ? null : name,
        "longitude": longitude == null ? null : longitude,
        "latitude": latitude == null ? null : latitude,
        "radius": radius == null ? null : radius,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt == null ? null : deletedAt?.toIso8601String(),
        "location": location == null ? null : location,
        "building": building == null ? null : building,
        "level_approval_cnc": levelApprovalCnc == null ? null : levelApprovalCnc,
        "level_approval_overtime": levelApprovalOvertime == null ? null : levelApprovalOvertime,
        "level_approval_leave": levelApprovalLeave == null ? null : levelApprovalLeave,
        "pivot": pivot == null ? null : pivot?.toJson(),
        "company": company == null ? null : company?.toJson(),
    };
}

class Company {
    Company({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.code,
    });

    int? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    dynamic deletedAt;
    String? code;

    factory Company.fromJson(Map<String?, dynamic> json) => Company(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null ? null : DateTime?.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime?.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null ? null : DateTime?.parse(json["delete_at"]),
        code: json["code"] == null ? null : json["code"],
    );

    Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "code": code == null ? null : code,
    };
}

class Pivot {
    Pivot({
        this.userId,
        this.branchId,
    });

    int? userId;
    int? branchId;

    factory Pivot.fromJson(Map<String?, dynamic> json) => Pivot(
        userId: json["user_id"] == null ? null : json["user_id"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
    );

    Map<String?, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "branch_id": branchId == null ? null : branchId,
    };
}
