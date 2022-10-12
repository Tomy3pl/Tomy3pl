class ListInbound {
  ListInbound({
    this.noPo,
    this.warehouse,
    this.driver,
    this.noplat,
    this.foto,
    this.tandatangan,
    this.jumlahItem,
    this.quantityItem,
    this.quantityCount,
    this.selisih,
    this.status,
    this.waktuDatang,
  });

  String? noPo;
  String? warehouse;
  String? driver;
  String? noplat;
  String? foto;
  String? tandatangan;
  String? jumlahItem;
  String? quantityItem;
  String? quantityCount;
  String? selisih;
  String? status;
  String? waktuDatang;

  factory ListInbound.fromJson(Map<String, dynamic> json) => ListInbound(
        noPo: json["no_Po"],
        warehouse: json["warehouse"],
        driver: json["driver"],
        noplat: json["noplat"],
        foto: json["foto"],
        tandatangan: json["tandatangan"],
        jumlahItem: json["jumlah_Item"],
        quantityItem: json["quantity_item"],
        quantityCount: json["quantity_count"],
        selisih: json["selisih"],
        status: json["status"],
        waktuDatang: json["waktu_datang"],
      );

  Map<String, dynamic> toJson() => {
        "no_Po": noPo,
        "warehouse": warehouse,
        "driver": driver,
        "noplat": noplat,
        "foto": foto,
        "tandatangan": tandatangan,
        "jumlah_Item": jumlahItem,
        "quantity_item": quantityItem,
        "quantity_count": quantityCount,
        "selisih": selisih,
        "status": status,
        "waktu_datang": waktuDatang,
      };
}
