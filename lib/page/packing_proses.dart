import 'dart:convert';
import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:crewdible_b2b/controller/cUser.dart';
import 'package:crewdible_b2b/page/packing_page.dart';
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

import '../controller/cPacking.dart';

class PackingProses extends StatefulWidget {
  PackingProses({Key? key, required this.orderId}) : super(key: key);
  final String orderId;

  @override
  State<PackingProses> createState() => _PackingProsesState();
}

class _PackingProsesState extends State<PackingProses> {
  final cUser = Get.put(CUser());
  final cPacking = Get.put(CPacking());
  final controllerOrder = TextEditingController();
  final controllerAssign = TextEditingController();
  final controllerStatus = TextEditingController();
  final picker = ImagePicker();

  File? _image;
  File? _image1;
  String? imageName;
  String? imagedata;

  Future getImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1920,
      maxWidth: 1080,
    );
    _image = File(imageFile!.path);
    setState(() {});
  }

  Future getImage1() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 1920,
      maxWidth: 1080,
    );
    _image1 = File(imageFile!.path);
    setState(() {});
  }

  Future submite() async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Packing Product', 'Apakah proses packing sudah selesai ?');
    if (yes ?? false) {
      final uri =
          Uri.parse("https://wms-b2b.dev.crewdible.co.id/ApiPacking/update");
      var request = http.MultipartRequest('POST', uri);
      request.fields['id'] = widget.orderId;
      request.fields['assign'] = '${cUser.data.namaUser}';
      var pic = await http.MultipartFile.fromPath("foto", _image!.path);
      request.files.add(pic);
      var pic2 = await http.MultipartFile.fromPath("fotoAfter", _image1!.path);
      request.files.add(pic2);
      var response = await request.send();

      if (_image == null) {
        AnimatedSnackBar.rectangle(
          'Error',
          'Gagal submit packing',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.dark,
        ).show(context);
      } else {}
      if (response.statusCode == 200) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Berhasil packing',
        ).then((value) {
          Get.off(() => PackingPage());
          setState(() {});
        });
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: 'Gagal packing',
        );
      }
    }
  }

  @override
  void initState() {
    cPacking.setData(widget.orderId);
    controllerOrder.text = cPacking.data.orderId ?? '';
    controllerAssign.text = cUser.data.namaUser ?? '';
    controllerStatus.text = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Orderan ${widget.orderId}',
          style: TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              DView.spaceHeight(10),
              GetBuilder<CPacking>(builder: (_) {
                if (cPacking.data.orderId == null) return DView.empty();
                List list = jsonDecode(cPacking.data.list!);
                if (list.isEmpty) return DView.empty();
                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: list.length,
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 1,
                      color: Colors.white60,
                      indent: 16,
                      endIndent: 16,
                    );
                  },
                  itemBuilder: (context, index) {
                    Map packing = list[index];
                    return Column(
                      children: [
                        Card(
                          margin: EdgeInsets.symmetric(vertical: 5),
                          color: Colors.white.withOpacity(0.7),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        packing['Item_id'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      DView.spaceHeight(10),
                                      Text(
                                        packing['Item_detail'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Text(
                                        packing['quantity'],
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              }),
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
                            'Foto Sebelum Packing',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _image != null
                              ? Container(
                                  height: 200,
                                  width: 310,
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
                            'Foto Sesudah Packing',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _image1 != null
                              ? Container(
                                  height: 200,
                                  width: 310,
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
                  onPressed: () => submite(),
                  child: Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
