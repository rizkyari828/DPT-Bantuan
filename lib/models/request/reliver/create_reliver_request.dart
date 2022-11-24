// To parse this JSON data, do
//
//     final createReliverResponse = createReliverResponseFromJson(jsonString);

import 'dart:convert';

CreateReliverRequest createReliverResponseFromJson(String str) =>
    CreateReliverRequest.fromJson(json.decode(str));

String createReliverResponseToJson(CreateReliverRequest data) =>
    json.encode(data.toJson());

class CreateReliverRequest {
  CreateReliverRequest({
    this.bulan,
    this.tahun,
    this.createDate,
    this.idCampaignProses,
    this.idCampaign,
    this.createBy,
    required this.qrNumber,
  });

  String? bulan;
  String? tahun;
  String? createDate;
  String? idCampaignProses;
  String? idCampaign;
  String? createBy;
  String qrNumber;

  factory CreateReliverRequest.fromJson(Map<String, dynamic> json) =>
      CreateReliverRequest(
          bulan: json["bulan"] == null ? null : json["bulan"],
          tahun: json["tahun"] == null ? null : json["tahun"],
          createDate: json["create_date"] == null ? null : json["create_date"],
          idCampaignProses: json["id_campaign_proses"] == null
              ? null
              : json["id_campaign_proses"],
          idCampaign: json["id_campaign"] == null ? null : json["id_campaign"],
          createBy: json["create_by"] == null ? null : json["create_by"],
          qrNumber: json["qr_number"]);

  Map<String, dynamic> toJson() => {
        "bulan": bulan == null ? null : bulan,
        "tahun": tahun == null ? null : tahun,
        "create_date": createDate == null ? null : createDate,
        "id_campaign_proses":
            idCampaignProses == null ? null : idCampaignProses,
        "id_campaign": idCampaign == null ? null : idCampaign,
        "create_by": createBy == null ? null : createBy,
        "qr_number": qrNumber
      };
}
