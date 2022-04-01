// To parse this JSON data, do
//
//     final cnCItemResponse = cnCItemResponseFromJson(jsonString);

import 'dart:convert';

CnCItemResponse cnCItemResponseFromJson(String str) => CnCItemResponse.fromJson(json.decode(str));

String cnCItemResponseToJson(CnCItemResponse data) => json.encode(data.toJson());

class CnCItemResponse {
    CnCItemResponse({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    List<ListItem>? data;

    factory CnCItemResponse.fromJson(Map<String, dynamic> json) => CnCItemResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<ListItem>.from(json["data"].map((x) => ListItem.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class ListItem {
    ListItem({
        this.id,
        this.name,
        this.unitTypeId,
        this.unitTypeName,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? name;
    int? unitTypeId;
    String? unitTypeName;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        unitTypeId: json["unit_type_id"] == null ? null : json["unit_type_id"],
        unitTypeName: json["unit_type_name"] == null ? null : json["unit_type_name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "unit_type_id": unitTypeId == null ? null : unitTypeId,
        "unit_type_name": unitTypeName == null ? null : unitTypeName,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    };
}
