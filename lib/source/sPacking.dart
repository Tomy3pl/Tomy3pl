import 'dart:convert';
import 'package:d_info/d_info.dart';
import 'package:get/get.dart';
import '../config/api_config.dart';
import '../config/api_request.dart';
import '../controller/cUser.dart';
import '../model/mPacking.dart';

class SourcePacking {
  // static Future<int> count() async {
  //   String url = '${Api.product}/${Api.count}';
  //   String? responseBody = await AppRequest.gets(url);
  //   if (responseBody != null) {
  //     Map result = jsonDecode(responseBody);
  //     return result['data'];
  //   }
  //   return 0;
  // }

  static Future<List<Packing>> gets() async {
    String url = '${ApiConfig.packing}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => Packing.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<List<Packing>> getsId() async {
    String url = '${ApiConfig.packing}/detail';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => Packing.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<bool> updatePacking(
      String id, String assign, String foto, String fotoAfter) async {
    final cUser = Get.put(CUser());
    String url = '${ApiConfig.packing}/update';
    String? responseBody = await AppRequest.post(url, {
      'foto': foto,
      'fotoAfter': fotoAfter,
      'assign': cUser.data.namaUser,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }

    return false;
  }

  static Future<Packing> getWhereId(String orderId) async {
    String url = '${ApiConfig.packing}/show';
    String? responseBody = await AppRequest.post(url, {'id': orderId});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        return Packing.fromJson(result['data']);
      }
      return Packing();
    }
    return Packing();
  }

  static Future<List<Packing>> search(String orderId) async {
    String url = '${ApiConfig.packing}/show';
    String? responseBody = await AppRequest.post(url, {'orderId': orderId});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => Packing.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }
}
