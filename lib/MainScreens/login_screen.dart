import 'dart:convert';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:resto_app/MainScreens/first_screen.dart';
import 'package:resto_app/MainScreens/main_screen.dart';
import '../providers/main_provider.dart';
import '../services/shared_preferences_helper.dart';
import '../widgets/LoginTextField.dart';
import '../constants/used_APIs.dart';

class LoginScreen extends StatelessWidget {
  // define needed controllers : for username and password
  final TextEditingController controllerUser = TextEditingController();
  final TextEditingController controllerPass = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // define providers
    final proMain = Provider.of<MainProvider>(context);

    // define device's height and width
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    // define logger to log messages
    var logger = Logger();

    // returned widget
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: h * 0.12),
        height: h,
        width: w,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: w * 0.45,
                width: w * 0.45,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/Logo Coloring-04.png'),
                  ),
                ),
              ),
              Text(
                'restoTime'.tr(),
                textAlign: TextAlign.center,
                style: GoogleFonts.vazirmatn(
                  color: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                  decoration: TextDecoration.none,
                ),
              ),
              LoginTextField(
                controllerUser,
                'username'.tr(),
                Icons.person,
                false,
              ),
              LoginTextField(
                controllerPass,
                'password'.tr(),
                Icons.key,
                true,
              ),
              SizedBox(height: h / 40),
              SizedBox(
                width: w * 0.75,
                height: h / 20,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00b1eb),
                    // Set button color
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(20), // Set button border radius
                    ),
                  ),
                  onPressed: () async {
                    logger.w(
                      'username : ${controllerUser.text}\npassword : ${controllerPass.text}',
                    );

                    var request = http.Request(
                      'GET',
                      Uri.parse(
                        UsedAPIs.getOwnerLoginAPIURL(
                            controllerUser.text, controllerPass.text),
                      ),
                    );

                    http.StreamedResponse response = await request.send();

                    if (response.statusCode == 200) {
                      print('aaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');

                      print('fetch OwnerLogin API success');

                      Map<String, dynamic> apiMap = jsonDecode(
                        await response.stream.bytesToString(),
                      );

                      // set token and username to shared preferences
                      await SharedPreferencesHelper.preferences.setString(
                        'token',
                        apiMap['token'],
                      );
                      await SharedPreferencesHelper.preferences.setString(
                        'username',
                        controllerUser.text,
                      );

                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => const MainScreen(),
                        ),
                      );
                    } else {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.SCALE,
                        dialogType: DialogType.ERROR,
                        btnOkText: 'ok'.tr(),
                        body: Center(
                          child: Text(
                            'invalid'.tr(),
                            textAlign: TextAlign.center,
                            style: GoogleFonts.vazirmatn(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                              ),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                        title: 'This is Ignored',
                        desc: 'This is also Ignored',
                        btnOkOnPress: () {},
                      ).show();
                      print('sssssssssssssssssssssss');
                      print(response.reasonPhrase);
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'login'.tr(),
                        textAlign: TextAlign.center,
                        style: GoogleFonts.vazirmatn(
                          color: Colors.white,
                          textStyle: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Icon(Icons.login),
                    ],
                  ),
                ),
              ),
              SizedBox(height: h / 7),
              Container(
                height: w * 0.12,
                width: w * 0.12,
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(5)),
                child: IconButton(
                  onPressed: () {
                    // change language button
                    if (context.locale == const Locale('ar')) {
                      context.setLocale(const Locale('en'));
                      proMain.setEnglishLanguageToSharedPreferences();
                      logger.w('language set from English to Arabic');
                    } else {
                      context.setLocale(const Locale('ar'));
                      proMain.setArabicLanguageToSharedPreferences();
                      logger.w('language set from Arabic to English');
                    }
                  },
                  icon: const Icon(
                    Icons.language,
                    color: Colors.white,
                    size: 27,
                  ),
                ),
              ),
              Text(
                'language'.tr(),
                textAlign: TextAlign.center,
                style: GoogleFonts.vazirmatn(
                  color: Colors.white,
                  textStyle: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
