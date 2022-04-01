// To parse this JSON data, do
//
//     final nameTadListResponse = nameTadListResponseFromJson(jsonString);

import 'dart:convert';

NameTadListResponse nameTadListResponseFromJson(String str) => NameTadListResponse.fromJson(json.decode(str));

String nameTadListResponseToJson(NameTadListResponse data) => json.encode(data.toJson());

class NameTadListResponse {
    NameTadListResponse({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    List<BranchTadListData>? data;

    factory NameTadListResponse.fromJson(Map<String, dynamic> json) => NameTadListResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<BranchTadListData>.from(json["data"].map((x) => BranchTadListData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class BranchTadListData {
    BranchTadListData({
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

    factory BranchTadListData.fromJson(Map<String, dynamic> json) => BranchTadListData(
        id: json["id"] == null ? null : json["id"],
        userTypeId: json["user_type_id"] == null ? null : json["user_type_id"],
        positionId: json["position_id"] == null ? null : json["position_id"],
        name: json["name"] == null ? null : json["name"],
        simid: json["simid"] == null ? null : json["simid"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        currentTeamId: json["current_team_id"],
        profilePhotoPath: json["profile_photo_path"] == null ? null : json["profile_photo_path"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
        "profile_photo_path": profilePhotoPath == null ? null : profilePhotoPath,
        "created_at": createdAt == null ? null : createdAt!.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt!.toIso8601String(),
    };
}
