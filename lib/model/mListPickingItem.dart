class ListPickingItems {
  ListPickingItems({
    this.id,
    this.itemId,
    this.itemDetail,
    this.qty,
    this.status,
  });

  String? id;
  String? itemId;
  String? itemDetail;
  String? qty;
  String? status;

  factory ListPickingItems.fromJson(Map<String, dynamic> json) =>
      ListPickingItems(
        id: json["id"],
        itemId: json["itemId"],
        itemDetail: json["itemDetail"],
        qty: json["qty"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemId": itemId,
        "itemDetail": itemDetail,
        "qty": qty,
        "status": status,
      };
}
