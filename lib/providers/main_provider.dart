import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../constants/used_APIs.dart';
import '../services/shared_preferences_helper.dart';

class MainProvider extends ChangeNotifier {
  Map<String, dynamic> apiMap = {};
  List restoList = [];
  List employeesList = [];
  String msg = '';
  int msgID = 0;

  // bool apiCalled = false;
  bool isLoadingUsersList = false;
  bool isLoadingRestoList = false;

  // setEmployeeOperation(String op, int id, int msgID) async {
  //   var headers = {
  //     'token': SharedPreferencesHelper.preferences.getString('token2')!,
  //     'Content-Type': 'application/json'
  //   };
  //   var request = http.Request('POST',  Uri.parse(UsedAPIs.getAddEmployeeOperationAPIURL()));
  //   request.body = json.encode({
  //     "operation": op,
  //     "employeeId": id
  //   });
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print('fffffffffffffffffffffffffffffffffffffffffffffffffff');
  //     print(await response.stream.bytesToString());
  //     await setMsgID(msgID);
  //     setMessage(true);
  //   } else {
  //     print('ttttttttttttttttttttttttttttttttttttttttttttttttttt');
  //     print(response.reasonPhrase);
  //   }
  // }

  // setEmployeeListFromAPI() async {
  //   var headers = {
  //     'token': SharedPreferencesHelper.preferences.getString('token2')!,
  //   };
  //   var request =
  //       http.Request('GET', Uri.parse(UsedAPIs.getGetAllEmployeesAPIURL()));
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print('ddddddddddddddddddddddddddddddddddddddddddddd');
  //     employeesList = jsonDecode(await response.stream.bytesToString());
  //     print(employeesList);
  //     isLoadingUsersList = false;
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  //   notifyListeners();
  // }

  // seKeyForEmplooyeesAPI(String token, int id) async {
  //   var headers = {
  //     'token': token,
  //   };
  //   var request = http.Request('GET',
  //       Uri.parse('${UsedAPIs.getGetRestaurantKeyAPIURL()}=${id.toString()}'));
  //
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     print('cccccccccccccccccccccccccccccccccccccccccccccc');
  //     SharedPreferencesHelper.preferences.setString('token2',
  //         jsonDecode(await response.stream.bytesToString())['result']);
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  // }

  // setRestoListFromAPI(String token) async {
  //   var headers = {'token': token, 'Content-Type': 'application/json'};
  //   var request = http.Request(
  //     'POST',
  //     Uri.parse(UsedAPIs.getSearchRestaurantsAPIURL()),
  //   );
  //   request.body = json.encode({
  //     "filterExpression": "",
  //     "pageIndex": 1,
  //     "pageSize": 50,
  //     "sortExpressions": ["Id desc"]
  //   });
  //   request.headers.addAll(headers);
  //
  //   http.StreamedResponse response = await request.send();
  //
  //   if (response.statusCode == 200) {
  //     restoList = jsonDecode(await response.stream.bytesToString())['entities'];
  //     print('bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb');
  //     print(restoList);
  //     isLoadingRestoList = false;
  //   } else {
  //     print(response.reasonPhrase);
  //   }
  //   notifyListeners();
  // }

  // setIsLoadingUsersListTrue() {
  //   isLoadingUsersList = true;
  //   notifyListeners();
  // }
  //
  // setIsLoadingRestoListTrue() {
  //   isLoadingRestoList = true;
  //   notifyListeners();
  // }

  setArabicLanguageToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", "ar");
    print('arabic');
  }

  setEnglishLanguageToSharedPreferences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("lang", "en");
    print('English');
  }

  setMsgID(int n) {
    msgID = n;
    notifyListeners();
  }

  setMessage(bool isArabic) {
    if (msgID == 0) {
      msg = '';
    } else if (msgID == 1) {
      msg =
          '${'youLogin'.tr()} \n ${isArabic ? DateFormat('dd/MM/yyyy - EEEE - HH:mm').format(DateTime.now()) : DateFormat('yyyy/MM/dd - EEEE - HH:mm', 'ar').format(DateTime.now())}';
    } else if (msgID == 2) {
      msg =
          '${'youLogOut'.tr()} \n ${isArabic ? DateFormat('dd/MM/yyyy - EEEE - HH:mm').format(DateTime.now()) : DateFormat('yyyy/MM/dd - EEEE - HH:mm', 'ar').format(DateTime.now())}';
    } else if (msgID == 3) {
      msg =
          '${'youBreakIn'.tr()} \n ${isArabic ? DateFormat('dd/MM/yyyy - EEEE - HH:mm').format(DateTime.now()) : DateFormat('yyyy/MM/dd - EEEE - HH:mm', 'ar').format(DateTime.now())}';
    } else {
      msg =
          '${'youBreakOut'.tr()} \n ${isArabic ? DateFormat('dd/MM/yyyy - EEEE - HH:mm').format(DateTime.now()) : DateFormat('yyyy/MM/dd - EEEE - HH:mm', 'ar').format(DateTime.now())}';
    }
    notifyListeners();
  }
}
