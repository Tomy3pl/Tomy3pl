import 'package:crewdible_b2b/controller/cAuth.dart';
import 'package:crewdible_b2b/controller/cUser.dart';
import 'package:crewdible_b2b/page/dashboard_page.dart';
import 'package:crewdible_b2b/page/intro_page.dart';
import 'package:crewdible_b2b/page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'config/app_color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cUser = Get.put(CUser());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.white,
        colorScheme: const ColorScheme.light().copyWith(
          primary: AppColor.appPrimary,
          onPrimary: Colors.black,
        ),
      ),
      home: Obx(() {
        if (cUser.data.idUser == null) return const LoginPage();
        return const DashboardPage();
      }),
    );
  }
}
