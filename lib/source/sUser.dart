import 'dart:convert';

import 'package:crewdible_b2b/config/api_request.dart';
import 'package:crewdible_b2b/model/mKaryawan.dart';
import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';

import '../config/api_config.dart';
import '../config/session.dart';
import 'package:http/http.dart' as http;

class SourceUser {
  static Future<bool> login(String email, String password) async {
    var response = await http.post(
      Uri.parse("https://wms-b2b.dev.crewdible.co.id/ApiKaryawan"),
      body: ({
        "email": email,
        "password": password,
      }),
    );
    print(response);
    if (response.statusCode == 200) {
      Map result = jsonDecode(response.body);
      if (result['success']) {
        DMethod.printTitle('SourceUser - login', 'Success');
        Map<String, dynamic> userMap = result['data'];
        Session.saveUser(Karyawan.fromJson(userMap));
      } else {
        DMethod.printTitle('SourceUser - login', 'failed');
      }
      return result['success'];
    }

    return false;
  }

  static Future<List<Karyawan>> gets() async {
    String url = '${ApiConfig.user}';
    String? responseBody = await AppRequest.gets(url);
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        List list = result['data'];
        return list.map((e) => Karyawan.fromJson(e)).toList();
      }
      return [];
    }
    return [];
  }

  static Future<bool> add(
      String namaUser, String email, String password) async {
    String url = '${ApiConfig.user}';
    String? responseBody = await AppRequest.post(url, {
      'nama_user': namaUser,
      'email': email,
      'password': password,
    });
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      if (result['success']) {
        return true;
      } else {
        if (result['message'] == 'email') {
          DInfo.toastError('Email is already used');
        }
        return false;
      }
    }

    return false;
  }

  static Future<bool> delete(String idUser) async {
    String url = '${ApiConfig.user}';
    String? responseBody = await AppRequest.post(url, {'id_user': idUser});
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }
    return false;
  }

  static Future<bool> changePassword(String idUser, String newPassword) async {
    String url = '${ApiConfig.user}';
    String? responseBody = await AppRequest.post(
      url,
      {'id_user': idUser, 'password': newPassword},
    );
    if (responseBody != null) {
      Map result = jsonDecode(responseBody);
      return result['success'];
    }
    return false;
  }
}
