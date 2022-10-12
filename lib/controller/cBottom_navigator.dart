import 'package:get/get.dart';
import 'package:get/state_manager.dart';

class CBottomNavigator extends GetxController {
  var selectedIndex = 0.obs;
  var textValue = 0.obs;
  final RxBool _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool newData) {
    _loading.value = newData;
  }

  void changeNavigation(int index) {
    loading = true;
    selectedIndex.value = index;
    Future.delayed(const Duration(seconds: 1), () {
      loading = false;
    });
  }

  void increaseValue() {
    textValue.value++;
  }
}
