class ListItem {
  ListItem({
    this.idBasket,
    this.assign,
    this.status,
    this.listItem,
  });

  String? idBasket;
  String? assign;
  String? status;
  String? listItem;

  factory ListItem.fromJson(Map<String, dynamic> json) => ListItem(
        idBasket: json["id_basket"],
        assign: json["assign"],
        status: json["status"],
        listItem: json['listItem'],
      );

  Map<String, dynamic> toJson() => {
        "id_basket": idBasket,
        "assign": assign,
        "status": status,
        "listItem": listItem,
      };
}
