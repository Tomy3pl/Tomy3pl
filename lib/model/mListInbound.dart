class ListDetailItem {
  ListDetailItem({
    required this.id,
    this.itemId,
    this.itemDetail,
    this.qty,
    this.statusItem,
    required this.selected,
    required this.qtyGet,
  });

  String id;
  String? itemId;
  String? itemDetail;
  String? qty;
  String? statusItem;
  bool selected;
  String qtyGet;

  factory ListDetailItem.fromJson(Map<String, dynamic> json) => ListDetailItem(
        id: json["id"],
        itemId: json["itemId"],
        itemDetail: json["itemDetail"],
        qty: json["qty"],
        statusItem: json["statusItem"],
        selected: false,
        qtyGet: "0",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "itemId": itemId,
        "itemDetail": itemDetail,
        "qty": qty,
        "statusItem": statusItem,
      };
}
