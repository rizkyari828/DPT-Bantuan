// To parse this JSON data, do
//
//     final listPenerimaResponse = listPenerimaResponseFromJson(jsonString);

import 'dart:convert';

ListPenerimaResponse listPenerimaResponseFromJson(String str) =>
    ListPenerimaResponse.fromJson(json.decode(str));

String listPenerimaResponseToJson(ListPenerimaResponse data) =>
    json.encode(data.toJson());

class ListPenerimaResponse {
  ListPenerimaResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  List<Penerima>? data;

  factory ListPenerimaResponse.fromJson(Map<String, dynamic> json) =>
      ListPenerimaResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null
            ? null
            : List<Penerima>.from(
                json["data"].map((x) => Penerima.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null
            ? null
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Penerima {
  Penerima({
    this.idDpt,
    this.idCampaignProses,
    this.ktp,
    this.nama,
    this.createDate,
  });

  String? idDpt;
  String? idCampaignProses;
  String? ktp;
  String? nama;
  DateTime? createDate;

  factory Penerima.fromJson(Map<String, dynamic> json) => Penerima(
        idDpt: json["id_dpt"] == null ? null : json["id_dpt"],
        idCampaignProses: json["id_campaign_proses"] == null
            ? null
            : json["id_campaign_proses"],
        ktp: json["ktp"] == null ? null : json["ktp"],
        nama: json["nama"] == null ? null : json["nama"],
        createDate: json["create_date"] == null
            ? null
            : DateTime.parse(json["create_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id_dpt": idDpt == null ? null : idDpt,
        "id_campaign_proses":
            idCampaignProses == null ? null : idCampaignProses,
        "ktp": ktp == null ? null : ktp,
        "nama": nama == null ? null : nama,
        "create_date":
            createDate == null ? null : createDate?.toIso8601String(),
      };
}
