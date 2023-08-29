import 'dart:convert';
// import 'package:fingerprint/Functions.dart';
//import 'package:fingerprint/presentation_layer/screens/my_requests.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
// import 'package:fingerprint/business_logic_layer/cubit/fingerprint_cubit.dart';
// import 'package:fingerprint/constants/my_colors.dart';
// import 'package:fingerprint/data_layer/models/holidays_look_up_model.dart';
// import 'package:fingerprint/data_layer/repository/fingerprint_repository.dart';
// import 'package:fingerprint/data_layer/web_services/fingerprint_web_service.dart';
// import 'package:fingerprint/translations/locale_keys.g.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import "package:hexcolor/hexcolor.dart";
import 'package:intl/intl.dart' as intl;
class AddRequest extends StatefulWidget {
  const AddRequest({Key? key}) : super(key: key);

  @override
  State<AddRequest> createState() => _AddRequestState();
}

class _AddRequestState extends State<AddRequest> {

  // late HolidaysLookUpModel holidaysLookUpModel ;
  // late FingerprintRepository fingerprintRepository;
  // late FingerprintCubit fingerprintCubit;


  TextEditingController? reasonVacationController = TextEditingController();
  TextEditingController? startDateController = TextEditingController();
  TextEditingController? endDateController = TextEditingController();
  var startDate ="DD/MM/YYYY";
  var endDate ="DD/MM/YYYY";

  bool dropDownCheck = false;
  var dropDownValue = "";


  bool activeTextField=true;

  String selectedValue = "" ;

  List<String>? holidays=[];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // fingerprintRepository = FingerprintRepository(FingerprintWebServices());
    // fingerprintCubit = FingerprintCubit(fingerprintRepository);
    // BlocProvider.of<FingerprintCubit>(context).getHolidaysLookUp();
    selectedValue="noResult";
  }


  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'اضافة طلب',
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
      body:Container(
        height: h,
        width: w,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     Text('اضافة طلب'.tr(),
                    //       style: const TextStyle(
                    //           fontSize: 25
                    //       ),
                    //     ),
                    //
                    //     IconButton(
                    //       color: Colors.purple,
                    //       onPressed: () {
                    //         Navigator.pop(context);
                    //       },
                    //       icon: const Icon(
                    //         Icons.arrow_forward,
                    //         size: 40,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('نوع الاجازة'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    Container(
                      width: double.infinity,
                      height: 66,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Color('#CDD4D9'.hashCode),),
                          borderRadius: BorderRadius.circular(11)
                      ),
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: const Text(""),
                            dropdownColor: Colors.white,
                            items: holidays!.map((String value) {
                              if(dropDownValue == ""){
                                dropDownValue =value;
                                print("****************");
                                print(dropDownValue);
                              }
                              print(holidays);
                              print(value);
                              return DropdownMenuItem<String>(
                                value: value,
                                //child:  Text(dropDownCheck? dropDownValue : LocaleKeys.choose_the_type_of_vacation_from_here.tr() ),
                                child:  Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                dropDownCheck=true;
                                dropDownValue = value!;
                              });
                            },
                            value: dropDownCheck==true? dropDownValue : context.locale == Locale('ar') ?"Marriage Leave":"اجازة زواج" ,
                            //value: "22",
                          )
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('مدة الاجازة'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(

                            onTap: () async {
                              //when click we have to show the date picker
                              DateTime? pickedDate = await showDatePicker(
                                context: context,

                                initialDate: DateTime.now(),
                                //get today's date
                                firstDate: DateTime.now(),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100),


                              );
                              pickedDate;
                              if (pickedDate != null) {
                                //print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                                String formattedDate = intl
                                    .DateFormat('yyyy-MM-dd' ,"en").format(
                                    pickedDate);
                                // format date in required form here we use yyyy-MM-dd that means time is removed
                                //print(formattedDate); //formatted date output using intl package =>  2022-07-04
                                //You can format date as per your need
                                setState(() {
                                  print("333333333");
                                  print(formattedDate);
                                  startDateController!.text =
                                      formattedDate.toString();
                                  startDate = formattedDate.toString();
                                  print(startDateController!.text);
                                  //set formatted date to TextField value.
                                });
                              }
                              else {
                                print("Date is not selected");
                              }
                            },
                            child: Container(
                              height: 66,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                  border: Border.all(
                                    color: Colors.purple,
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: Colors.pink,
                                            borderRadius: BorderRadius.circular(
                                                11),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text('from'.tr(),
                                          style: TextStyle(
                                              color:
                                              Color('#8A8A8A'.hashCode),
                                              //HexColor("#8A8A8A"),
                                              fontSize: 12
                                          ),
                                        )
                                      ],

                                    ),
                                    Text(startDate.toString(),
                                      style: const TextStyle(
                                          fontSize: 12
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: GestureDetector(

                            onTap: () async {
                              //when click we have to show the date picker
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                //get today's date
                                firstDate: DateTime.now(),
                                //DateTime.now() - not to allow to choose before today.
                                lastDate: DateTime(2100),

                              );
                              pickedDate;
                              if (pickedDate != null) {
                                //print(pickedDate);  //get the picked date in the format => 2022-07-04 00:00:00.000
                                String formattedDate = intl.DateFormat('yyyy-MM-dd',"en").format(pickedDate);
                                setState(() {
                                  endDateController!.text = formattedDate.toString();
                                  endDate = formattedDate.toString();
                                });
                              }
                              else {
                                print("Date is not selected");
                              }
                            },
                            child: Container(
                              height: 66,

                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                  border: Border.all(
                                    color: Colors.purple,
                                  )
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 8,
                                          height: 8,
                                          decoration: BoxDecoration(
                                            color: Colors.pink,
                                            borderRadius: BorderRadius.circular(
                                                11),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text('too'.tr(),
                                          style: TextStyle(
                                              color:
                                              Color('#8A8A8A'.hashCode),
                                              fontSize: 12
                                          ),
                                        )
                                      ],

                                    ),
                                    Text(endDate.toString(),
                                      style: const TextStyle(
                                          fontSize: 12
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text('سبب الاجازة'.tr(),
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),

                    TextField(
                      maxLines: 6,
                      keyboardType: TextInputType.multiline,
                      controller: reasonVacationController,
                      enabled: activeTextField,
                      onTap: () {

                      },
                      onChanged: (value) {
                      },
                      decoration: InputDecoration(
                        isDense: true,
                        hintText:
                        'ادخل سبب الاجازة'.tr(),

                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: BorderSide(
                            color: Color('#CDD4D9'.hashCode),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 30,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 66,
                      child: ElevatedButton(
                        onPressed: () {

                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                        child: Text('ارسال الطلب'.tr(),),
                      ),
                    )


                  ],
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }



  Widget showLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
          color: Colors.blue
      ),
    );
  }
}
