// To parse this JSON data, do
//
//     final categoryCnCResponse = categoryCnCResponseFromJson(jsonString);

import 'dart:convert';

CategoryCnCResponse categoryCnCResponseFromJson(String str) => CategoryCnCResponse.fromJson(json.decode(str));

String categoryCnCResponseToJson(CategoryCnCResponse data) => json.encode(data.toJson());

class CategoryCnCResponse {
    CategoryCnCResponse({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    List<CategoryCnCData>? data;

    factory CategoryCnCResponse.fromJson(Map<String, dynamic> json) => CategoryCnCResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<CategoryCnCData>.from(json["data"].map((x) => CategoryCnCData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class CategoryCnCData {
    CategoryCnCData({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
    });

    int? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;

    factory CategoryCnCData.fromJson(Map<String, dynamic> json) => CategoryCnCData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
    };
}
