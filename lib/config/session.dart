import 'dart:convert';

import 'package:crewdible_b2b/model/mKaryawan.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controller/cUser.dart';

class Session {
  static Future<Karyawan> getUser() async {
    Karyawan user = Karyawan();
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? stringUser = pref.getString('nama_user');
    if (stringUser != null) {
      user = Karyawan.fromJson(jsonDecode(stringUser));
    }
    final cUser = Get.put(CUser());
    cUser.data = user;
    return user;
  }

  static Future<bool> saveUser(Karyawan user) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool success = await pref.setString('nama_user', jsonEncode(user.toJson()));
    final cUser = Get.put(CUser());
    if (success) cUser.data = user;
    return success;
  }

  static Future<bool> clearUser() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    bool success = await pref.remove('nama_user');
    final cUser = Get.put(CUser());
    cUser.data = Karyawan();
    return success;
  }
}
