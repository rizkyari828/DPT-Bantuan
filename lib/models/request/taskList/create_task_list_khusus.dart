// To parse this JSON data, do
//
//     final createTaskListKhususRequest = createTaskListKhususRequestFromJson(jsonString);

import 'dart:convert';

CreateTaskListKhususRequest createTaskListKhususRequestFromJson(String str) => CreateTaskListKhususRequest.fromJson(json.decode(str));

String createTaskListKhususRequestToJson(CreateTaskListKhususRequest data) => json.encode(data.toJson());

class CreateTaskListKhususRequest {
    CreateTaskListKhususRequest({
        this.typeTaskId,
        this.taskId,
        this.note,
        this.startTime,
        this.endTime,
        this.date,
        this.userId,
    });

    int? typeTaskId;
    int? taskId;
    String? note;
    String? startTime;
    String? endTime;
    String? date;
    int? userId;

    factory CreateTaskListKhususRequest.fromJson(Map<String, dynamic> json) => CreateTaskListKhususRequest(
        typeTaskId: json["type_task_id"] == null ? null : json["type_task_id"],
        taskId: json["task_id"] == null ? null : json["task_id"],
        note: json["note"] == null ? null : json["note"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        date: json["date"] == null ? null : json["date"],
        userId: json["user_id"] == null ? null : json["user_id"],
    );

    Map<String, dynamic> toJson() => {
        "type_task_id": typeTaskId == null ? null : typeTaskId,
        "task_id": taskId == null ? null : taskId,
        "note": note == null ? null : note,
        "start_time": startTime == null ? null : startTime,
        "end_time": endTime == null ? null : endTime,
        "date": date == null ? null : date,
        "user_id": userId == null ? null : userId,
    };
}
