import 'package:crewdible_b2b/model/mListInbound.dart';
import 'package:crewdible_b2b/source/sInbound.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../model/mInbound.dart';
import '../model/mInboundDetail.dart';

class CInbound extends GetxController {
  ListInboundDetail? inboundDetail = null;
  var isLoading = false.obs;

  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool newData) {
    _loading.value = newData;
  }

  final RxList<ListInbound> _list = <ListInbound>[].obs;
  List<ListInbound> get list => _list.value;
  getList() async {
    loading = true;
    _list.value = await SourceInbound.gets();
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
    });
  }

  final Rx<ListInboundDetail> _data = ListInboundDetail().obs;
  ListInboundDetail get data => _data.value;
  setData(String? nopo) async {
    // loading = true;
    // update();
    inboundDetail = await SourceInbound.getWhereId(nopo!);
    _data.value = inboundDetail!;
    // Future.delayed(const Duration(seconds: 1), () {});
    // loading = false;
    update();
  }

  @override
  void onInit() {
    getList();
    super.onInit();
  }

  void onItemCheck(ListDetailItem picking, bool? value) {
    if (inboundDetail == null) return;

    var items = inboundDetail?.listItem ?? [];
    if (inboundDetail?.listItem == null) return;
    var isSelected = value ?? false;
    for (var i = 0; i < items.length; i++) {
      if (picking.id == items[i].id) {
        items[i].selected = isSelected;
        if (isSelected) {
          items[i].qtyGet = items[i].qty ?? '0';
          items[i].status = '1';
        } else {
          items[i].qtyGet = '0';
          items[i].status = '0';
        }
        print(items[i].selected);
        break;
      }
    }
  }

  void uploadData() async {
    isLoading.value = true;
    await Future.delayed(Duration(seconds: 4));
    isLoading.value = false;
  }

  // final now = new DateTime.now();
  var date = DateFormat().add_yMd().add_Hms().format(DateTime.now()).obs;
}
