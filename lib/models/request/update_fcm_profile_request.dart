// To parse this JSON data, do
//
//     final updateFcmProfileRequest = updateFcmProfileRequestFromJson(jsonString);

import 'dart:convert';

UpdateFcmProfileRequest updateFcmProfileRequestFromJson(String str) => UpdateFcmProfileRequest.fromJson(json.decode(str));

String updateFcmProfileRequestToJson(UpdateFcmProfileRequest data) => json.encode(data.toJson());

class UpdateFcmProfileRequest {
    UpdateFcmProfileRequest({
        this.fcmToken,
    });

    String? fcmToken;

    factory UpdateFcmProfileRequest.fromJson(Map<String, dynamic> json) => UpdateFcmProfileRequest(
        fcmToken: json["fcm_token"] == null ? null : json["fcm_token"],
    );

    Map<String, dynamic> toJson() => {
        "fcm_token": fcmToken == null ? null : fcmToken,
    };
}
