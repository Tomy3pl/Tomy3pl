import 'dart:convert';

import 'package:crewdible_b2b/model/mListInbound.dart';

class ListInboundDetail {
  ListInboundDetail({
    this.nopo,
    this.warehouse,
    this.status,
    this.qty,
    this.listItem,
  });

  String? nopo;
  String? warehouse;
  String? status;
  String? qty;
  List<ListDetailItem>? listItem;

  factory ListInboundDetail.fromJson(Map<String, dynamic> json) {
    ListInboundDetail result = ListInboundDetail();
    // ListInboundDetail(
    //   nopo: json["nopo"],
    //   warehouse: json["warehouse"],
    //   status: json["status"],
    //   qty: json["qty"],
    // listItem: ListDetailItem.fromJson(json["listItem"]),
    // );
    result.nopo = json["nopo"];
    result.warehouse = json["warehouse"];
    result.status = json["status"];
    result.qty = json["qty"];
    try {
      List tmpItem = jsonDecode(json['listItem']);
      List<ListDetailItem> list = [];
      tmpItem.forEach((e) => list.add(ListDetailItem.fromJson(e)));
      result.listItem = list;
    } catch (e) {
      result.listItem = [];
      print(e);
    }
    return result;
  }

  Map<String, dynamic> toJson() => {
        "nopo": nopo,
        "warehouse": warehouse,
        "status": status,
        "qty": qty,
        "listItem": listItem,
      };
}
