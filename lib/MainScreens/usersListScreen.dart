import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../providers/main_provider.dart';
import '../widgets/one_user.dart';

class UsersListScreen extends StatefulWidget {
  const UsersListScreen({super.key});

  @override
  State<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  late MainProvider proMain;

  @override
  void initState() {
    super.initState();
    // proMain = Provider.of<MainProvider>(context, listen: false);
    // proMain.setIsLoadingUsersListTrue();
    // proMain.setEmployeeListFromAPI();
  }

  @override
  Widget build(BuildContext context) {
    final proMain = Provider.of<MainProvider>(context);
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'empList'.tr(),
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
        padding: const EdgeInsets.only(top: 20),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: proMain.isLoadingUsersList
            ? const CircularProgressIndicator()
            : proMain.employeesList.isEmpty && false
                ? Center(
                    child: Text(
                      'thereIsNoEmployees'.tr(),
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
                  )
                : SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          OneUser("Muath", "", 5),
                          OneUser("Ali", "", 6),
                          OneUser("Mike", "", 7),
                          OneUser("Imad", "", 8),
                        ]),
                  ),
      ),
    );
  }
}
