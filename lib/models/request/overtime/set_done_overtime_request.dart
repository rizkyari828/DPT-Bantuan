// To parse this JSON data, do
//
//     final setDoneOvertimeRequest = setDoneOvertimeRequestFromJson(jsonString);

import 'dart:convert';

SetDoneOvertimeRequest setDoneOvertimeRequestFromJson(String str) =>
    SetDoneOvertimeRequest.fromJson(json.decode(str));

String setDoneOvertimeRequestToJson(SetDoneOvertimeRequest data) =>
    json.encode(data.toJson());

class SetDoneOvertimeRequest {
  SetDoneOvertimeRequest({
    required this.overtimeRoomPhotos,
  });

  List<OvertimeRoomPhoto> overtimeRoomPhotos;

  factory SetDoneOvertimeRequest.fromJson(Map<String, dynamic> json) =>
      SetDoneOvertimeRequest(
        overtimeRoomPhotos: List<OvertimeRoomPhoto>.from(
            json["overtime_room_photos"]
                .map((x) => OvertimeRoomPhoto.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "overtime_room_photos":
            List<dynamic>.from(overtimeRoomPhotos.map((x) => x.toJson())),
      };
}

class OvertimeRoomPhoto {
  OvertimeRoomPhoto({
    this.name,
    this.base64BeforePhotos,
    this.base64AfterPhotos,
  });

  String? name;
  List<String>? base64BeforePhotos;
  List<String>? base64AfterPhotos;

  factory OvertimeRoomPhoto.fromJson(Map<String, dynamic> json) =>
      OvertimeRoomPhoto(
        name: json["name"],
        base64BeforePhotos:
            List<String>.from(json["base64_before_photos"].map((x) => x)),
        base64AfterPhotos:
            List<String>.from(json["base64_after_photos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "base64_before_photos":
            List<dynamic>.from(base64BeforePhotos!.map((x) => x)),
        "base64_after_photos":
            List<dynamic>.from(base64AfterPhotos!.map((x) => x)),
      };
}
