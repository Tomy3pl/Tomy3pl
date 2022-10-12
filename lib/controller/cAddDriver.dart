import 'dart:convert';

import 'package:crewdible_b2b/controller/cUser.dart';
import 'package:crewdible_b2b/source/sAddDriver.dart';
import 'package:d_info/d_info.dart';
import 'package:d_method/d_method.dart';
import 'package:get/get.dart';
import '../config/api_config.dart';
import '../config/api_request.dart';

class CAddDriver extends GetxController {
  final RxList<Map> _list = <Map>[].obs;
  // ignore: invalid_use_of_protected_member
  List<Map> get list => _list.value;
  add(newData) async {
    // ignore: invalid_use_of_protected_member
    _list.value.add(newData);
    // double quantity = double.parse(newData['qty'].toString());
    update();
  }

  delete(Map data) {
    _list.value.remove(data);
    update();
  }

  addInOut(String driver) async {
    final cUser = Get.put(CUser());
    List<Map<String, dynamic>> listCast = List.castFrom(list);
    // print(jsonEncode(listCast));
    bool success = await SourceAddDriver.add(
      listProduct: jsonEncode(listCast),
      driver: driver,
      warehouse: cUser.data.warehouse!,
    );
    if (success) {
      DMethod.printTitle('addinout', 'success');
      DInfo.dialogSuccess('Success Add $driver');
      DInfo.closeDialog(actionAfterClose: () {
        DMethod.printTitle('addinout', 'close dialog');
        Get.back(result: true);
      });
    } else {
      DInfo.dialogError('Failed Add $driver');
      DInfo.closeDialog();
    }
  }
}
