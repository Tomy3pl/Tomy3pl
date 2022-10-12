import 'package:crewdible_b2b/controller/cInbound.dart';
import 'package:crewdible_b2b/page/receive_inbound_page.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_color.dart';
import '../model/mInbound.dart';

class InboundPage extends StatefulWidget {
  InboundPage({Key? key}) : super(key: key);

  @override
  State<InboundPage> createState() => _InboundPageState();
}

class _InboundPageState extends State<InboundPage> {
  final cInbound = Get.put(CInbound());
  final controllerSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    _InboundPageState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          'Inbound Proses',
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
                    'List Purcase Order',
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
                RxStatus.loading();
                if (cInbound.loading) return DView.loadingBar();
                if (cInbound.list.isEmpty) return DView.empty();
                return ListView.builder(
                  itemCount: cInbound.list.length,
                  itemBuilder: (context, index) {
                    ListInbound list = cInbound.list[index];
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
                                      list.noPo ?? '',
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
                                      "${list.jumlahItem ?? ''} SKU",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      list.status == '2'
                                          ? 'Sudah diterima'
                                          : 'Belum diterima',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: list.status == '0'
                                            ? AppColor.appRed
                                            : AppColor.appPrimary,
                                      ),
                                    ),
                                  ],
                                ),
                                list.status == '0'
                                    ? IconButton(
                                        onPressed: () {
                                          Get.to(() => ReceiveInboundPage(
                                              nopo: list.noPo));
                                        },
                                        icon: Icon(
                                            Icons.add_shopping_cart_rounded),
                                      )
                                    : Container(),
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
