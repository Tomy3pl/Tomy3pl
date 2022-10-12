class ListBasket {
  ListBasket({
    this.idBasket,
    this.qty,
    this.item,
  });

  String? idBasket;
  String? qty;
  String? item;

  factory ListBasket.fromJson(Map<String, dynamic> json) => ListBasket(
        idBasket: json["id_basket"],
        qty: json["qty"],
        item: json["item"],
      );

  Map<String, dynamic> toJson() => {
        "id_basket": idBasket,
        "qty": qty,
        "item": item,
      };
}
