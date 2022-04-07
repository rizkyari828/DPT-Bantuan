// To parse this JSON data, do
//
//     final taskListTadResponse = taskListTadResponseFromJson(jsonString);

import 'dart:convert';

TaskListTadResponse taskListTadResponseFromJson(String str) =>
    TaskListTadResponse.fromJson(json.decode(str));

String taskListTadResponseToJson(TaskListTadResponse data) =>
    json.encode(data.toJson());

class TaskListTadResponse {
  TaskListTadResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<TaskListTadData>? data;

  factory TaskListTadResponse.fromJson(Map<String, dynamic> json) =>
      TaskListTadResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<TaskListTadData>.from(
                json["data"].map((x) => TaskListTadData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class TaskListTadData {
  TaskListTadData({
    this.id,
    this.taskId,
    this.startTime,
    this.endTime,
    this.createdAt,
    this.updatedAt,
    this.task,
    this.beforePhotos,
    this.afterPhotos,
    this.status,
    this.noteTad,
    this.statusLabel,
  });

  int? id;
  int? taskId;
  String? startTime;
  String? endTime;
  DateTime? createdAt;
  DateTime? updatedAt;
  Task? task;
  List<dynamic>? beforePhotos;
  List<dynamic>? afterPhotos;
  String? status;
  String? noteTad;
  String? statusLabel;

  factory TaskListTadData.fromJson(Map<String, dynamic> json) =>
      TaskListTadData(
        id: json["id"] == null ? null : json["id"],
        taskId: json["task_id"] == null ? null : json["task_id"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        task: json["task"] == null ? null : Task.fromJson(json["task"]),
        beforePhotos: json["before_photos"] == null
            ? null
            : List<dynamic>.from(json["before_photos"].map((x) => x)),
        afterPhotos: json["after_photos"] == null
            ? null
            : List<dynamic>.from(json["after_photos"].map((x) => x)),
        status: json["status"] == null ? null : json["status"],
        noteTad: json["note_tad"] == null ? null : json["note_tad"],
        statusLabel: json["status_label"] == null ? null : json["status_label"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "task_id": taskId == null ? null : taskId,
        "start_time": startTime == null ? null : startTime,
        "end_time": endTime == null ? null : endTime,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "task": task == null ? null : task?.toJson(),
        "before_photos": beforePhotos == null
            ? null
            : List<dynamic>.from(beforePhotos!.map((x) => x)),
        "after_photos": afterPhotos == null
            ? null
            : List<dynamic>.from(afterPhotos!.map((x) => x)),
        "status": status == null ? null : status,
        "note_tad": noteTad == null ? null : noteTad,
        "status_label": statusLabel == null ? null : statusLabel,
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        taskType: json["task_type"] == null
            ? null
            : TaskType.fromJson(json["task_type"]),
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        typeTask: json["type_task"] == null ? null : json["type_task"],
        isGeneralTask:
            json["is_general_task"] == null ? null : json["is_general_task"],
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
