// To parse this JSON data, do
//
//     final loginRespons = loginResponsFromJson(jsonString);

import 'dart:convert';

LoginRespons loginResponsFromJson(String str) =>
    LoginRespons.fromJson(json.decode(str));

String loginResponsToJson(LoginRespons data) => json.encode(data.toJson());

class LoginRespons {
  LoginRespons({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  DataLogin? data;

  factory LoginRespons.fromJson(Map<String, dynamic> json) => LoginRespons(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : DataLogin.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data!.toJson(),
      };
}

class DataLogin {
  DataLogin({
    this.userId,
    this.token,
    this.nama,
    this.username,
    this.foto,
    this.stsUser,
    this.idKomandante,
    this.nameKomandante,
  });

  String? userId;
  String? token;
  String? nama;
  String? username;
  String? foto;
  String? stsUser;
  String? idKomandante;
  String? nameKomandante;

  factory DataLogin.fromJson(Map<String, dynamic> json) => DataLogin(
        userId: json["user_id"] == null ? null : json["user_id"],
        token: json["token"] == null ? null : json["token"],
        nama: json["nama"] == null ? null : json["nama"],
        username: json["username"] == null ? null : json["username"],
        foto: json["foto"] == null ? null : json["foto"],
        stsUser: json["stsUser"] == null ? null : json["stsUser"],
        idKomandante:
            json["id_komandante"] == null ? null : json["id_komandante"],
        nameKomandante:
            json["nama_komandante"] == null ? null : json["nama_komandante"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "token": token == null ? null : token,
        "nama": nama == null ? null : nama,
        "username": username == null ? null : username,
        "foto": foto == null ? null : foto,
        "stsUser": stsUser == null ? null : stsUser,
        "id_komandante": idKomandante == null ? null : idKomandante,
        "nama_komandante": nameKomandante == null ? null : nameKomandante,
      };
}
