import 'package:crewdible_b2b/config/api_request.dart';
import 'package:crewdible_b2b/model/mPickingList.dart';
import 'package:crewdible_b2b/source/sPickingList.dart';
import 'package:get/get.dart';

import '../model/mListItem.dart';

class CPickingList extends GetxController {
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool newData) {
    _loading.value = newData;
  }

  final RxList<ListBasket> _list = <ListBasket>[].obs;
  List<ListBasket> get list => _list.value;
  getList() async {
    loading = true;
    _list.value = await SourcePickingList.gets();
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
    });
  }

  final Rx<ListItem> _data = ListItem().obs;
  ListItem get data => _data.value;
  setData(String idBasket) async {
    // loading = true;
    _data.value = await SourcePickingList.getWhereId(idBasket);
    // Future.delayed(const Duration(seconds: 1), () {
    //   loading = false;
    update();
    // });
  }

  String? idBasket;
  @override
  void onInit() {
    getList();
    super.onInit();
  }
}
