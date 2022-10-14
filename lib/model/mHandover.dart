import 'dart:convert';

import 'package:crewdible_b2b/model/mListHandover.dart';

class Handover {
  Handover({
    this.idHandover,
    this.listItem,
    this.driver,
    this.foto,
    this.tandatangan,
    this.status,
    this.warehouse,
  });

  String? idHandover;
  List<ListHandoverItem>? listItem;
  String? driver;
  String? foto;
  String? tandatangan;
  String? status;
  String? warehouse;

  factory Handover.fromJson(Map<String, dynamic> json) {
    Handover result = Handover();
    result.idHandover = json["id_handover"];
    result.driver = json["driver"];
    result.foto = json["foto"];
    result.tandatangan = json["tandatangan"];
    result.status = json["status"];
    result.warehouse = json["warehouse"];
    try {
      List tmpItem = jsonDecode(json["listItem"]);
      List<ListHandoverItem> list = [];
      tmpItem.forEach((e) => list.add(ListHandoverItem.fromJson(e)));
      result.listItem = list;
    } catch (e) {
      result.listItem = [];
      print(e);
    }
    return result;
  }

  Map<String, dynamic> toJson() => {
        "id_handover": idHandover,
        "listItem": listItem,
        "driver": driver,
        "foto": foto,
        "tandatangan": tandatangan,
        "status": status,
        "warehouse": warehouse,
      };
}
