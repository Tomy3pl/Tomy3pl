import 'package:crewdible_b2b/model/mKaryawan.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CUser extends GetxController {
  final Rx<Karyawan> _data = Karyawan().obs;
  Karyawan get data => _data.value;
  set data(Karyawan newData) {
    _data.value = newData;
  }

  var hidden = true.obs;
  TextEditingController cEmail = TextEditingController();
  TextEditingController cPass = TextEditingController();
}
