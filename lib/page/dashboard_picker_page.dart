import 'package:crewdible_b2b/page/inbound_page.dart';
import 'package:crewdible_b2b/page/login_page.dart';
import 'package:crewdible_b2b/page/packing_page.dart';
import 'package:crewdible_b2b/page/picking_page.dart';
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_color.dart';
import '../config/session.dart';
import '../controller/cUser.dart';
import 'handover_page.dart';

class DashboardPickerPage extends StatefulWidget {
  const DashboardPickerPage({Key? key}) : super(key: key);

  @override
  State<DashboardPickerPage> createState() => _DashboardPickerPageState();
}

class _DashboardPickerPageState extends State<DashboardPickerPage> {
  final cUser = Get.put(CUser());
  // final cDashboard = Get.put(CDashboard());

  logout() async {
    bool? yes = await DInfo.dialogConfirmation(
      context,
      'Logout',
      'You sure to logout?',
    );
    if (yes ?? false) {
      Session.clearUser();
      Get.off(() => const LoginPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Stack(
        children: [
          //Background
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppColor.appPrimary, Colors.white],
            )),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Hai, ${cUser.data.namaUser ?? ''}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      IconButton(
                        onPressed: () => logout(),
                        icon: const Icon(Icons.logout),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 2),
                // Bisa Di scroll
                Expanded(
                  child: ListView(
                    children: [
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 10,
                                  shadowColor: Colors.black,
                                  color: Colors.white70,
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => InboundPage());
                                    },
                                    splashColor: Colors.black54,
                                    child: SizedBox(
                                      width: 110,
                                      height: 110,
                                      child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Column(
                                            children: [
                                              CircleAvatar(
                                                backgroundColor:
                                                    AppColor.appSoftColor,
                                                radius: 30,
                                                child: Image.asset(
                                                  "assets/images/inbound-1.png",
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                              SizedBox(height: 8),
                                              Text(
                                                "Inbound",
                                                style: TextStyle(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ],
                                          )),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 10,
                                  shadowColor: Colors.black,
                                  color: Colors.white70,
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => PickingPage());
                                    },
                                    splashColor: Colors.black54,
                                    child: SizedBox(
                                      width: 110,
                                      height: 110,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  AppColor.appSoftColor,
                                              radius: 30,
                                              child: Image.asset(
                                                "assets/images/picking-1.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "Picking",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 10,
                                  shadowColor: Colors.black,
                                  color: Colors.white70,
                                  child: InkWell(
                                    onTap: () {
                                      Get.to(() => HandoverPage());
                                    },
                                    splashColor: Colors.black54,
                                    child: SizedBox(
                                      width: 110,
                                      height: 110,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            CircleAvatar(
                                              backgroundColor:
                                                  AppColor.appSoftColor,
                                              radius: 30,
                                              child: Image.asset(
                                                "assets/images/handover_.png",
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              "Handover",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
