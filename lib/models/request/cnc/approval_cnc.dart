import 'dart:convert';

class ApprovalCnCRequest {
  ApprovalCnCRequest({
    required this.action,
    required this.itemList,
  });

  String action;
  List<ItemListApproval> itemList;

  factory ApprovalCnCRequest.fromRawJson(String str) =>
      ApprovalCnCRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ApprovalCnCRequest.fromJson(Map<String, dynamic> json) =>
      ApprovalCnCRequest(
        action: json["action"],
        itemList: List<ItemListApproval>.from(
            json["item_list"].map((x) => ItemListApproval.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "action": action,
        "item_list": List<dynamic>.from(itemList.map((x) => x.toJson())),
      };
}

class ItemListApproval {
  ItemListApproval({
    this.itemId,
    this.quantity,
  });

  int? itemId;
  int? quantity;

  factory ItemListApproval.fromJson(Map<String, dynamic> json) =>
      ItemListApproval(
        itemId: json["item_id"],
        quantity: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "item_id": itemId,
        "quantity": quantity,
      };
}
