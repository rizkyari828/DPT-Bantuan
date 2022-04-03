// To parse this JSON data, do
//
//     final updateProfileResponse = updateProfileResponseFromJson(jsonString);

import 'dart:convert';

UpdateProfileResponse updateProfileResponseFromJson(String str) =>
    UpdateProfileResponse.fromJson(json.decode(str));

String updateProfileResponseToJson(UpdateProfileResponse data) =>
    json.encode(data.toJson());

class UpdateProfileResponse {
  UpdateProfileResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  UpdateProfileData? data;

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) =>
      UpdateProfileResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : UpdateProfileData.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class UpdateProfileData {
  UpdateProfileData({
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
  String? profilePhotoPath;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fcmToken;

  factory UpdateProfileData.fromJson(Map<String, dynamic> json) =>
      UpdateProfileData(
        id: json["id"] == null ? null : json["id"],
        userTypeId: json["user_type_id"] == null ? null : json["user_type_id"],
        positionId: json["position_id"] == null ? null : json["position_id"],
        name: json["name"] == null ? null : json["name"],
        simid: json["simid"] == null ? null : json["simid"],
        email: json["email"] == null ? null : json["email"],
        emailVerifiedAt: json["email_verified_at"],
        currentTeamId: json["current_team_id"],
        profilePhotoPath: json["profile_photo_path"] == null
            ? null
            : json["profile_photo_path"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
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
        "profile_photo_path":
            profilePhotoPath == null ? null : profilePhotoPath,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "fcm_token": fcmToken == null ? null : fcmToken,
      };
}
