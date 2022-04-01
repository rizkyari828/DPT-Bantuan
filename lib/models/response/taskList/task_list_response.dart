// To parse this JSON data, do
//
//     final taskListResponse = taskListResponseFromJson(jsonString);

import 'dart:convert';

TaskListResponse taskListResponseFromJson(String str) => TaskListResponse.fromJson(json.decode(str));

String taskListResponseToJson(TaskListResponse data) => json.encode(data.toJson());

class TaskListResponse {
    TaskListResponse({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    List<TaskListData>? data;

    factory TaskListResponse.fromJson(Map<String, dynamic> json) => TaskListResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : List<TaskListData>.from(json["data"].map((x) => TaskListData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class TaskListData {
    TaskListData({
        this.id,
        this.taskId,
        this.startTime,
        this.endTime,
        this.task,
    });

    int? id;
    int? taskId;
    String? startTime;
    String? endTime;
    Task? task;

    factory TaskListData.fromJson(Map<String, dynamic> json) => TaskListData(
        id: json["id"] == null ? null : json["id"],
        taskId: json["task_id"] == null ? null : json["task_id"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        task: json["task"] == null ? null : Task.fromJson(json["task"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "task_id": taskId == null ? null : taskId,
        "start_time": startTime == null ? null : startTime,
        "end_time": endTime == null ? null : endTime,
        "task": task == null ? null : task?.toJson(),
    };
}

class Task {
    Task({
        this.id,
        this.taskTypeId,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.taskType,
    });

    int? id;
    int? taskTypeId;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    TaskType? taskType;

    factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"] == null ? null : json["id"],
        taskTypeId: json["task_type_id"] == null ? null : json["task_type_id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        taskType: json["task_type"] == null ? null : TaskType.fromJson(json["task_type"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "task_type_id": taskTypeId == null ? null : taskTypeId,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "task_type": taskType == null ? null : taskType?.toJson(),
    };
}

class TaskType {
    TaskType({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.typeTask,
        this.isGeneralTask,
    });

    int? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    String? typeTask;
    bool? isGeneralTask;

    factory TaskType.fromJson(Map<String, dynamic> json) => TaskType(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        typeTask: json["type_task"] == null ? null : json["type_task"],
        isGeneralTask: json["is_general_task"] == null ? null : json["is_general_task"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "type_task": typeTask == null ? null : typeTask,
        "is_general_task": isGeneralTask == null ? null : isGeneralTask,
    };
}
