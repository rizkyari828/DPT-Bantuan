// To parse this JSON data, do
//
//     final showReliverResponse = showReliverResponseFromJson(jsonString);

import 'dart:convert';

ShowReliverResponse showReliverResponseFromJson(String str) =>
    ShowReliverResponse.fromJson(json.decode(str));

String showReliverResponseToJson(ShowReliverResponse data) =>
    json.encode(data.toJson());

class ShowReliverResponse {
  ShowReliverResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  DataShowReliver? data;

  factory ShowReliverResponse.fromJson(Map<String, dynamic> json) =>
      ShowReliverResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : DataShowReliver.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class DataShowReliver {
  DataShowReliver({
    this.id,
    this.idCampaign,
    this.idKomandante,
    this.tanggalPelaksanaan,
    this.keterangan,
    this.judul,
    this.start,
    this.end,
    this.area,
    this.kota,
    this.kecamatan,
    this.kelurahan,
  });

  String? id;
  String? idKomandante;
  String? idCampaign;
  DateTime? tanggalPelaksanaan;
  String? keterangan;
  String? judul;
  DateTime? start;
  DateTime? end;
  String? area;
  String? kota;
  String? kecamatan;
  String? kelurahan;

  factory DataShowReliver.fromJson(Map<String, dynamic> json) =>
      DataShowReliver(
        id: json["id"] == null ? null : json["id"],
        idCampaign: json["id_campaign"] == null ? null : json["id_campaign"],
        idKomandante: json["id_komandante"],
        tanggalPelaksanaan: json["tanggal_pelaksanaan"] == null
            ? null
            : DateTime.parse(json["tanggal_pelaksanaan"]),
        keterangan: json["keterangan"],
        judul: json["judul"] == null ? null : json["judul"],
        start: json["start"] == null ? null : DateTime.parse(json["start"]),
        end: json["end"] == null ? null : DateTime.parse(json["end"]),
        area: json["area"] == null ? null : json["area"],
        kota: json["kota"] == null ? null : json["kota"],
        kecamatan: json["kecamatan"] == null ? null : json["kecamatan"],
        kelurahan: json["kelurahan"] == null ? null : json["kelurahan"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "id_campaign": idCampaign == null ? null : idCampaign,
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
        "kota": kota == null ? null : kota,
        "kecamatan": kecamatan == null ? null : kecamatan,
        "kelurahan": kelurahan == null ? null : kelurahan,
      };
}
