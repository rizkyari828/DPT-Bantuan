// To parse this JSON data, do
//
//     final eventResponse = eventResponseFromJson(jsonString);

import 'dart:convert';

EventResponse eventResponseFromJson(String str) =>
    EventResponse.fromJson(json.decode(str));

String eventResponseToJson(EventResponse data) => json.encode(data.toJson());

class EventResponse {
  EventResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<EventList>? data;

  factory EventResponse.fromJson(Map<String, dynamic> json) => EventResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<EventList>.from(
                json["data"].map((x) => EventList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class EventList {
  EventList({
    this.id,
    this.idKomandante,
    this.tanggalPelaksanaan,
    this.keterangan,
    this.judul,
    this.start,
    this.end,
    this.area,
  });

  String? id;
  String? idKomandante;
  DateTime? tanggalPelaksanaan;
  String? keterangan;
  String? judul;
  DateTime? start;
  DateTime? end;
  String? area;

  factory EventList.fromJson(Map<String, dynamic> json) => EventList(
        id: json["id"] == null ? null : json["id"],
        idKomandante: json["id_komandante"],
        tanggalPelaksanaan: json["tanggal_pelaksanaan"] == null
            ? null
            : DateTime.parse(json["tanggal_pelaksanaan"]),
        keterangan: json["keterangan"],
        judul: json["judul"] == null ? null : json["judul"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        area: json["area"] == null ? null : json["area"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "id_komandante": idKomandante,
        "tanggal_pelaksanaan": tanggalPelaksanaan == null
            ? null
            : "${tanggalPelaksanaan?.year.toString().padLeft(4, '0')}-${tanggalPelaksanaan?.month.toString().padLeft(2, '0')}-${tanggalPelaksanaan?.day.toString().padLeft(2, '0')}",
        "keterangan": keterangan,
        "judul": judul == null ? null : judul,
        "start": start == null
            ? null
            : "${start?.year.toString().padLeft(4, '0')}-${start?.month.toString().padLeft(2, '0')}-${start?.day.toString().padLeft(2, '0')}",
        "end": end == null
            ? null
            : "${end?.year.toString().padLeft(4, '0')}-${end?.month.toString().padLeft(2, '0')}-${end?.day.toString().padLeft(2, '0')}",
        "area": area == null ? null : area,
      };
}
