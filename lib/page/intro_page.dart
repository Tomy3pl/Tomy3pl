import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../page/login_page.dart';
import 'package:lottie/lottie.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 300,
              height: 300,
              child: Lottie.asset("assets/lottie/animasiWH.json"),
            ),
            SizedBox(
              width: 250,
              height: 100,
              child: Image.asset("assets/images/crewdible_logo.png"),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () => Get.off(() => const LoginPage()),
              child: const Text(
                "Login now",
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(150, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
