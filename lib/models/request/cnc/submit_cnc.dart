// To parse this JSON data, do
//
//     final submitCnCRequest = submitCnCRequestFromJson(jsonString);

import 'dart:convert';

SubmitCnCRequest submitCnCRequestFromJson(String str) =>
    SubmitCnCRequest.fromJson(json.decode(str));

String submitCnCRequestToJson(SubmitCnCRequest data) =>
    json.encode(data.toJson());

class SubmitCnCRequest {
  SubmitCnCRequest({
    this.date,
    this.note,
    this.itemList,
    this.action,
  });

  String? date;
  String? note;
  List<ItemList>? itemList;
  String? action;

  factory SubmitCnCRequest.fromJson(Map<String, dynamic> json) =>
      SubmitCnCRequest(
        date: json["date"],
        note: json["note"],
        itemList: json["item_list"] == null
            ? null
            : List<ItemList>.from(
                json["item_list"].map((x) => ItemList.fromJson(x))),
        action: json["action"],
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "note": note,
        "item_list": itemList == null
            ? null
            : List<dynamic>.from(itemList!.map((x) => x.toJson())),
        "action": action,
      };
}

class ItemList {
  ItemList({
    this.itemId,
    this.quantity,
  });

  int? itemId;
  int? quantity;

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        itemId: json["item_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "quantity": quantity,
      };
}
