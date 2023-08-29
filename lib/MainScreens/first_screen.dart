import 'dart:async';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter_svg/flutter_svg.dart";
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:local_auth/local_auth.dart";
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import '../fingerprint/fingerprint_scan_compare.dart';
import '../providers/main_provider.dart';
import '../request/requests.dart';
import '../services/shared_preferences_helper.dart';
import '../widgets/one_of_options.dart';
import 'login_screen.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key, required this.checkInOrOut}) : super(key: key);
  final checkInOrOut;

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int authCheck = 0;
  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  var finger;

  String? _currentAddress;

  Position? _currentPosition;

  @override
  void initState() {
    super.initState();
    _authenticate();
    initPlatformState();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var w = size.width;
    var h = size.height;

    final proMain = Provider.of<MainProvider>(context);

    var logger = Logger();

    if (_supportState == _SupportState.supported && authCheck == 0) {
      _authenticate();
      authCheck = 1;
    } else if (_supportState == _SupportState.supported && authCheck == 1) {
      if (_authorized == "Authorized") {
        setState(() {
          authCheck++;
        });
      } else if (_authorized == "Not Authorized") {
        authCheck++;
      }
    }

    print("iiiiiiii");
    print(_deviceData['id']);
    print("**************");

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'regOptions'.tr(),
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
      body: Container(
        height: h,
        width: w,
        padding: EdgeInsets.only(top: h / 30),
        decoration: BoxDecoration(
          // color: Colors.blue.shade100,
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: h * 0.65,
              width: w,
              child: CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(20),
                    sliver: SliverGrid.count(
                      crossAxisSpacing: 15,
                      mainAxisSpacing: 15,
                      crossAxisCount: 2,
                      childAspectRatio: 1.35,
                      children: <Widget>[
                        OneOption(
                          Icons.login,
                          'login'.tr(),
                          () async {
                             _getCurrentPosition();
                             print('helo');
                             AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO,
                              btnOkText: 'ok'.tr(),
                              body: Center(
                                child: Text(
                                  '${'doYouWantLogin'.tr()} \n ${context.locale == Locale('ar') ? DateFormat('dd/MM/yyyy - EEEE - HH:mm').format(DateTime.now()) : DateFormat('yyyy/MM/dd - EEEE - HH:mm', 'ar').format(DateTime.now())}',

                                  // '${'doYouWantLogin'.tr()} \n ${context.locale == Locale('ar') ? DateFormat('dd/MM/yyyy - EEEE - HH:mm').format(DateTime.now()) : DateFormat('yyyy/MM/dd - EEEE - HH:mm', 'ar').format(DateTime.now())}\nadrees : ${_currentAddress}\n ${_currentPosition!.latitude}   ${_currentPosition!.longitude}',
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
                              btnOkOnPress: () async {
                                print('hellllllllllllo');
                                // _getAddressFromLatLng(_currentPosition!);
                                // print(_currentAddress);
                                // await proMain.setEmployeeOperation(
                                //     'LOGIN', 5555, 1);
                                // await proMain.setMessage(context.locale == Locale('ar'));
                              },
                            ).show();
                          },
                        ),
                        OneOption(
                          Icons.logout,
                          'logOut'.tr(),
                          () {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO,
                              btnOkText: 'ok'.tr(),
                              body: Center(
                                child: Text(
                                  '${'doYouWantLogOut'.tr()} \n ${context.locale == Locale('ar') ? DateFormat('dd/MM/yyyy - EEEE - HH:mm').format(DateTime.now()) : DateFormat('yyyy/MM/dd - EEEE - HH:mm', 'ar').format(DateTime.now())}',
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
                              btnOkOnPress: () {
                                proMain.setEmployeeOperation('LOGOUT', 6666, 2);
                              },
                            ).show();
                            proMain.setMessage(context.locale == Locale('ar'));
                          },
                        ),
                        OneOption(
                          Icons.check,
                          'breakIn'.tr(),
                          () {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO,
                              btnOkText: 'ok'.tr(),
                              body: Center(
                                child: Text(
                                  '${'doYouWantBreakIn'.tr()} \n ${context.locale == Locale('ar') ? DateFormat('dd/MM/yyyy - EEEE - HH:mm').format(DateTime.now()) : DateFormat('yyyy/MM/dd - EEEE - HH:mm', 'ar').format(DateTime.now())}',
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
                              btnOkOnPress: () {
                                proMain.setEmployeeOperation(
                                    'BREAKIN', 7777, 3);
                              },
                            ).show();
                            proMain.setMessage(context.locale == Locale('ar'));
                          },
                        ),
                        OneOption(
                          Icons.cancel_outlined,
                          'breakOut'.tr(),
                          () {
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              btnOkText: 'ok'.tr(),
                              dialogType: DialogType.INFO,
                              body: Center(
                                child: Text(
                                  '${'doYouWantBreakOut'.tr()} \n ${context.locale == Locale('ar') ? DateFormat('dd/MM/yyyy - EEEE - HH:mm').format(DateTime.now()) : DateFormat('yyyy/MM/dd - EEEE - HH:mm', 'ar').format(DateTime.now())}',
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
                              btnOkOnPress: () {
                                proMain.setEmployeeOperation(
                                    'BREAKOUT', 8888, 4);
                              },
                            ).show();
                            proMain.setMessage(context.locale == Locale('ar'));
                          },
                        ),
                        OneOption(
                          Icons.send_outlined,
                          'startTask'.tr(),
                          () async {
                            _getCurrentPosition();
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO,
                              btnOkText: 'ok'.tr(),
                              body: Center(
                                child: Text(
                                  '${'doYouWantLogin'.tr()} \n ${context.locale == Locale('ar') ? DateFormat('dd/MM/yyyy - EEEE - HH:mm').format(DateTime.now()) : DateFormat('yyyy/MM/dd - EEEE - HH:mm', 'ar').format(DateTime.now())} \n LAT: ${_currentPosition!.latitude.toString() ?? ""},\n LNG: ${_currentPosition!.longitude.toString() ?? ""},\n ADDRESS: ${_currentAddress ?? ""}',
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
                              btnOkOnPress: () async {
                                await proMain.setEmployeeOperation(
                                    'LOGIN', 9999, 1);
                                // await proMain.setMessage(context.locale == Locale('ar'));
                              },
                            ).show();
                          },
                        ),
                        OneOption(
                          Icons.cancel_schedule_send_outlined,
                          'endTask'.tr(),
                          () async {
                            // _getCurrentPosition();
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO,
                              btnOkText: 'ok'.tr(),
                              body: Center(
                                child: Text(
                                  '${'doYouWantLogin'.tr()} \n ${context.locale == Locale('ar') ? DateFormat('dd/MM/yyyy - EEEE - HH:mm').format(DateTime.now()) : DateFormat('yyyy/MM/dd - EEEE - HH:mm', 'ar').format(DateTime.now())} ',
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
                              btnOkOnPress: () async {
                                await proMain.setEmployeeOperation(
                                    'LOGIN', 4444, 1);
                                // await proMain.setMessage(context.locale == Locale('ar'));
                              },
                            ).show();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: h / 40),
            Expanded(
              child: Container(
                width: w,
                decoration: BoxDecoration(
                  color: Colors.white70.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(h / 10),
                    topRight: Radius.circular(h / 10),
                  ),
                  // border: Border.all(
                  //   color: const Color(0xFF00b1eb), // Set the border color here.
                  //   width: 2, // Set the border width (optional).
                  // ),
                ),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: w * 0.6,
                      height: h * 0.055,
                      decoration: const BoxDecoration(
                        color: Color(0xFF00b1eb),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            '${'hello'.tr()} ${"testName"}',
                            textAlign: TextAlign.center,
                            style: GoogleFonts.vazirmatn(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Container(
                          width: w * 0.85,
                          child: Text(
                            proMain.msg,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.vazirmatn(
                              color: Colors.black.withOpacity(0.9),
                              textStyle: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                              ),
                              decoration: TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: h / 40),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location services are disabled. Please enable the services')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low)
        .then((Position position) {
      setState(() => _currentPosition = position);
      _getAddressFromLatLng(_currentPosition!);
    }).catchError((e) {
      debugPrint(e);
    });
  }

  Future<void> _getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            _currentPosition!.latitude, _currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
            ' country : ${place.country}';
      });
    }).catchError((e) {
      debugPrint(e.toString());
    });
  }

  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = "Authenticating";
  bool _isAuthenticating = false;

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = "Authenticating";
      });
      authenticated = await auth.authenticate(
        localizedReason: "Let OS determine authentication method",
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) {
      return;
    }

    setState(
        () => _authorized = authenticated ? "Authorized" : "Not Authorized");
  }

  //device ID

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {
      if (kIsWeb) {
        deviceData = _readWebBrowserInfo(await deviceInfoPlugin.webBrowserInfo);
      } else {
        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
        } else if (Platform.isIOS) {
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
        } else if (Platform.isLinux) {
          deviceData = _readLinuxDeviceInfo(await deviceInfoPlugin.linuxInfo);
        } else if (Platform.isMacOS) {
          deviceData = _readMacOsDeviceInfo(await deviceInfoPlugin.macOsInfo);
        } else if (Platform.isWindows) {
          deviceData =
              _readWindowsDeviceInfo(await deviceInfoPlugin.windowsInfo);
        }
      }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }

    if (!mounted) return;

    setState(() {
      _deviceData = deviceData;
    });
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release,
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board,
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id,
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'systemFeatures': build.systemFeatures,
      'displaySizeInches':
          ((build.displayMetrics.sizeInches * 10).roundToDouble() / 10),
      'displayWidthPixels': build.displayMetrics.widthPx,
      'displayWidthInches': build.displayMetrics.widthInches,
      'displayHeightPixels': build.displayMetrics.heightPx,
      'displayHeightInches': build.displayMetrics.heightInches,
      'displayXDpi': build.displayMetrics.xDpi,
      'displayYDpi': build.displayMetrics.yDpi,
      'serialNumber': build.serialNumber,
    };
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName,
      'systemVersion': data.systemVersion,
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }

  Map<String, dynamic> _readLinuxDeviceInfo(LinuxDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'version': data.version,
      'id': data.id,
      'idLike': data.idLike,
      'versionCodename': data.versionCodename,
      'versionId': data.versionId,
      'prettyName': data.prettyName,
      'buildId': data.buildId,
      'variant': data.variant,
      'variantId': data.variantId,
      'machineId': data.machineId,
    };
  }

  Map<String, dynamic> _readWebBrowserInfo(WebBrowserInfo data) {
    return <String, dynamic>{
      'browserName': describeEnum(data.browserName),
      'appCodeName': data.appCodeName,
      'appName': data.appName,
      'appVersion': data.appVersion,
      'deviceMemory': data.deviceMemory,
      'language': data.language,
      'languages': data.languages,
      'platform': data.platform,
      'product': data.product,
      'productSub': data.productSub,
      'userAgent': data.userAgent,
      'vendor': data.vendor,
      'vendorSub': data.vendorSub,
      'hardwareConcurrency': data.hardwareConcurrency,
      'maxTouchPoints': data.maxTouchPoints,
    };
  }

  Map<String, dynamic> _readMacOsDeviceInfo(MacOsDeviceInfo data) {
    return <String, dynamic>{
      'computerName': data.computerName,
      'hostName': data.hostName,
      'arch': data.arch,
      'model': data.model,
      'kernelVersion': data.kernelVersion,
      'majorVersion': data.majorVersion,
      'minorVersion': data.minorVersion,
      'patchVersion': data.patchVersion,
      'osRelease': data.osRelease,
      'activeCPUs': data.activeCPUs,
      'memorySize': data.memorySize,
      'cpuFrequency': data.cpuFrequency,
      'systemGUID': data.systemGUID,
    };
  }

  Map<String, dynamic> _readWindowsDeviceInfo(WindowsDeviceInfo data) {
    return <String, dynamic>{
      'numberOfCores': data.numberOfCores,
      'computerName': data.computerName,
      'systemMemoryInMegabytes': data.systemMemoryInMegabytes,
      'userName': data.userName,
      'majorVersion': data.majorVersion,
      'minorVersion': data.minorVersion,
      'buildNumber': data.buildNumber,
      'platformId': data.platformId,
      'csdVersion': data.csdVersion,
      'servicePackMajor': data.servicePackMajor,
      'servicePackMinor': data.servicePackMinor,
      'suitMask': data.suitMask,
      'productType': data.productType,
      'reserved': data.reserved,
      'buildLab': data.buildLab,
      'buildLabEx': data.buildLabEx,
      'digitalProductId': data.digitalProductId,
      'displayVersion': data.displayVersion,
      'editionId': data.editionId,
      'installDate': data.installDate,
      'productId': data.productId,
      'productName': data.productName,
      'registeredOwner': data.registeredOwner,
      'releaseId': data.releaseId,
      'deviceId': data.deviceId,
    };
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
