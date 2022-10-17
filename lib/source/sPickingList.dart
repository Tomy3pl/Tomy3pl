import 'dart:convert';

import 'package:crewdible_b2b/controller/cUser.dart';
import 'package:d_method/d_method.dart';
import 'package:get/get.dart';

import '../config/api_config.dart';
import '../config/api_request.dart';
import '../model/mListItem.dart';
import '../model/mPickingList.dart';

class SourcePickingList {
  static Future<List<ListBasket>> gets() async {
    var cUser2 = Get.put(CUser());
    String url = '${ApiConfig.pickingList}/show/${cUser2.data.namaUser}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => ListBasket.fromJson(e)).toList();
      } else {
        DMethod.printTitle('SourceUser - login', 'failed');
      }
      return [];
    }
    return [];
  }

  static Future<ListItem> getWhereId(String idBasket) async {
    String url = '${ApiConfig.pickingList}/getId';
    String? responseBody = await AppRequest.post(url, {'id': idBasket});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      bool resultSuccess = result['success'] ?? false;
      print(resultSuccess);
      if (resultSuccess) {
        return ListItem.fromJson(result['data']);
      }
      return ListItem();
    }
    return ListItem();
  }
}
