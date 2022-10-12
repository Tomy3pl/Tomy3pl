import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/cPacking.dart';
import '../model/mPacking.dart';

class ListOrderReady extends StatefulWidget {
  const ListOrderReady({Key? key}) : super(key: key);
  // final String type;

  @override
  State<ListOrderReady> createState() => _ListOrderReadyState();
}

class _ListOrderReadyState extends State<ListOrderReady> {
  final cPacking = Get.put(CPacking());

  pick(Packing packing) async {
    final controllerQuantity = TextEditingController();
    bool yes = await Get.dialog(
      AlertDialog(
        title: const Text('Mapping Driver'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Get.back(result: true);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
    if (yes) {
      Map<String, dynamic> data = {
        'order_id': packing.orderId,
      };

      Get.back(result: data);
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Order'),
        titleSpacing: 0,
      ),
      body: Obx(() {
        if (cPacking.loading) return DView.loadingCircle();
        if (cPacking.listItem.isEmpty) return DView.empty();
        return ListView.separated(
          itemCount: cPacking.listItem.length,
          separatorBuilder: (context, index) {
            return const Divider(
              height: 1,
              color: Colors.white60,
              indent: 16,
              endIndent: 16,
            );
          },
          itemBuilder: (context, index) {
            Packing packing = cPacking.listItem[index];
            return GestureDetector(
              onTap: () {
                pick(packing);
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  16,
                  index == 0 ? 16 : 8,
                  0,
                  index == 9 ? 16 : 0,
                ),
                color: Colors.transparent,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        elevation: 5,
                        shadowColor: Colors.black,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        packing.orderId ?? '',
                                        style: textTheme.titleMedium!.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
