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
import 'package:signature/signature.dart';
import 'package:path_provider/path_provider.dart';
import '../config/app_color.dart';
import '../model/mListHandover.dart';

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

  final SignatureController _controller = SignatureController(
    penStrokeWidth: 2,
    penColor: Colors.black,
    exportBackgroundColor: Colors.white,
    exportPenColor: Colors.black,
    onDrawStart: () => print('onDrawStart called!'),
    onDrawEnd: () => print('onDrawEnd called!'),
  );

  Uint8List? exportImage;

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
    final XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );
    _image = File(imageFile!.path);
    setState(() {});
  }

  Future getImage1() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imageFile = await _picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 720,
      maxWidth: 1280,
    );
    _image1 = File(imageFile!.path);
    setState(() {});
  }

  Future submite() async {
    bool? yes = await DInfo.dialogConfirmation(
        context, 'HandOver', 'Apakah proses handover sudah selesai ?');

    if (yes ?? false) {
      if (_image == null) {
        AnimatedSnackBar.rectangle(
          'gambar tidak boleh kosong',
          'Gagal submit handover',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.dark,
        ).show(context);
        return;
      }
      if (dataRender == null) {
        AnimatedSnackBar.rectangle(
          'tanda tangan tidak boleh kosong',
          'Gagal submit handover',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.dark,
        ).show(context);
        return;
      }
      final uri =
          Uri.parse("https://wms-b2b.dev.crewdible.co.id/ApiManifest/update");
      var request = http.MultipartRequest('POST', uri);
      request.fields['id'] = widget.idHandover;
      request.fields['assign'] = '${cUser.data.namaUser}';
      request.fields['warehouse'] = '${cUser.data.warehouse}';
      var pic = await http.MultipartFile.fromPath("foto", _image!.path);
      request.files.add(pic);

      var pic2 =
          await http.MultipartFile.fromPath("tandatangan", dataRender!.path);
      request.files.add(pic2);
      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          text: 'Berhasil packing',
        ).then((value) {
          Get.off(() => HandoverPage());
          cHandover.getList();
          setState(() {});
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

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/${DateTime.now()}.png');
  }

  File? dataRender = null;

  @override
  void initState() {
    cHandover.setData(widget.idHandover);
    // _controller.addListener(() => print('Value changed'));
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
                  if (cHandover.data.idHandover == null)
                    return DView.loadingBar();
                  if (cHandover.list.isEmpty) return DView.empty();
                  List<ListHandoverItem> list = cHandover.data.listItem!;
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
                      ListHandoverItem handover = list[index];
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
                                  Column(
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
                                        handover.orderId!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w800,
                                        ),
                                      ),
                                      DView.spaceHeight(10),
                                      Text(
                                        handover.namaPenerima!,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      DView.spaceHeight(10),
                                      Container(
                                        width: 270,
                                        child: Text(
                                          handover.alamat!,
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
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
                                    width: MediaQuery.of(context).size.width *
                                        0.79,
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
                              'Tandatangan Driver',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            exportImage == null
                                ? Signature(
                                    controller: _controller,
                                    height: 200,
                                    width: MediaQuery.of(context).size.width *
                                        0.79,
                                    backgroundColor: Colors.white,
                                  )
                                : Image.memory(
                                    exportImage!,
                                    height: 200,
                                    width: MediaQuery.of(context).size.width *
                                        0.79,
                                  ),
                            Container(
                              decoration:
                                  const BoxDecoration(color: Colors.black),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  //SHOW EXPORTED IMAGE IN NEW ROUTE
                                  IconButton(
                                    icon: const Icon(Icons.image),
                                    color: Colors.blue,
                                    onPressed: () async {
                                      exportImage =
                                          await _controller.toPngBytes();
                                      final signFile = await _localFile;
                                      dataRender = await File(signFile.path)
                                          .writeAsBytes(exportImage!.toList());
                                      setState(() {});
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.undo),
                                    color: Colors.blue,
                                    onPressed: () {
                                      setState(() => _controller.undo());
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.redo),
                                    color: Colors.blue,
                                    onPressed: () {
                                      setState(() => _controller.redo());
                                    },
                                  ),
                                  //CLEAR CANVAS
                                  IconButton(
                                    icon: const Icon(Icons.clear),
                                    color: Colors.blue,
                                    onPressed: () {
                                      setState(() => _controller.clear());
                                    },
                                  ),
                                ],
                              ),
                            ),
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
