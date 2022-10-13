import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:crewdible_b2b/controller/cUser.dart';
import 'package:crewdible_b2b/page/dashboard_page.dart';
import 'package:crewdible_b2b/page/dashboard_picker_page.dart';
import 'package:crewdible_b2b/page/packing_page.dart';
import 'package:crewdible_b2b/page/picking_page.dart';
import 'package:d_info/d_info.dart';
import 'package:d_input/d_input.dart';
import 'package:d_method/d_method.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import '../../config/app_color.dart';
import '../source/sUser.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cUser = Get.find<CUser>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();

  void login() async {
    if (controllerEmail.text.isNotEmpty && controllerPassword.text.isNotEmpty) {
      bool success = await SourceUser.login(
        controllerEmail.text,
        controllerPassword.text,
      );

      if (GetUtils.isEmail(controllerEmail.text)) {
        if (success) {
          DInfo.closeDialog(actionAfterClose: () {
            DMethod.printTitle('Level User', cUser.data.level ?? '');
            DView.loadingCircle();
            Get.to(() => const DashboardPage());
          });
          // ignore: use_build_context_synchronously
          AnimatedSnackBar.rectangle(
            'Success',
            '${cUser.data.namaUser ?? ''} Berhasil login !',
            type: AnimatedSnackBarType.success,
            brightness: Brightness.dark,
          ).show(context);
        } else {
          // ignore: use_build_context_synchronously
          AnimatedSnackBar.rectangle(
            'Error',
            'Gagal Login, data yang dimasukan salah !',
            type: AnimatedSnackBarType.error,
            brightness: Brightness.dark,
          ).show(context);
        }
      } else {
        // ignore: use_build_context_synchronously
        AnimatedSnackBar.rectangle(
          'Error',
          'Masukan Email anda !',
          type: AnimatedSnackBarType.error,
          brightness: Brightness.dark,
        ).show(context);
      }
    } else {
      AnimatedSnackBar.rectangle(
        'Error',
        'Gagal Login data tidak ditemukan !',
        type: AnimatedSnackBarType.error,
        brightness: Brightness.dark,
      ).show(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(builder: (context, boxConstraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: boxConstraints.maxHeight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DView.spaceHeight(
                        MediaQuery.of(context).size.height * 0.04,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/warehouse.png',
                          width: 200,
                          height: 200,
                        ),
                      ),
                      DView.spaceHeight(
                        MediaQuery.of(context).size.height * 0.000001,
                      ),
                      Center(
                        child: Image.asset(
                          'assets/images/crewdible_logo.png',
                          width: 300,
                          height: 200,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      input(controllerEmail, Icons.email, 'Email'),
                      DView.spaceHeight(),
                      Obx(
                        () => TextField(
                          controller: controllerPassword,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              onPressed: () => cUser.hidden.toggle(),
                              icon: cUser.hidden.isTrue
                                  ? Icon(Icons.remove_red_eye_outlined)
                                  : const Icon(Icons.remove_red_eye),
                            ),
                            fillColor: Colors.blueGrey[100],
                            filled: true,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            prefixIcon:
                                Icon(Icons.vpn_key, color: AppColor.appText),
                            hintText: 'Masukan Password ',
                          ),
                          obscureText: cUser.hidden.value,
                        ),
                      ),
                      DView.spaceHeight(),
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            login();
                          },
                          child: const Text(
                            'LOGIN',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      DView.spaceHeight(
                        MediaQuery.of(context).size.height * 0.15,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget input(
    TextEditingController controller,
    IconData icon,
    String hint, [
    bool obsecure = false,
  ]) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        fillColor: Colors.blueGrey[100],
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(6),
        ),
        prefixIcon: Icon(icon, color: AppColor.appText),
        hintText: hint,
      ),
      obscureText: obsecure,
    );
  }
}
