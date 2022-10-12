import 'package:crewdible_b2b/model/mPacking.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../model/mHandover.dart';
import '../source/sHandover.dart';

class CHandover extends GetxController {
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool newData) {
    _loading.value = newData;
  }

  final RxList<Handover> _list = <Handover>[].obs;
  List<Handover> get list => _list.value;
  getList() async {
    loading = true;
    _list.value = await SourceHandover.gets();
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
    });
  }

  refreshList() {
    _list.value.clear();
    getList();
  }

  // search(String query) async {
  //   _list.value = await SourceHandover.search(query);
  //   update();
  // }

  final Rx<Handover> _data = Handover().obs;
  Handover get data => _data.value;
  setData(String idHandover) async {
    _data.value = await SourceHandover.getWhereId(idHandover);
    update();
  }

  @override
  void onInit() {
    getList();
    super.onInit();
  }
}
