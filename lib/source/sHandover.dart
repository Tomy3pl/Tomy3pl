import 'dart:convert';

import 'package:crewdible_b2b/model/mHandover.dart';
import 'package:get/get.dart';

import '../config/api_config.dart';
import '../config/api_request.dart';
import '../controller/cUser.dart';

class SourceHandover {
  static Future<List<Handover>> gets() async {
    final cUser = Get.put(CUser());
    String url = '${ApiConfig.manifest}/detail/${cUser.data.warehouse}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => Handover.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<Handover> getWhereId(String idHandover) async {
    String url = '${ApiConfig.manifest}/show';
    String? responseBody = await AppRequest.post(url, {'id': idHandover});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        return Handover.fromJson(result['data']);
      }
      return Handover();
    }
    return Handover();
  }
}
