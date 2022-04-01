// To parse this JSON data, do
//
//     final nameTaskListResponse = nameTaskListResponseFromJson(jsonString);

import 'dart:convert';

NameTaskListResponse nameTaskListResponseFromJson(String str) => NameTaskListResponse.fromJson(json.decode(str));

String nameTaskListResponseToJson(NameTaskListResponse data) => json.encode(data.toJson());

class NameTaskListResponse {
    NameTaskListResponse({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    List<TaskNameData>? data;

    factory NameTaskListResponse.fromJson(Map<String, dynamic> json) => NameTaskListResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<TaskNameData>.from(json["data"].map((x) => TaskNameData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class TaskNameData {
    TaskNameData({
        this.id,
        this.taskTypeId,
        this.name,
    });

    int? id;
    int? taskTypeId;
    String? name;

    factory TaskNameData.fromJson(Map<String, dynamic> json) => TaskNameData(
        id: json["id"] == null ? null : json["id"],
        taskTypeId: json["task_type_id"] == null ? null : json["task_type_id"],
        name: json["name"] == null ? null : json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "task_type_id": taskTypeId == null ? null : taskTypeId,
        "name": name == null ? null : name,
    };
}
