import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/MainScreens/first_screen.dart';
import 'package:resto_app/fingerprint/fingerprint_scan_compare.dart';
import 'package:resto_app/request/requests.dart';
import 'package:resto_app/widgets/main_option.dart';
import 'package:resto_app/widgets/one_of_options.dart';
import '../face_relations/take_picture.dart';
import '../providers/main_provider.dart';
import '../services/shared_preferences_helper.dart';
import 'login_screen.dart';
import 'usersListScreen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    // define used provider
    final proMain = Provider.of<MainProvider>(context);

    // define height and width
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    // define logger to log messages
    var logger = Logger();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'orgWork'.tr(),
          textAlign: TextAlign.center,
          style: GoogleFonts.vazirmatn(
            color: Colors.white,
            textStyle: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
            decoration: TextDecoration.none,
          ),
        ),
        centerTitle: true,
      ),
      endDrawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: h * 0.3,
              width: double.infinity,
              padding: const EdgeInsets.all(15),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: Image.asset('assets/images/Logo Coloring-05.png'),
            ),

            // register users button
            GestureDetector(
              onTap: () {
                // set employees list for chosen branch
                proMain.setEmployeeListFromAPI();
                // go to userList screen
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => UsersListScreen(),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20, right: 25, left: 25),
                height: h * 0.07,
                width: w * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'regFacesIDs'.tr(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vazirmatn(
                        color: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.people,
                      color: Colors.black,
                      size: 35,
                    ),
                  ],
                ),
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //    // logger.w('logged out successfully');
            //
            //     // remove username from shared preferences to end session
            //     //SharedPreferencesHelper.preferences.remove('username');
            //
            //     // remove all pushed screens to end session
            //     Navigator.pushAndRemoveUntil(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => MyRequests(),
            //         allowSnapshotting: true
            //       ),
            //           (Route<dynamic> route) => false,
            //     );
            //   },
            //   child: Container(
            //     margin: const EdgeInsets.only(top: 20, right: 25, left: 25),
            //     height: h * 0.07,
            //     width: w * 0.5,
            //     child: Row(
            //       mainAxisAlignment: MainAxisAlignment.end,
            //       children: [
            //         Text(
            //           'followOrders'.tr(),
            //           textAlign: TextAlign.center,
            //           style: GoogleFonts.vazirmatn(
            //             color: Colors.black,
            //             textStyle: const TextStyle(
            //               fontSize: 20,
            //               fontWeight: FontWeight.w500,
            //             ),
            //             decoration: TextDecoration.none,
            //           ),
            //         ),
            //         const SizedBox(width: 10),
            //         const Icon(
            //           Icons.app_registration_outlined,
            //           color: Colors.black,
            //           size: 35,
            //         ),
            //       ],
            //     ),
            //   ),
            // ),

            // fingerprint screen
            GestureDetector(
              onTap: () {
                logger.w('logged out successfully');

                // remove username from shared preferences to end session
                SharedPreferencesHelper.preferences.remove('username');

                // remove all pushed screens to end session
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                      (Route<dynamic> route) => false,
                );
              },
              child: Container(
                margin: const EdgeInsets.only(top: 20, right: 25, left: 25),
                height: h * 0.07,
                width: w * 0.5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'logOut'.tr(),
                      textAlign: TextAlign.center,
                      style: GoogleFonts.vazirmatn(
                        color: Colors.black,
                        textStyle: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: TextDecoration.none,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(
                      Icons.logout,
                      color: Colors.black,
                      size: 35,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
        height: h,
        width: w,
        decoration:  BoxDecoration(
          // color: Colors.blue.shade100,
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: h * 0.1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                MainOption('annualVacations'.tr(),25),
                MainOption('sickVacations'.tr(),20),
              ],
            ),
            SizedBox(
              height: h * 0.15,
            ),
            Container(
              height: h * 0.06,
              width: w * 0.7,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.1),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Center(
                child: Text(
                  'logInUsingFaceIDOrFingerprint'.tr(),
                  textAlign: TextAlign.center,
                  style: GoogleFonts.vazirmatn(
                    color: Colors.white,
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: h * 0.05,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: h * 0.22,
                  width: w * 0.33,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: h*0.18,
                        width: w*0.28,
                        child: IconButton(
                          onPressed: () async {

                            final cameras = await availableCameras();
                            final firstCamera = cameras.firstWhere(
                                  (camera) => camera.lensDirection == CameraLensDirection.front,
                            );

                            proMain.setEmployeeListFromAPI();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                // builder: (context) => FaceDetectorView(proMain.employeesList),
                                builder: (context) => TakePicture(camera: firstCamera),
                              ),
                            );

                          },
                          icon: Image.asset(
                            'assets/images/qr-code.png',
                            width: h*0.12,
                            height: h*0.12,
                          ),
                        ),
                      ),
                      Text(
                        'pressHere'.tr(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.vazirmatn(
                          color: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: h * 0.22,
                  width: w * 0.33,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: h*0.18,
                        width: w*0.28,
                        child: IconButton(
                          onPressed: () async {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => FirstScreen(checkInOrOut: 1),
                              ),
                            );
                            // final cameras = await availableCameras();
                            // final firstCamera = cameras.firstWhere(
                            //       (camera) => camera.lensDirection == CameraLensDirection.front,
                            // );
                            //
                            // proMain.setEmployeeListFromAPI();
                            //
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     // builder: (context) => FaceDetectorView(proMain.employeesList),
                            //     builder: (context) => TakePicture(camera: firstCamera),
                            //   ),
                            // );
                          },
                          icon: Image.asset(
                            'assets/images/fingerprint-icon-png-13.jpg',
                            width: h*0.12,
                            height: h*0.12,
                          ),
                        ),
                      ),
                      Text(
                        'pressHere'.tr(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.vazirmatn(
                          color: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}