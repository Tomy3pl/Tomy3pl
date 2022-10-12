import 'dart:convert';

import 'package:crewdible_b2b/controller/cUser.dart';
import 'package:get/get.dart';

import '../config/api_config.dart';
import '../config/api_request.dart';
import '../model/mInbound.dart';
import '../model/mInboundDetail.dart';

class SourceInbound {
  static Future<List<ListInbound>> gets() async {
    var cUser2 = Get.put(CUser());
    String url = '${ApiConfig.inboundList}/show/${cUser2.data.warehouse}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success'] == true) {
        List list = result['data'];
        return list.map((e) => ListInbound.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<ListInboundDetail> getWhereId(String nopo) async {
    String url = '${ApiConfig.inboundList}/getId';
    String? responseBody = await AppRequest.post(url, {'id': nopo});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        return ListInboundDetail.fromJson(result['data']);
      }
      return ListInboundDetail();
    }
    return ListInboundDetail();
  }
}
