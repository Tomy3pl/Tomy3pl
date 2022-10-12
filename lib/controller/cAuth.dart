import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;

import 'cUser.dart';

class CAuth extends GetxController {
  var isAuth = false.obs;
  final cUser = Get.put(CUser());
  void dialogError(String msg) {
    Get.defaultDialog(
      title: 'Gagal Login',
      middleText: msg,
    );
  }

  Map<String, String> _dataUser = {};

  void login(String email, String pass) async {
    var response = await http.post(
      Uri.parse("https://wms-b2b.dev.crewdible.co.id/ApiKaryawan"),
    );
    print(email);
    if (email != '' && pass != '') {
      if (GetUtils.isEmail(email)) {
        if (email == cUser.data.email && pass == cUser.data.password) {
          isAuth.value = true;
        } else {
          dialogError('Data yang dimasukan salah !');
        }
      } else {
        dialogError('Masukan email yang benar');
      }
    } else {
      dialogError('Email dan Password harus diisi');
    }
  }
}
