import 'dart:convert';
import 'dart:io';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:crewdible_b2b/controller/cAddDriver.dart';
import 'package:crewdible_b2b/controller/cHandover.dart';
import 'package:crewdible_b2b/controller/cUser.dart';
import 'package:crewdible_b2b/model/mHandover.dart';
import 'package:crewdible_b2b/page/dashboard_page.dart';
import 'package:crewdible_b2b/page/handover_page.dart';
import 'package:crewdible_b2b/page/list_order_ready.dart';
import 'package:crewdible_b2b/page/packing_proses.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

import '../config/app_color.dart';

class ListHandover extends StatefulWidget {
  ListHandover({Key? key, required this.idHandover}) : super(key: key);
  final String idHandover;

  @override
  State<ListHandover> createState() => _ListHandoverState();
}

class _ListHandoverState extends State<ListHandover> {
  final cHandover = Get.put(CHandover());
  final cUser = Get.put(CUser());
  final picker = ImagePicker();

  File? _image;
  File? _image1;
  String? imageName;
  String? imagedata;

  Future<void> refreshData() async {
    await Future.delayed(const Duration(seconds: 2));
    cHandover.setData(widget.idHandover);
    setState(() {});
  }

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

  Future submite() async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'Packing Product', 'Apakah proses packing sudah selesai ?');
    if (yes ?? false) {
      final uri =
          Uri.parse("https://wms-b2b.dev.crewdible.co.id/ApiManifest/update");
      var request = http.MultipartRequest('POST', uri);
      request.fields['id'] = widget.idHandover;
      request.fields['assign'] = '${cUser.data.namaUser}';
      request.fields['warehouse'] = '${cUser.data.warehouse}';
      var pic = await http.MultipartFile.fromPath("foto", _image!.path);
      request.files.add(pic);
      var pic2 =
          await http.MultipartFile.fromPath("tandatangan", _image1!.path);
      request.files.add(pic2);
      var response = await request.send();

      if (_image == null) {
        AnimatedSnackBar.rectangle(
          'Error',
          'Gagal submit handover',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.dark,
        ).show(context);
      } else {}
      if (response.statusCode == 200) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Berhasil handover',
        );Get.off(() => HandoverPage());
        setState(() {
          
        });
      } else {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          text: 'Gagal Handover',
        );
      }
    }
  }

  @override
  void initState() {
    cHandover.setData(widget.idHandover);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.idHandover),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                DView.spaceHeight(10),
                GetBuilder<CHandover>(builder: (_) {
                  if (cHandover.data.idHandover == null) return DView.empty();
                  List list = jsonDecode(cHandover.data.listItem!);
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
                      Map handover = list[index];
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
                                          cHandover.data.driver ?? '',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        DView.spaceHeight(10),
                                        Text(
                                          handover['Item_id'],
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w800,
                                          ),
                                        ),
                                        DView.spaceHeight(10),
                                        Text(
                                          handover['Item_detail'],
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
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Text(
                                          handover['quantity'],
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
                              'Foto Driver',
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
                              'Foto Driver & Barang',
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
      ),
    );
  }
}
