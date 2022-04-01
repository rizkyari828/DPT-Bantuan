// To parse this JSON data, do
//
//     final createTaskListGeneralRequest = createTaskListGeneralRequestFromJson(jsonString);

import 'dart:convert';

CreateTaskListGeneralRequest createTaskListGeneralRequestFromJson(String str) => CreateTaskListGeneralRequest.fromJson(json.decode(str));

String createTaskListGeneralRequestToJson(CreateTaskListGeneralRequest data) => json.encode(data.toJson());

class CreateTaskListGeneralRequest {
    CreateTaskListGeneralRequest({
        this.typeTaskId,
        this.taskId,
        this.note,
        this.startTime,
        this.endTime,
        this.branchId,
    });

    int? typeTaskId;
    int? taskId;
    String? note;
    String? startTime;
    String? endTime;
    int? branchId;

    factory CreateTaskListGeneralRequest.fromJson(Map<String, dynamic> json) => CreateTaskListGeneralRequest(
        typeTaskId: json["type_task_id"] == null ? null : json["type_task_id"],
        taskId: json["task_id"] == null ? null : json["task_id"],
        note: json["note"] == null ? null : json["note"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        branchId: json["branch_id"] == null ? null : json["branch_id"],
    );

    Map<String, dynamic> toJson() => {
        "type_task_id": typeTaskId == null ? null : typeTaskId,
        "task_id": taskId == null ? null : taskId,
        "note": note == null ? null : note,
        "start_time": startTime == null ? null : startTime,
        "end_time": endTime == null ? null : endTime,
        "branch_id": branchId == null ? null : branchId,
    };
}
