import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:crewdible_b2b/config/app_color.dart';
import 'package:crewdible_b2b/controller/cInbound.dart';
import 'package:crewdible_b2b/model/mInboundDetail.dart';
import 'package:crewdible_b2b/page/inbound_page.dart';
import 'package:crewdible_b2b/page/inbound_received.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'package:http/http.dart' as http;

import '../model/mListInbound.dart';

class ReceiveInboundPage extends StatefulWidget {
  ReceiveInboundPage({Key? key, required this.nopo}) : super(key: key);
  final String? nopo;
  @override
  State<ReceiveInboundPage> createState() => _ReceiveInboundPageState();
}

class _ReceiveInboundPageState extends State<ReceiveInboundPage> {
  final cInbound = Get.put(CInbound());
  final controllerQty = TextEditingController();

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    cInbound.setData(widget.nopo ?? '');
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    cInbound.setData(widget.nopo ?? '');
    setState(() {});
  }

  bool loadingData = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Receive ${widget.nopo}',
          style: TextStyle(fontSize: 16),
        ),
        actions: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                textStyle: const TextStyle(fontSize: 12)),
            child: loadingData
                ? CircularProgressIndicator(color: Colors.black)
                : Text('Selesai'),
            onPressed: () async {
              if (loadingData) return;
              setState(() => loadingData = true);
              cInbound.inboundDetail?.listItem?.forEach((element) async {
                final uri = Uri.parse(
                    "https://wms-b2b.dev.crewdible.co.id/ApiInbound/update");
                var request = http.MultipartRequest('POST', uri);
                request.fields['id'] = element.id;
                request.fields['quantity'] = element.qtyGet;
                var response = await request.send();
                print(response);
                print("${response.statusCode} ${element.id} ${element.qtyGet}");
              });
              await Future.delayed(const Duration(seconds: 5));
              Get.off(() => InboundReceivedPage(nopo: widget.nopo));
              setState(() => loadingData = false);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                DView.spaceHeight(10),
                GetBuilder<CInbound>(builder: (_) {
                  if (cInbound.data.nopo == null) return DView.loadingBar();
                  if (cInbound.isLoading.isTrue) return DView.loadingBar();
                  print(cInbound.data.listItem);
                  List<ListDetailItem> list = cInbound.data.listItem!;
                  if (list.isEmpty) return DView.empty();
                  // if (cInbound.loading) return DView.loadingBar();
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
                      ListDetailItem picking = list[index];
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
                                          picking.itemId!,
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
                                            picking.itemDetail!,
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
                                          picking.qty!,
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Checkbox(
                                      value: picking.selected,
                                      onChanged: (value) {
                                        cInbound.onItemCheck(picking, value);
                                        setState(() {
                                          picking.selected = value ?? false;
                                        });
                                      })
                                ],
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

  Future submite(id) async {
    bool? yes = await Get.dialog(
      AlertDialog(
        title: const Text('Quantity'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DInput(
              controller: controllerQty,
              hint: 'Masukan Qty',
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
                Get.back(result: true);
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
          Uri.parse("https://wms-b2b.dev.crewdible.co.id/ApiInbound/update");
      var request = http.MultipartRequest('POST', uri);
      request.fields['id'] = id;
      request.fields['quantity'] = controllerQty.text;

      var response = await request.send();

      if (response.statusCode == 200) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Berhasil',
        ).then((value) {
          Get.off(ReceiveInboundPage(nopo: '${widget.nopo}'));
          setState(() {});
        });
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: 'Gagal',
        );
      }
    }
  }
}
