import 'dart:convert';

import 'package:crewdible_b2b/model/mListPickingItem.dart';

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
  List<ListPickingItems>? listItem;

  factory ListItem.fromJson(Map<String, dynamic> json) {
    ListItem result = ListItem();
    result.idBasket = json["id_basket"];
    result.assign = json["assign"];
    result.status = json["status"];
    try {
      List tempItem = jsonDecode(json['listItem']);
      List<ListPickingItems> list = [];
      tempItem.forEach((e) => list.add(ListPickingItems.fromJson(e)));
      result.listItem = list;
    } catch (e) {
      result.listItem = [];
      print(e);
    }
    return result;
  }

  Map<String, dynamic> toJson() => {
        "id_basket": idBasket,
        "assign": assign,
        "status": status,
        "listItem": listItem,
      };
}
