import 'dart:convert';
import 'dart:io';

import 'package:cool_alert/cool_alert.dart';
import 'package:crewdible_b2b/config/app_color.dart';
import 'package:crewdible_b2b/controller/cInbound.dart';
import 'package:crewdible_b2b/page/inbound_page.dart';
import 'package:crewdible_b2b/source/sInbound.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:signature/signature.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../model/mInbound.dart';

class InboundReceivedPage extends StatefulWidget {
  InboundReceivedPage({Key? key, required this.nopo}) : super(key: key);
  final String? nopo;
  @override
  State<InboundReceivedPage> createState() => _InboundReceivedPageState();
}

class _InboundReceivedPageState extends State<InboundReceivedPage> {
  final cInbound = Get.put(CInbound());
  final controllerQty = TextEditingController();
  final controllerDriver = TextEditingController();
  final controllerPo = TextEditingController();
  final controllerTglDatang = TextEditingController();
  final controllerPlatNo = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final now = new DateTime.now();

  late final Function onIncTap;
  late final Function onDecTap;
  late final int quantity;
  File? _image;
  File? _image1;

  SignatureController controller = SignatureController(
    penStrokeWidth: 3,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white30,
  );

  get index => null;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.camera);
    _image = File(imageFile!.path);
    setState(() {});
  }

  Future getImage1() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.camera);
    _image1 = File(imageFile!.path);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // ListInbound list = cInbound.list[index];
    // DateTime dateToday = new DateTime.now();
    // ConnectionState.waiting =
    // String date = DateFormat().add_yMd().add_jms().format(now); // 2021-06-24
    String date = DateFormat().add_yMd().add_Hms().format(now); // 2021-06-24
    cInbound.setData(widget.nopo ?? '');
    controllerPo.text = cInbound.data.nopo ?? '';
    controllerTglDatang.text = date;
    controllerQty.text = cInbound.data.qty ?? '';
    const CircularProgressIndicator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Form ${widget.nopo}',
          style: TextStyle(fontSize: 16),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: controllerPo,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'No PO',
                enabled: false,
              ),
              validator: (value) => value == '' ? "Don't Empty" : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: controllerTglDatang,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Tanggal Kedatangan',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: controllerQty,
              decoration: const InputDecoration(
                labelText: 'Quantity',
                enabled: false,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: controllerDriver,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nama Driver',
              ),
              validator: (value) => value == '' ? "Don't Empty" : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextFormField(
              controller: controllerPlatNo,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Nomor Plat',
              ),
              validator: (value) => value == '' ? "Don't Empty" : null,
            ),
          ),
          DView.spaceHeight(10),
          Card(
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
                      const Text(
                        'Foto Surat Jalan',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _image != null
                          ? Container(
                              height: 200,
                              width: 340,
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ))
                          : TextButton(
                              onPressed: () async {
                                await getImage();
                              },
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 32,
                                color: Colors.black,
                              )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          DView.spaceHeight(10),
          Card(
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
                      const Text(
                        'Foto Barang',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      _image1 != null
                          ? Container(
                              height: 200,
                              width: 340,
                              child: Image.file(
                                _image1!,
                                fit: BoxFit.cover,
                              ))
                          : TextButton(
                              onPressed: () async {
                                await getImage1();
                              },
                              child: Icon(
                                Icons.camera_alt_outlined,
                                size: 32,
                                color: Colors.black,
                              )),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () async {
                submite();
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  Future submite() async {
    bool? yes = await Get.dialog(
      AlertDialog(
        title: const Text('Apakah data sudah di isi semua ?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DView.spaceHeight(8),
            const Text('klik yes jika sudah yakin'),
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
          Uri.parse("https://wms-b2b.dev.crewdible.co.id/ApiInbound/updatePo");
      var request = http.MultipartRequest('POST', uri);
      request.fields['nopo'] = widget.nopo ?? '';
      request.fields['noplat'] = controllerPlatNo.text;
      request.fields['driver'] = controllerDriver.text;
      request.fields['date'] = controllerTglDatang.text;

      var pic = await http.MultipartFile.fromPath("foto1", _image!.path);
      request.files.add(pic);
      var pic2 = await http.MultipartFile.fromPath("foto2", _image1!.path);
      request.files.add(pic2);
      var response = await request.send();

      if (response.statusCode == 200) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Berhasil Inbound',
        ).then((value) => Get.off(() => InboundPage()));
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: 'Gagal Inbound',
        );
      }
    }
  }
}
