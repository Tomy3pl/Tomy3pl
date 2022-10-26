import 'dart:convert';

import 'package:crewdible_b2b/model/mListPacking.dart';

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
  List<ListPacking>? list;
  String? foto;
  String? fotoAfter;
  String? assign;
  String? status;
  String? createdAt;
  String? updatedAt;

  factory Packing.fromJson(Map<String, dynamic> json) {
    Packing result = Packing();
    result.orderId = json["order_id"];
    result.foto = json["foto"];
    result.fotoAfter = json["foto_after"];
    result.assign = json["assign"];
    result.status = json["Status"];
    result.createdAt = json["created_at"];
    result.updatedAt = json["updated_at"];
    try {
      List tempItem = jsonDecode(json['list']);
      List<ListPacking> list = [];
      tempItem.forEach((e) => list.add(ListPacking.fromJson(e)));
      result.list = list;
    } catch (e) {
      result.list = [];
      print(e);
    }
    return result;
  }

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
