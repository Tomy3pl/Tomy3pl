class Packing {
  Packing({
    this.orderId,
    this.list,
    this.foto,
    this.fotoAfter,
    this.assign,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  String? orderId;
  String? list;
  String? foto;
  String? fotoAfter;
  String? assign;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory Packing.fromJson(Map<String, dynamic> json) => Packing(
        orderId: json["order_id"],
        list: json["list"],
        foto: json["foto"],
        fotoAfter: json["foto_after"],
        assign: json["assign"],
        status: json["Status"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "order_id": orderId,
        "list": list,
        "foto": foto,
        "foto_after": fotoAfter,
        "assign": assign,
        "Status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
