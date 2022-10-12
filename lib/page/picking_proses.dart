import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:crewdible_b2b/controller/cPickingList.dart';
import 'package:crewdible_b2b/controller/cUser.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../config/app_color.dart';
import '../model/mListItem.dart';

class PickingProses extends StatefulWidget {
  PickingProses({Key? key, required this.idBasket}) : super(key: key);
  final String? idBasket;

  @override
  State<PickingProses> createState() => _PickingProsesState();
}

class _PickingProsesState extends State<PickingProses> {
  final cUser = Get.put(CUser());
  final cPickingList = Get.put(CPickingList());
  final controllerQty = TextEditingController();

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    cPickingList.setData(widget.idBasket ?? '');
    setState(() {});
  }

  @override
  void initState() {
    cPickingList.setData(widget.idBasket ?? '');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'List Item ${widget.idBasket}',
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                DView.spaceHeight(10),
                GetBuilder<CPickingList>(builder: (_) {
                  if (cPickingList.data.idBasket == null)
                    return DView.loadingBar();
                  List list = jsonDecode(cPickingList.data.listItem!);

                  if (list.isEmpty) return DView.loadingBar();
                  if (cPickingList.loading) return DView.loadingBar();
                  return ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: list.length,
                    separatorBuilder: (context, index) {
                      return const Divider(
                        height: 1,
                        color: Colors.white60,
                        indent: 10,
                        endIndent: 10,
                      );
                    },
                    itemBuilder: (context, index) {
                      Map picking = list[index];
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            elevation: 5,
                            shadowColor: Colors.black,
                            margin: EdgeInsets.symmetric(vertical: 5),
                            color: Colors.white.withOpacity(0.9),
                            child: InkWell(
                              onTap: () {
                                submite(picking['id']);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(19.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            picking['itemId'],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w800,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Container(
                                            width: 270,
                                            child: Text(
                                              picking['itemDetail'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            picking['qty'],
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            picking['status'] == "1"
                                                ? 'Sudah dipick'
                                                : 'Belum dipick',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                              color: picking['status'] == "1"
                                                  ? AppColor.appPrimary
                                                  : AppColor.appRed,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future submite(picking) async {
    bool? yes = await Get.dialog(
      AlertDialog(
        title: const Text('Quantity'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DInput(
              controller: controllerQty,
              hint: 'Masukan quantity',
              inputType: TextInputType.number,
            ),
            DView.spaceHeight(8),
            const Text('Yes to confirm'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              if (controllerQty.text == '') {
                DInfo.toastError("Quantity don't empty");
              } else {
                Get.reloadAll();
              }
            },
            child: const Text('Yes'),
          ),
        ],
      ),
      barrierDismissible: false,
    );

    if (yes ?? false) {
      final uri =
          Uri.parse("https://wms-b2b.dev.crewdible.co.id/ApiPicking/update");
      var request = http.MultipartRequest('POST', uri);
      request.fields['id'] = picking;
      request.fields['quantity'] = controllerQty.text;
      request.fields['warehouse'] = cUser.data.warehouse!;

      var response = await request.send();

      if (response.statusCode == 200) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Berhasil picking',
        ).then((value) => Get.reloadAll());
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: 'Gagal picking',
        );
      }
    }
  }
}
