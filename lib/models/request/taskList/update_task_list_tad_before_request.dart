// To parse this JSON data, do
//
//     final updateTaskListTadBeforeRequest = updateTaskListTadBeforeRequestFromJson(jsonString);

import 'dart:convert';

UpdateTaskListTadBeforeRequest updateTaskListTadBeforeRequestFromJson(String str) => UpdateTaskListTadBeforeRequest.fromJson(json.decode(str));

String updateTaskListTadBeforeRequestToJson(UpdateTaskListTadBeforeRequest data) => json.encode(data.toJson());

class UpdateTaskListTadBeforeRequest {
    UpdateTaskListTadBeforeRequest({
        this.base64BeforePhotos,
    });

    List<String>? base64BeforePhotos;

    factory UpdateTaskListTadBeforeRequest.fromJson(Map<String, dynamic> json) => UpdateTaskListTadBeforeRequest(
        base64BeforePhotos: json["base64_before_photos"] == null ? null : List<String>.from(json["base64_before_photos"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "base64_before_photos": base64BeforePhotos == null ? null : List<dynamic>.from(base64BeforePhotos!.map((x) => x)),
    };
}
