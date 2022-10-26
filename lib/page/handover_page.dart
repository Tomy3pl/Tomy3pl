import 'package:crewdible_b2b/config/app_color.dart';
import 'package:crewdible_b2b/controller/cHandover.dart';
import 'package:crewdible_b2b/controller/cUser.dart';
import 'package:crewdible_b2b/model/mHandover.dart';
import 'package:crewdible_b2b/page/list_handover.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'dashboard_packer_page.dart';
import 'dashboard_picker_page.dart';

class HandoverPage extends StatefulWidget {
  HandoverPage({Key? key}) : super(key: key);

  @override
  State<HandoverPage> createState() => _HandoverPageState();
}

class _HandoverPageState extends State<HandoverPage> {
  final cHandover = Get.put(CHandover());
  final cUser = Get.put(CUser());
  final controllerSearch = TextEditingController();

  _LoadData() async {
    await Get.find<CHandover>().getList();
  }

  @override
  Widget build(BuildContext context) {
    _LoadData();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Handover Proses',
          style: TextStyle(fontSize: 18),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () {
            cUser.data.level == 'picker'
                ? Get.off(DashboardPickerPage())
                : Get.off(PackerDashboard());
          },
        ),
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Container(
              child: Row(
                children: [
                  search(),
                ],
              ),
            ),
            Column(
              children: [
                Container(
                  height: 30,
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(horizontal: 30),
                  child: const Text(
                    'List ID Handover',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Obx(() {
                if (cHandover.loading) return DView.loadingBar();
                if (cHandover.list.isEmpty) return DView.empty();
                return ListView.builder(
                  itemCount: cHandover.list.length,
                  itemBuilder: (context, index) {
                    Handover handover = cHandover.list[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.topLeft,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          elevation: 5,
                          shadowColor: Colors.black,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      handover.idHandover ?? '',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    Text(
                                      handover.driver ?? '',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    Get.to(() => ListHandover(
                                        idHandover: handover.idHandover ?? ''));
                                  },
                                  icon: Icon(Icons.add_shopping_cart_rounded),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Expanded search() {
    return Expanded(
      child: Container(
        height: 90,
        padding: const EdgeInsets.all(16),
        child: TextField(
          controller: controllerSearch,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(30),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 26),
            isDense: true,
            filled: true,
            fillColor: Colors.grey[300],
            hintText: 'Search...',
            suffixIcon: IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search,
                color: Colors.black,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
