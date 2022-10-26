class ListPacking {
  ListPacking({
    this.id,
    this.itemId,
    this.itemDetail,
    this.quantity,
    this.dropName,
  });

  String? id;
  String? itemId;
  String? itemDetail;
  String? quantity;
  String? dropName;

  factory ListPacking.fromJson(Map<String, dynamic> json) => ListPacking(
        id: json["id"],
        itemId: json["Item_id"],
        itemDetail: json["Item_detail"],
        quantity: json["quantity"],
        dropName: json["Drop_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "Item_id": itemId,
        "Item_detail": itemDetail,
        "quantity": quantity,
        "Drop_name": dropName,
      };
}
