import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/main_provider.dart';
import '../widgets/one_of_options.dart';

class OptionsScreen extends StatefulWidget {
  final String name;
  final int id;

  OptionsScreen(this.name, this.id, {super.key});

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  String? _currentAddress;

  Position? _currentPosition;
  @override
  Widget build(BuildContext context) {
    // define used provider
    final proMain = Provider.of<MainProvider>(context);

    // define height and width
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

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
        decoration: const BoxDecoration(
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
                              () async{
                            _getCurrentPosition();
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO,
                              btnOkText: 'تأكيد',
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
                              btnOkOnPress: () async{
                                // await proMain.setEmployeeOperation('LOGIN', widget.id, 1);
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
                              btnOkText: 'تأكيد',
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
                                // proMain.setEmployeeOperation('LOGOUT', widget.id, 2);
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
                              btnOkText: 'تأكيد',
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
                                // proMain.setEmployeeOperation('BREAKIN', widget.id, 3);
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
                              btnOkText: 'تأكيد',
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
                                // proMain.setEmployeeOperation('BREAKOUT', widget.id, 4);
                              },
                            ).show();
                            proMain.setMessage(context.locale == Locale('ar'));
                          },
                        ),
                        OneOption(
                          Icons.send_outlined,
                          'بدء مهمة عمل',
                              () async{
                            _getCurrentPosition();
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO,
                              btnOkText: 'تأكيد',
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
                              btnOkOnPress: () async{
                                // await proMain.setEmployeeOperation('LOGIN', widget.id, 1);
                                // await proMain.setMessage(context.locale == Locale('ar'));
                              },
                            ).show();
                          },
                        ),
                        OneOption(
                          Icons.cancel_schedule_send_outlined,
                          'إنهاء مهمة عمل',
                              () async{
                            _getCurrentPosition();
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO,
                              btnOkText: 'تأكيد',
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
                              btnOkOnPress: () async{
                                // await proMain.setEmployeeOperation('LOGIN', widget.id, 1);
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
            SizedBox(height: h/40),
            Expanded(
              child: Container(
                width: w,
                decoration: BoxDecoration(
                  color: Colors.white70.withOpacity(0.3),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(h / 10),
                    topRight: Radius.circular(h / 10),
                  ),
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
                            '${'hello'.tr()} ${widget.name}',
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
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
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
        '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      });
    }).catchError((e) {
      debugPrint(e);
    });
  }
}
