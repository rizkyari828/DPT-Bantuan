// To parse this JSON data, do
//
//     final typeIzinResponse = typeIzinResponseFromJson(jsonString);

import 'dart:convert';

TypeIzinResponse typeIzinResponseFromJson(String str) => TypeIzinResponse.fromJson(json.decode(str));

String typeIzinResponseToJson(TypeIzinResponse data) => json.encode(data.toJson());

class TypeIzinResponse {
    TypeIzinResponse({
        this.error,
        this.message,
        this.data,
    });

    bool? error;
    String? message;
    List<DataTypeIzin>? data;

    factory TypeIzinResponse.fromJson(Map<String, dynamic> json) => TypeIzinResponse(
        error: json["error"],
        message: json["message"],
        data: List<DataTypeIzin>.from(json["data"].map((x) => DataTypeIzin.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
    };
}

class DataTypeIzin {
    DataTypeIzin({
        this.id,
        this.name,
    });

    int? id;
    String? name;

    factory DataTypeIzin.fromJson(Map<String, dynamic> json) => DataTypeIzin(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}
