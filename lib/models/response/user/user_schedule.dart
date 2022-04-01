// To parse this JSON data, do
//
//     final userScheduleResponse = userScheduleResponseFromJson(jsonString);

import 'dart:convert';

UserScheduleResponse userScheduleResponseFromJson(String str) =>
    UserScheduleResponse.fromJson(json.decode(str));

String userScheduleResponseToJson(UserScheduleResponse data) =>
    json.encode(data.toJson());

class UserScheduleResponse {
  UserScheduleResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  Data? data;

  factory UserScheduleResponse.fromJson(Map<String, dynamic> json) =>
      UserScheduleResponse(
        error: json["error"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.schedule,
    this.branch,
  });

  Schedule? schedule;
  Branch? branch;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        schedule: Schedule.fromJson(json["schedule"]),
        branch: Branch.fromJson(json["branch"]),
      );

  Map<String, dynamic> toJson() => {
        "schedule": schedule?.toJson(),
        "branch": branch?.toJson(),
      };
}

class Branch {
  Branch({
    this.id,
    this.companyId,
    this.name,
    this.longitude,
    this.latitude,
    this.radius,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.location,
    this.building,
  });

  int? id;
  int? companyId;
  String? name;
  double? longitude;
  double? latitude;
  int? radius;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  String? location;
  String? building;

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
        id: json["id"],
        companyId: json["company_id"],
        name: json["name"],
        longitude:
            json["longitude"] == null ? null : json["longitude"].toDouble(),
        latitude: json["latitude"] == null ? null : json["latitude"].toDouble(),
        radius: json["radius"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        location: json["location"],
        building: json["building"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_id": companyId,
        "name": name,
        "longitude": longitude,
        "latitude": latitude,
        "radius": radius,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "location": location,
        "building": building,
      };
}

class Schedule {
  Schedule({
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
  String? dateCheckIn;
  String? dateCheckOut;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  ScheduleShift? scheduleShift;
  DataUserAttandance? dataUserAttandance;

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
        id: json["id"],
        usersId: json["users_id"],
        scheduleShiftId: json["schedule_shift_id"],
        dateCheckIn: json["date_check_in"],
        dateCheckOut: json["date_check_out"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        scheduleShift: ScheduleShift.fromJson(json["schedule_shift"]),
        dataUserAttandance:
            DataUserAttandance.fromJson(json["data_user_attandance"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "users_id": usersId,
        "schedule_shift_id": scheduleShiftId,
        "date_check_in": dateCheckIn,
        "date_check_out": dateCheckOut,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "schedule_shift": scheduleShift?.toJson(),
        "data_user_attandance": dataUserAttandance?.toJson(),
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
  String? checkIn;
  String? checkOut;
  String? dateAttendence;
  double? longitudeCheckIn;
  double? longitudeCheckOut;
  double? latitudeCheckIn;
  double? latitudeCheckOut;
  dynamic createdAt;
  String? updatedAt;
  dynamic deletedAt;
  AttendenceStatus? attendenceStatus;

  factory DataUserAttandance.fromJson(Map<String, dynamic> json) =>
      DataUserAttandance(
        id: json["id"],
        scheduleId: json["schedule_id"],
        usersId: json["users_id"],
        attendenceStatusId: json["attendence_status_id"],
        checkIn: json["check_in"],
        checkOut: json["check_out"],
        dateAttendence: json["date_attendence"],
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
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
        attendenceStatus: AttendenceStatus.fromJson(json["attendence_status"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "schedule_id": scheduleId,
        "users_id": usersId,
        "attendence_status_id": attendenceStatusId,
        "check_in": checkIn,
        "check_out": checkOut,
        "date_attendence": dateAttendence,
        "longitude_check_in": longitudeCheckIn,
        "longitude_check_out": longitudeCheckOut,
        "latitude_check_in": latitudeCheckIn,
        "latitude_check_out": latitudeCheckOut,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
        "attendence_status": attendenceStatus?.toJson(),
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
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  factory AttendenceStatus.fromJson(Map<String, dynamic> json) =>
      AttendenceStatus(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
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
  String? createdAt;
  String? updatedAt;
  dynamic deletedAt;

  factory ScheduleShift.fromJson(Map<String, dynamic> json) => ScheduleShift(
        id: json["id"],
        code: json["code"],
        name: json["name"],
        startTime: json["start_time"],
        endTime: json["end_time"],
        conditionDifferentDay: json["condition_different_day"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "code": code,
        "name": name,
        "start_time": startTime,
        "end_time": endTime,
        "condition_different_day": conditionDifferentDay,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "deleted_at": deletedAt,
      };
}
