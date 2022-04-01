// To parse this JSON data, do
//
//     final branchListResponse = branchListResponseFromJson(jsonString);

import 'dart:convert';

BranchListResponse branchListResponseFromJson(String str) =>
    BranchListResponse.fromJson(json.decode(str));

String branchListResponseToJson(BranchListResponse data) =>
    json.encode(data.toJson());

class BranchListResponse {
  BranchListResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<BranchListData>? data;

  factory BranchListResponse.fromJson(Map<String, dynamic> json) =>
      BranchListResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<BranchListData>.from(
                json["data"].map((x) => BranchListData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class BranchListData {
  BranchListData({
    this.id,
    this.companyId,
    this.name,
    this.longitude,
    this.latitude,
    this.radius,
    this.createdAt,
    this.updatedAt,
    this.location,
    this.building,
    this.code,
    this.conditionCnc,
    this.conditionOvertime,
    this.conditionLeave,
    this.companyName,
  });

  int? id;
  int? companyId;
  String? name;
  dynamic longitude;
  dynamic latitude;
  int? radius;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? location;
  String? building;
  String? code;
  dynamic conditionCnc;
  dynamic conditionOvertime;
  dynamic conditionLeave;
  String? companyName;

  factory BranchListData.fromJson(Map<String, dynamic> json) => BranchListData(
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
        location: json["location"] == null ? null : json["location"],
        building: json["building"] == null ? null : json["building"],
        code: json["code"] == null ? null : json["code"],
        conditionCnc: json["condition_cnc"],
        conditionOvertime: json["condition_overtime"],
        conditionLeave: json["condition_leave"],
        companyName: json["company_name"] == null ? null : json["company_name"],
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
        "location": location == null ? null : location,
        "building": building == null ? null : building,
        "code": code == null ? null : code,
        "condition_cnc": conditionCnc,
        "condition_overtime": conditionOvertime,
        "condition_leave": conditionLeave,
        "company_name": companyName == null ? null : companyName,
      };
}
