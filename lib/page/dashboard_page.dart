import 'package:crewdible_b2b/model/mHandover.dart';
import 'package:crewdible_b2b/page/handover_page.dart';
import 'package:crewdible_b2b/page/inbound_page.dart';
import 'package:crewdible_b2b/page/packing_page.dart';
import 'package:crewdible_b2b/page/picking_page.dart';
import 'package:d_info/d_info.dart';
import 'package:d_view/d_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_color.dart';
import '../config/session.dart';
import '../controller/cUser.dart';
import 'login_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
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
      Get.offAll(() => const LoginPage());
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
              colors: [
                Colors.white,
                AppColor.appBlueSoft.withOpacity(0.7),
              ],
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
                const SizedBox(height: 20),
                // const Text("Jumlah Order"),
                // SizedBox(height: 5),
                // const Text(
                //   "3000",
                //   style: TextStyle(
                //     fontSize: 40,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                const SizedBox(height: 30),
                // GridView(
                //   physics: const NeverScrollableScrollPhysics(),
                //   shrinkWrap: true,
                //   padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //     crossAxisCount: 2,
                //     mainAxisExtent: 110,
                //     crossAxisSpacing: 16,
                //     mainAxisSpacing: 16,
                //   ),
                //   children: [
                //     inBound(textTheme),
                //     outBound(textTheme),
                //   ],
                // ),
                SizedBox(height: 2),
                // Bisa Di scroll
                Expanded(
                  child: ListView(
                    children: [
                      Card(
                        color: AppColor.appRedSoft,
                        // child: AspectRatio(
                        //   aspectRatio: 20 / 9,
                        //   child: DChartBar(
                        //     data: [
                        //       {
                        //         'id': 'Bar',
                        //         'data': [
                        //           {'domain': 'Mon', 'measure': 40},
                        //           {'domain': 'Tue', 'measure': 70},
                        //           {'domain': 'Wed', 'measure': 30},
                        //           {'domain': 'Thu', 'measure': 20},
                        //           {'domain': 'Fri', 'measure': 25},
                        //           {'domain': 'Sat', 'measure': 19},
                        //           {'domain': 'Sun', 'measure': 10},
                        //         ],
                        //       },
                        //     ],
                        //     barColor: (barData, index, id) => AppColor.appBlue,
                        //   ),
                        // ),
                      ),
                      SizedBox(height: 15),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 80,
                                    height: 80,
                                    // color: Colors.amber,
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => InboundPage());
                                      },
                                      splashColor: Colors.green,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              "assets/images/inbound-1.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                SizedBox(height: 5),
                                Text(
                                  "Inbound",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.79,
                                    height: 80,
                                    // color: Colors.amber,
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => PickingPage());
                                      },
                                      splashColor: Colors.green,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              "assets/images/picking-1.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                SizedBox(height: 5),
                                Text(
                                  "Picking",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 80,
                                    height: 80,
                                    // color: Colors.amber,
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => PackingPage());
                                      },
                                      splashColor: Colors.green,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              "assets/images/packing-1.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                SizedBox(height: 5),
                                Text(
                                  "Packing",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 80,
                                    height: 80,
                                    // color: Colors.amber,
                                    child: InkWell(
                                      onTap: () {},
                                      splashColor: Colors.green,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              "assets/images/stock.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                SizedBox(height: 5),
                                Text(
                                  "Stock",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 80,
                                    height: 80,
                                    // color: Colors.amber,
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(() => HandoverPage());
                                      },
                                      splashColor: Colors.green,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              "assets/images/handover_.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                SizedBox(height: 5),
                                Text(
                                  "Handover",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                    width: 80,
                                    height: 80,
                                    // color: Colors.amber,
                                    child: InkWell(
                                      onTap: () {
                                        // Get.to(() => StockOpnamePage());
                                      },
                                      splashColor: Colors.green,
                                      child: Center(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Image.asset(
                                              "assets/images/so.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ],
                                        ),
                                      ),
                                    )),
                                SizedBox(height: 5),
                                Text(
                                  "Stock Opname",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
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

  Container inBound(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.appPrimary,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inbound',
            style: textTheme.titleLarge,
          ),
          Row(
            children: [
              Obx(() {
                return Text(
                  "update",
                  style: textTheme.headline4!.copyWith(
                    color: Colors.white,
                  ),
                );
              }),
              DView.spaceWidth(8),
              const Text(
                'Item',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container outBound(TextTheme textTheme) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.appRed,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Outbound',
            style: textTheme.titleLarge,
          ),
          Row(
            children: [
              Obx(() {
                return Text(
                  "update",
                  style: textTheme.headline4!.copyWith(
                    color: Colors.white,
                  ),
                );
              }),
              DView.spaceWidth(8),
              const Text(
                'Item',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
