import 'dart:convert';

class SubmitRate {
  SubmitRate({
    required this.rate,
    required this.note,
  });

  int rate;
  String note;

  factory SubmitRate.fromRawJson(String str) =>
      SubmitRate.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory SubmitRate.fromJson(Map<String, dynamic> json) => SubmitRate(
        rate: json["rate"],
        note: json["note"],
      );

  Map<String, dynamic> toJson() => {
        "rate": rate,
        "note": note,
      };
}
