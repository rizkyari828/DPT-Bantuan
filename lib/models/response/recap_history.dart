// To parse this JSON data, do
//
//     final recapHistoryResponse = recapHistoryResponseFromJson(jsonString);

import 'dart:convert';

RecapHistoryResponse recapHistoryResponseFromJson(String str) =>
    RecapHistoryResponse.fromJson(json.decode(str));

String recapHistoryResponseToJson(RecapHistoryResponse data) =>
    json.encode(data.toJson());

class RecapHistoryResponse {
  RecapHistoryResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<DataHistory>? data;

  factory RecapHistoryResponse.fromJson(Map<String, dynamic> json) =>
      RecapHistoryResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<DataHistory>.from(
                json["data"].map((x) => DataHistory.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class DataHistory {
  DataHistory({
    this.id,
    this.usersId,
    this.scheduleShiftId,
    this.dateCheckIn,
    this.dateCheckOut,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.scheduleShift,
    this.dataUserAttandance,
  });

  int? id;
  int? usersId;
  int? scheduleShiftId;
  DateTime? dateCheckIn;
  DateTime? dateCheckOut;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  ScheduleShift? scheduleShift;
  DataUserAttandance? dataUserAttandance;

  factory DataHistory.fromJson(Map<String, dynamic> json) => DataHistory(
        id: json["id"] == null ? null : json["id"],
        usersId: json["users_id"] == null ? null : json["users_id"],
        scheduleShiftId: json["schedule_shift_id"] == null
            ? null
            : json["schedule_shift_id"],
        dateCheckIn: json["date_check_in"] == null
            ? null
            : DateTime.parse(json["date_check_in"]),
        dateCheckOut: json["date_check_out"] == null
            ? null
            : DateTime.parse(json["date_check_out"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        scheduleShift: json["schedule_shift"] == null
            ? null
            : ScheduleShift.fromJson(json["schedule_shift"]),
        dataUserAttandance: json["data_user_attandance"] == null
            ? null
            : DataUserAttandance.fromJson(json["data_user_attandance"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "users_id": usersId == null ? null : usersId,
        "schedule_shift_id": scheduleShiftId == null ? null : scheduleShiftId,
        "date_check_in": dateCheckIn == null
            ? null
            : "${dateCheckIn?.year.toString().padLeft(4, '0')}-${dateCheckIn?.month.toString().padLeft(2, '0')}-${dateCheckIn?.day.toString().padLeft(2, '0')}",
        "date_check_out": dateCheckOut == null
            ? null
            : "${dateCheckOut?.year.toString().padLeft(4, '0')}-${dateCheckOut?.month.toString().padLeft(2, '0')}-${dateCheckOut?.day.toString().padLeft(2, '0')}",
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt == null ? null : deletedAt?.toIso8601String(),
        "schedule_shift":
            scheduleShift == null ? null : scheduleShift?.toJson(),
        "data_user_attandance":
            dataUserAttandance == null ? null : dataUserAttandance?.toJson(),
      };
}

class DataUserAttandance {
  DataUserAttandance({
    this.id,
    this.scheduleId,
    this.usersId,
    this.attendenceStatusId,
    this.checkIn,
    this.checkOut,
    this.dateAttendence,
    this.longitudeCheckIn,
    this.longitudeCheckOut,
    this.latitudeCheckIn,
    this.latitudeCheckOut,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.attendenceStatus,
  });

  int? id;
  int? scheduleId;
  int? usersId;
  int? attendenceStatusId;
  DateTime? checkIn;
  DateTime? checkOut;
  DateTime? dateAttendence;
  double? longitudeCheckIn;
  double? longitudeCheckOut;
  double? latitudeCheckIn;
  double? latitudeCheckOut;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  AttendenceStatus? attendenceStatus;

  factory DataUserAttandance.fromJson(Map<String, dynamic> json) =>
      DataUserAttandance(
        id: json["id"] == null ? null : json["id"],
        scheduleId: json["schedule_id"] == null ? null : json["schedule_id"],
        usersId: json["users_id"] == null ? null : json["users_id"],
        attendenceStatusId: json["attendence_status_id"] == null
            ? null
            : json["attendence_status_id"],
        checkIn:
            json["check_in"] == null ? null : DateTime.parse(json["check_in"]),
        checkOut: json["check_out"] == null
            ? null
            : DateTime.parse(json["check_out"]),
        dateAttendence: json["date_attendence"] == null
            ? null
            : DateTime.parse(json["date_attendence"]),
        longitudeCheckIn: json["longitude_check_in"] == null
            ? null
            : json["longitude_check_in"].toDouble(),
        longitudeCheckOut: json["longitude_check_out"] == null
            ? null
            : json["longitude_check_out"].toDouble(),
        latitudeCheckIn: json["latitude_check_in"] == null
            ? null
            : json["latitude_check_in"].toDouble(),
        latitudeCheckOut: json["latitude_check_out"] == null
            ? null
            : json["latitude_check_out"].toDouble(),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
        attendenceStatus: json["attendence_status"] == null
            ? null
            : AttendenceStatus.fromJson(json["attendence_status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "schedule_id": scheduleId == null ? null : scheduleId,
        "users_id": usersId == null ? null : usersId,
        "attendence_status_id":
            attendenceStatusId == null ? null : attendenceStatusId,
        "check_in": checkIn == null ? null : checkIn?.toIso8601String(),
        "check_out": checkOut == null ? null : checkOut?.toIso8601String(),
        "date_attendence": dateAttendence == null
            ? null
            : "${dateAttendence?.year.toString().padLeft(4, '0')}-${dateAttendence?.month.toString().padLeft(2, '0')}-${dateAttendence?.day.toString().padLeft(2, '0')}",
        "longitude_check_in":
            longitudeCheckIn == null ? null : longitudeCheckIn,
        "longitude_check_out":
            longitudeCheckOut == null ? null : longitudeCheckOut,
        "latitude_check_in": latitudeCheckIn == null ? null : latitudeCheckIn,
        "latitude_check_out":
            latitudeCheckOut == null ? null : latitudeCheckOut,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt == null ? null : deletedAt?.toIso8601String(),
        "attendence_status":
            attendenceStatus == null ? null : attendenceStatus?.toJson(),
      };
}

class AttendenceStatus {
  AttendenceStatus({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  factory AttendenceStatus.fromJson(Map<String, dynamic> json) =>
      AttendenceStatus(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["deleted_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt == null ? null : createdAt?.toIso8601String(),
      };
}

class ScheduleShift {
  ScheduleShift({
    this.id,
    this.code,
    this.name,
    this.startTime,
    this.endTime,
    this.conditionDifferentDay,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? code;
  String? name;
  String? startTime;
  String? endTime;
  String? conditionDifferentDay;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  factory ScheduleShift.fromJson(Map<String, dynamic> json) => ScheduleShift(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        name: json["name"] == null ? null : json["name"],
        startTime: json["start_time"] == null ? null : json["start_time"],
        endTime: json["end_time"] == null ? null : json["end_time"],
        conditionDifferentDay: json["condition_different_day"] == null
            ? null
            : json["condition_different_day"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "name": name == null ? null : name,
        "start_time": startTime == null ? null : startTime,
        "end_time": endTime == null ? null : endTime,
        "condition_different_day":
            conditionDifferentDay == null ? null : conditionDifferentDay,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt == null ? null : updatedAt?.toIso8601String(),
      };
}
