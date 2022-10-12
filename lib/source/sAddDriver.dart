import 'dart:convert';

import '../config/api_config.dart';
import '../config/api_request.dart';

class SourceAddDriver {
  // static Future<int> count(String type) async {
  //   String url = '${ApiConfig.manifest}/${ApiConfig.count}';
  //   String? responseBody = await AppRequest.post(url, {'type': type});
  //   if (responseBody != null) {
  //     Map result = jsonDecode(responseBody);
  //     return result['data'];
  //   }
  //   return 0;
  // }

  // static Future<Map<String, dynamic>> analysis(String type) async {
  //   String url = '${ApiConfig.manifest}/analysis.php';
  //   String? responseBody = await AppRequest.post(url, {
  //     'type': type,
  //     'today': DateTime.now().toIso8601String(),
  //   });
  //   if (responseBody != null) {
  //     Map result = jsonDecode(responseBody);
  //     if (result['success']) {
  //       return {
  //         'list_total': result['list_total'],
  //         'data': result['data'],
  //       };
  //     }
  //     return {
  //       'list_total': [0, 0, 0, 0, 0, 0, 0],
  //       'data': [],
  //     };
  //   }
  //   return {
  //     'list_total': [0, 0, 0, 0, 0, 0, 0],
  //     'data': [],
  //   };
  // }

  static Future<bool> add(
      {required String listProduct,
      required String driver,
      required String warehouse}) async {
    String url = '${ApiConfig.manifest}/add';
    String? responseBody = await AppRequest.post(url, {
      'list': listProduct,
      'driver': driver,
      'warehouse': warehouse,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }
    return false;
  }

  // static Future<List<History>> gets(int page, String type) async {
  //   String url = '${Api.inout}/${Api.gets}';
  //   String? responseBody = await AppRequest.post(
  //     url,
  //     {'page': '$page', 'type': type},
  //   );
  //   if (responseBody != null) {
  //     Map result = jsonDecode(responseBody);
  //     if (result['success']) {
  //       List list = result['data'];
  //       return list.map((e) => History.fromJson(e)).toList();
  //     }
  //     return [];
  //   }
  //   return [];
  // }

  // static Future<List<History>> search(String query, String type) async {
  //   String url = '${Api.inout}/${Api.search}';
  //   String? responseBody = await AppRequest.post(
  //     url,
  //     {'date': query, 'type': type},
  //   );
  //   if (responseBody != null) {
  //     Map result = jsonDecode(responseBody);
  //     if (result['success']) {
  //       List list = result['data'];
  //       return list.map((e) => History.fromJson(e)).toList();
  //     }
  //     return [];
  //   }
  //   return [];
  // }
}
