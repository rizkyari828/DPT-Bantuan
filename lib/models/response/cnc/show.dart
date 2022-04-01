// To parse this JSON data, do
//
//     final showCnCResponse = showCnCResponseFromJson(jsonString);

import 'dart:convert';

ShowCnCResponse showCnCResponseFromJson(String str) =>
    ShowCnCResponse.fromJson(json.decode(str));

String showCnCResponseToJson(ShowCnCResponse data) =>
    json.encode(data.toJson());

class ShowCnCResponse {
  ShowCnCResponse({
    this.error,
    this.message,
    this.data,
  });

  bool? error;
  String? message;
  DetailCnC? data;

  factory ShowCnCResponse.fromJson(Map<String, dynamic> json) =>
      ShowCnCResponse(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : DetailCnC.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        "data": data == null ? null : data?.toJson(),
      };
}

class DetailCnC {
  DetailCnC({
    this.id,
    this.code,
    this.userClientId,
    this.userClientBranchId,
    this.userCoordinatorId,
    this.date,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.statusLabel,
    this.branchName,
    this.itemList,
  });

  int? id;
  String? code;
  int? userClientId;
  int? userClientBranchId;
  int? userCoordinatorId;
  DateTime? date;
  String? note;
  String? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? statusLabel;
  String? branchName;
  List<ItemList>? itemList;

  factory DetailCnC.fromJson(Map<String, dynamic> json) => DetailCnC(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        userClientId: json["user_client_id"],
        userClientBranchId: json["user_client_branch_id"] == null
            ? null
            : json["user_client_branch_id"],
        userCoordinatorId: json["user_coordinator_id"] == null
            ? null
            : json["user_coordinator_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        note: json["note"] == null ? null : json["note"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        statusLabel: json["status_label"] == null ? null : json["status_label"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
        itemList: json["item_list"] == null
            ? null
            : List<ItemList>.from(
                json["item_list"].map((x) => ItemList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "user_client_id": userClientId,
        "user_client_branch_id":
            userClientBranchId == null ? null : userClientBranchId,
        "user_coordinator_id":
            userCoordinatorId == null ? null : userCoordinatorId,
        "date": date == null ? null : date?.toIso8601String(),
        "note": note == null ? null : note,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "status_label": statusLabel == null ? null : statusLabel,
        "branch_name": branchName == null ? null : branchName,
        "item_list": itemList == null
            ? null
            : List<dynamic>.from(itemList!.map((x) => x.toJson())),
      };
}

class ItemList {
  ItemList({
    this.id,
    this.itemId,
    this.chemicalAndConsumableId,
    this.quantity,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.item,
  });

  int? id;
  int? itemId;
  int? chemicalAndConsumableId;
  String? quantity;

  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;
  Item? item;

  factory ItemList.fromJson(Map<String, dynamic> json) => ItemList(
        id: json["id"] == null ? null : json["id"],
        itemId: json["item_id"] == null ? null : json["item_id"],
        chemicalAndConsumableId: json["chemical_and_consumable_id"] == null
            ? null
            : json["chemical_and_consumable_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "item_id": itemId == null ? null : itemId,
        "chemical_and_consumable_id":
            chemicalAndConsumableId == null ? null : chemicalAndConsumableId,
        "quantity": quantity == null ? null : quantity,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
        "item": item == null ? null : item?.toJson(),
      };
}

class Item {
  Item({
    this.id,
    this.name,
    this.unitTypeName,
    this.unitTypeId,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  int? id;
  String? name;
  int? unitTypeId;
  String? unitTypeName;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? deletedAt;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        unitTypeId: json["unit_type_id"] == null ? null : json["unit_type_id"],
        unitTypeName:
            json["unit_type_name"] == null ? null : json["unit_type_name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "unit_type_id": unitTypeId == null ? null : unitTypeId,
        "unit_type_name": unitTypeName == null ? null : unitTypeName,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "deleted_at": deletedAt,
      };
}
