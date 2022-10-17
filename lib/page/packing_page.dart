import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:crewdible_b2b/page/packing_proses.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import '../config/app_color.dart';
import '../controller/cPacking.dart';
import '../model/mPacking.dart';

class PackingPage extends StatefulWidget {
  PackingPage({Key? key}) : super(key: key);

  @override
  State<PackingPage> createState() => _PackingPageState();
}

class _PackingPageState extends State<PackingPage> {
  final cPacking = Get.put(CPacking());
  final controllerSearch = TextEditingController();
  String _scanBarcode = 'unknown';
  final audioPlayer = AudioPlayer();

  _LoadData() async {
    await Get.find<CPacking>().getList();
  }

  @override
  void initState() {
    setState(() {});
    super.initState();
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
          'Packing Proses',
          style: TextStyle(fontSize: 18),
        ),
        actions: [search()],
      ),
      body: Container(
        color: Colors.grey[200],
        child: Column(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    'List Order',
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
                if (cPacking.loading) return DView.loadingBar();
                if (cPacking.list.isEmpty) return DView.empty();
                return ListView.separated(
                  itemCount: cPacking.list.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                      color: Colors.white60,
                      indent: 14,
                      endIndent: 16,
                    );
                  },
                  itemBuilder: (context, index) {
                    Packing packing = cPacking.list[index];
                    return Padding(
                      padding: const EdgeInsets.all(3.0),
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      packing.orderId ?? '',
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
                                    Get.off(() => PackingProses(
                                          orderId: packing.orderId ?? '',
                                        ));
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

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
      return;
    }
    if (!mounted) return;

    if (barcodeScanRes == "-1") {
      return;
    }
    await audioPlayer.setVolume(1.0);
    await audioPlayer.play(AssetSource('notifacation.mp3'));
    Get.to(() => PackingProses(orderId: _scanBarcode));

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  IconButton search() {
    return IconButton(
      onPressed: () {
        scanBarcodeNormal();
      },
      icon: const Icon(
        Icons.qr_code_2,
        color: Colors.black,
        size: 30,
      ),
    );
  }
}
