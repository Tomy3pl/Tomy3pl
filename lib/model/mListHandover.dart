class ListHandoverItem {
  ListHandoverItem({
    required this.id,
    this.idHandover,
    this.orderId,
    this.namaPenerima,
    this.alamat,
    this.noTlp,
    required this.selected,
  });

  String id;
  String? idHandover;
  String? orderId;
  String? namaPenerima;
  String? alamat;
  String? noTlp;
  bool selected;

  factory ListHandoverItem.fromJson(Map<String, dynamic> json) =>
      ListHandoverItem(
        id: json["id"],
        idHandover: json["id_handover"],
        orderId: json["order_id"],
        namaPenerima: json["nama_penerima"],
        alamat: json["alamat"],
        noTlp: json["no_tlp"],
        selected: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_handover": idHandover,
        "order_id": orderId,
        "nama_penerima": namaPenerima,
        "alamat": alamat,
        "no_tlp": noTlp,
      };
}
