// To parse this JSON data, do
//
//     final updateTaskListTadRequest = updateTaskListTadRequestFromJson(jsonString);

import 'dart:convert';

UpdateTaskListTadRequest updateTaskListTadRequestFromJson(String str) =>
    UpdateTaskListTadRequest.fromJson(json.decode(str));

String updateTaskListTadRequestToJson(UpdateTaskListTadRequest data) =>
    json.encode(data.toJson());

class UpdateTaskListTadRequest {
  UpdateTaskListTadRequest({
    this.base64AfterPhotos,
    this.noteTad,
  });

  List<String>? base64AfterPhotos;
  String? noteTad;

  factory UpdateTaskListTadRequest.fromJson(Map<String, dynamic> json) =>
      UpdateTaskListTadRequest(
        base64AfterPhotos: json["base64_after_photos"] == null
            ? null
            : List<String>.from(json["base64_after_photos"].map((x) => x)),
        noteTad: json["note_tad"] == null ? null : json["note_tad"],
      );

  Map<String, dynamic> toJson() => {
        "base64_after_photos": base64AfterPhotos == null
            ? null
            : List<dynamic>.from(base64AfterPhotos!.map((x) => x)),
        "note_tad": noteTad == null ? null : noteTad,
      };
}
