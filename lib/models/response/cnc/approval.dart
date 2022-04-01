// To parse this JSON data, do
//
//     final approvalCnCRespons = approvalCnCResponsFromJson(jsonString);

import 'dart:convert';

ApprovalCnCRespons approvalCnCResponsFromJson(String str) => ApprovalCnCRespons.fromJson(json.decode(str));

String? approvalCnCResponsToJson(ApprovalCnCRespons data) => json.encode(data.toJson());

class ApprovalCnCRespons {
    ApprovalCnCRespons({
        this.error,
        this.message,
        // this.data,
    });

    bool? error;
    String? message;
    // Data? data;

    factory ApprovalCnCRespons.fromJson(Map<String, dynamic> json) => ApprovalCnCRespons(
        error: json["error"] == null ? null : json["error"],
        message: json["message"] == null ? null : json["message"],
        // data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "message": message == null ? null : message,
        // "data": data == null ? null : data?.toJson(),
    };
}

class Data {
    Data({
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

    factory Data.fromJson(Map<String?, dynamic> json) => Data(
        id: json["id"] == null ? null : json["id"],
        code: json["code"] == null ? null : json["code"],
        userClientId: json["user_client_id"],
        userClientBranchId: json["user_client_branch_id"] == null ? null : json["user_client_branch_id"],
        userCoordinatorId: json["user_coordinator_id"] == null ? null : json["user_coordinator_id"],
        date: json["date"] == null ? null : DateTime?.parse(json["date"]),
        note: json["note"] == null ? null : json["note"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime?.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime?.parse(json["updated_at"]),
        statusLabel: json["status_label"] == null ? null : json["status_label"],
        branchName: json["branch_name"] == null ? null : json["branch_name"],
        itemList: json["item_list"] == null ? null : List<ItemList>.from(json["item_list"].map((x) => ItemList.fromJson(x))),
    );

    Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "code": code == null ? null : code,
        "user_client_id": userClientId,
        "user_client_branch_id": userClientBranchId == null ? null : userClientBranchId,
        "user_coordinator_id": userCoordinatorId == null ? null : userCoordinatorId,
        "date": date == null ? null : date?.toIso8601String(),
        "note": note == null ? null : note,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "status_label": statusLabel == null ? null : statusLabel,
        "branch_name": branchName == null ? null : branchName,
        "item_list": itemList == null ? null : List<dynamic>.from(itemList!.map((x) => x.toJson())),
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
        this.item,
    });

    int? id;
    int? itemId;
    int? chemicalAndConsumableId;
    String? quantity;
    DateTime? createdAt;
    DateTime? updatedAt;
    Item? item;

    factory ItemList.fromJson(Map<String?, dynamic> json) => ItemList(
        id: json["id"] == null ? null : json["id"],
        itemId: json["item_id"] == null ? null : json["item_id"],
        chemicalAndConsumableId: json["chemical_and_consumable_id"] == null ? null : json["chemical_and_consumable_id"],
        quantity: json["quantity"] == null ? null : json["quantity"],
        createdAt: json["created_at"] == null ? null : DateTime?.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime?.parse(json["updated_at"]),
        item: json["item"] == null ? null : Item.fromJson(json["item"]),
    );

    Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "item_id": itemId == null ? null : itemId,
        "chemical_and_consumable_id": chemicalAndConsumableId == null ? null : chemicalAndConsumableId,
        "quantity": quantity == null ? null : quantity,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "item": item == null ? null : item?.toJson(),
    };
}

class Item {
    Item({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
        this.unitTypeId,
    });

    int? id;
    String? name;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? unitTypeId;

    factory Item.fromJson(Map<String?, dynamic> json) => Item(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        createdAt: json["created_at"] == null ? null : DateTime?.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime?.parse(json["updated_at"]),
        unitTypeId: json["unit_type_id"],
    );

    Map<String?, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "created_at": createdAt == null ? null : createdAt?.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt?.toIso8601String(),
        "unit_type_id": unitTypeId,
    };
}
