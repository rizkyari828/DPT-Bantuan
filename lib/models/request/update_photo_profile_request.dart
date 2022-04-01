// To parse this JSON data, do
//
//     final updatePhotoProfileRequest = updatePhotoProfileRequestFromJson(jsonString);

import 'dart:convert';

UpdatePhotoProfileRequest updatePhotoProfileRequestFromJson(String str) => UpdatePhotoProfileRequest.fromJson(json.decode(str));

String updatePhotoProfileRequestToJson(UpdatePhotoProfileRequest data) => json.encode(data.toJson());

class UpdatePhotoProfileRequest {
    UpdatePhotoProfileRequest({
        this.base64Photo,
    });

    String? base64Photo;

    factory UpdatePhotoProfileRequest.fromJson(Map<String, dynamic> json) => UpdatePhotoProfileRequest(
        base64Photo: json["base64_photo"] == null ? null : json["base64_photo"],
    );

    Map<String, dynamic> toJson() => {
        "base64_photo": base64Photo == null ? null : base64Photo,
    };
}
