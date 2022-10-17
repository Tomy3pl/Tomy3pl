import 'package:audioplayers/audioplayers.dart';
import 'package:crewdible_b2b/controller/cPickingList.dart';
import 'package:crewdible_b2b/controller/cUser.dart';
import 'package:crewdible_b2b/model/mPickingList.dart';
import 'package:crewdible_b2b/page/picking_proses.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_color.dart';

class PickingPage extends StatefulWidget {
  PickingPage({Key? key}) : super(key: key);

  @override
  State<PickingPage> createState() => _PickingPageState();
}

class _PickingPageState extends State<PickingPage> {
  final cPicking = Get.put(CPickingList());
  final controllerSearch = TextEditingController();

  _LoadData() async {
    await Get.find<CPickingList>().getList();
  }

  @override
  void initState() {
    super.initState();
    cPicking.getList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _LoadData();
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Picking Proses',
          style: TextStyle(fontSize: 18),
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
                    'List Basket',
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
                if (cPicking.loading) return DView.loadingBar();
                if (cPicking.list.isEmpty) return DView.empty();
                return ListView.builder(
                  itemCount: cPicking.list.length,
                  itemBuilder: (context, index) {
                    ListBasket picking = cPicking.list[index];
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
                                      picking.idBasket ?? '',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "${picking.item} SKU",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Quantity ${picking.qty}",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {
                                    Get.to(() => PickingProses(
                                        idBasket: picking.idBasket ?? ''));
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
