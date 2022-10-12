import 'dart:convert';

import 'package:get/get.dart';

import '../model/mPacking.dart';
import '../source/sPacking.dart';

class CPacking extends GetxController {
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool newData) {
    _loading.value = newData;
  }

  final RxList<Packing> _list = <Packing>[].obs;
  List<Packing> get list => _list.value;
  getList() async {
    loading = true;
    _list.value = await SourcePacking.gets();
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
    });
  }

  final RxList<Packing> _listItem = <Packing>[].obs;
  List<Packing> get listItem => _listItem.value;
  getListItem() async {
    loading = true;
    _listItem.value = await SourcePacking.getsId();
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
    });
  }

  refreshList() {
    _list.value.clear();
    getList();
  }

  search(String query) async {
    _list.value = await SourcePacking.search(query);
    update();
  }

  final Rx<Packing> _data = Packing().obs;
  Packing get data => _data.value;
  setData(String orderId) async {
    _data.value = await SourcePacking.getWhereId(orderId);
    update();
  }

  @override
  void onInit() {
    getList();
    getListItem();
    super.onInit();
  }
}
