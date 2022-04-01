// To parse this JSON data, do
//
//     final typeTaskListResponse = typeTaskListResponseFromJson(jsonString);

import 'dart:convert';

TypeTaskListResponse typeTaskListResponseFromJson(String str) => TypeTaskListResponse.fromJson(json.decode(str));

String typeTaskListResponseToJson(TypeTaskListResponse data) => json.encode(data.toJson());

class TypeTaskListResponse {
    TypeTaskListResponse({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    List<TypeTaskData>? data;

    factory TypeTaskListResponse.fromJson(Map<String, dynamic> json) => TypeTaskListResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<TypeTaskData>.from(json["data"].map((x) => TypeTaskData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class TypeTaskData {
    TypeTaskData({
        this.id,
        this.name,
        this.isGeneralTask,
    });

    int? id;
    String? name;
    bool? isGeneralTask;

    factory TypeTaskData.fromJson(Map<String, dynamic> json) => TypeTaskData(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        isGeneralTask: json["is_general_task"] == null ? null : json["is_general_task"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "is_general_task": isGeneralTask == null ? null : isGeneralTask,
    };
}
