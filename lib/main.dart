import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/MainScreens/first_screen.dart';
import 'package:resto_app/MainScreens/main_screen.dart';
import 'package:resto_app/MainScreens/options_screen.dart';
import 'MainScreens/login_screen.dart';
import 'providers/main_provider.dart';
import 'services/shared_preferences_helper.dart';

// main function
void main() async {
  // ensure initialized for widgets, localization, firebase, shared preferences and camera
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SharedPreferencesHelper.initialize();

  runApp(
    // run app with multi providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MainProvider()),
      ],

      // set EasyLocalization widget
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('ar')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en'),
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // set language to arabic at the start of app, and set username to shared preferences to handle session
    SharedPreferencesHelper.preferences.setString('lang', 'ar');
    String? username =
        SharedPreferencesHelper.preferences.getString('username');

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF00b1eb),
        ),
      ),

      // options for localization
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      // remove debug banner
      debugShowCheckedModeBanner: false,

      // set first page due to the state of login and logout :
      // if user is already logged in, the first page will be resto list screen
      // if user is not logged in or if he logged out, the first screen will be login screen
      home: username == null ? LoginScreen() :  MainScreen(),
    );
  }
}