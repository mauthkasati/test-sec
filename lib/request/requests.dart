import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:resto_app/MainScreens/main_screen.dart';

import 'add_request.dart';

class MyRequests extends StatefulWidget {
  const MyRequests({Key? key}) : super(key: key);

  @override
  State<MyRequests> createState() => _MyRequestsState();
}

class _MyRequestsState extends State<MyRequests> {
  // late MyVacationRequestsModel myVacationRequestsModel ;
  // late FingerprintRepository fingerprintRepository;
  // late FingerprintCubit fingerprintCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fingerprintRepository = FingerprintRepository(FingerprintWebServices());
    // fingerprintCubit = FingerprintCubit(fingerprintRepository);
    // BlocProvider.of<FingerprintCubit>(context).getMyVacationRequests();
  }

  @override
  Widget build(BuildContext context) {
    change();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'الطلبات',
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(40.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 60,
                    ),

                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
              GestureDetector(
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.grey.withOpacity(0.3),
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, color: Colors.black),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'اضافة طلب'.tr(),
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AddRequest()));
                  // Navigator.push(context, MaterialPageRoute(builder: (context) =>
                  //     // BlocProvider(
                  //     //   create: (BuildContext context) => fingerprintCubit,
                  //     //   child: const AddRequest(),
                  //     // ),
                  //   settings: const RouteSettings(name: '/attendance'),
                  //));
                },
              ),

              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    ' كل الطلبات'.tr(),
                    style: const TextStyle(fontSize: 25),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.shade200.withOpacity(0.3)
                    ),
                    child: IconButton(
                      color: Colors.purple,
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => MainScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.arrow_forward,
                        size: 30,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'اجازة زواج',
                                  //'myVacationRequestsModel.data![index].type.toString()',
                                  style: const TextStyle(fontSize: 14),
                                ),
                                Row(
                                  children: [
                                    Text('حالة الطلب'.tr(),
                                        style: const TextStyle(fontSize: 12)),
                                    //  (myVacationRequestsModel.data![index].statusValue == 1) ?
                                    true
                                        ? Text(
                                            'مقبول',
                                            //'myVacationRequestsModel.data![index].status.toString()',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.green,
                                            ),
                                          )
                                        :
                                        // (myVacationRequestsModel.data![index].statusValue == 0) ?
                                        true
                                            ? Text(
                                                'myVacationRequestsModel.data![index].status.toString()',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                ),
                                              )
                                            : Text(
                                                'myVacationRequestsModel.data![index].status.toString()',
                                                style: const TextStyle(
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.orange,
                                                ),
                                              )
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  "${'سبب الاجازة'.tr()}:  ",
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Expanded(
                                    child: Text('اكيد هجوز'
                                        // 'myVacationRequestsModel.data![index].cause.toString()'
                                        )),
                                Container(
                                  color: Color(0xff18AA4F),
                                  width: 70,
                                  height: 35,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Text("${myVacationRequestsModel.data![index].days} " ,
                                      Text(
                                        "6",
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),

                                      Text(
                                        ' يوم اجازة'.tr(),
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'من'.tr(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '14-7-2023',
                                      //'myVacationRequestsModel.data![index].start.toString()',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'الي'.tr(),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '14-7-2023',
                                      //'myVacationRequestsModel.data![index].end.toString()',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Row(
                              children: [
                                Text(
                                  'تم ارسال الطلب يوم'.tr(),
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  '17-7-2023',
                                  //DateFormat('yyyy-MM-dd' ,"en").format(DateTime.parse('myVacationRequestsModel.data![index].createdAt.toString())'),
                                  style: const TextStyle(fontSize: 12),
                                ),
                                /*IconButton(
                                  onPressed: () {},
                                  icon: Icon(
                                    Icons.edit,
                                    color: HexColor("#8F64E9"),
                                    size: 14,
                                  )),*/
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: 5 // myVacationRequestsModel.data!.length
                  ),
            ],
          ),
        ),
      ),
      // BlocBuilder<FingerprintCubit, FingerprintState>(
      //   builder: (context,state) {
      // if(state is MyVacationRequestLoaded) {
      //   myVacationRequestsModel = (state).myVacationRequestsModel;
      //   return SingleChildScrollView(
      //     child: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Padding(
      //           padding: const EdgeInsets.all(40.0),
      //           child: Column(
      //             crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               const SizedBox(
      //                 height: 60,
      //               ),
      //               Row(
      //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                 children: [
      //                   Text(LocaleKeys.requests.tr(),
      //                     style: const TextStyle(
      //                         fontSize: 25
      //                     ),
      //                   ),
      //
      //                   IconButton(
      //                     color: Colors.red,
      //                     onPressed: () {
      //                     Navigator.pop(context);
      //                   }, icon: const Icon(
      //                     Icons.arrow_forward,
      //                     size: 30,
      //                   ),
      //                   ),
      //                 ],
      //               ),
      //               const SizedBox(
      //                 height: 20,
      //               ),
      //
      //
      //             ],
      //           ),
      //         ),
      //         GestureDetector(
      //           child: Row(
      //             children: [
      //               Expanded(
      //                 child: Container(
      //                   color: HexColor("#F9F1FF"),
      //                   height: 60,
      //                   child: Row(
      //                     mainAxisAlignment: MainAxisAlignment.center,
      //                     children: [
      //                       Icon(Icons.add,
      //                           color: HexColor("#18AA4F")
      //                       ),
      //                       const SizedBox(
      //                         width: 10,
      //                       ),
      //                       Text(LocaleKeys.add_request.tr(),
      //                         style: TextStyle(
      //                             fontSize: 16,
      //                             color: HexColor("#18AA4F")
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //
      //                 ),
      //               ),
      //
      //
      //             ],
      //           ),
      //           onTap: () {
      //             Navigator.push(context, MaterialPageRoute(builder: (context) =>
      //                 BlocProvider(
      //                   create: (BuildContext context) => fingerprintCubit,
      //                   child: const AddRequest(),
      //                 ),
      //               settings: const RouteSettings(name: '/attendance'),
      //             ));
      //           },
      //         ),
      //         const SizedBox(
      //           height: 20,
      //         ),
      //         ListView.separated(
      //           shrinkWrap: true,
      //             physics: const NeverScrollableScrollPhysics(),
      //             itemBuilder:(BuildContext context, int index) => Padding(
      //               padding: const EdgeInsets.symmetric(
      //                   horizontal: 40.0),
      //               child: Column(
      //                 crossAxisAlignment: CrossAxisAlignment.start,
      //                 children: [
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                     children: [
      //                       Text(myVacationRequestsModel.data![index].type.toString(),
      //                         style: const TextStyle(
      //                             fontSize: 14
      //                         ),
      //                       ),
      //                       Row(
      //                         children: [
      //                       Text(LocaleKeys.request_status.tr(),
      //                             style:  const TextStyle(
      //                                 fontSize: 12
      //                             )
      //                           ),
      //                           (myVacationRequestsModel.data![index].statusValue == 1) ?
      //                           Text(myVacationRequestsModel.data![index].status.toString(),
      //                             style: const TextStyle(
      //                               fontSize: 12,
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.green,
      //                             ),
      //                           ):
      //                           (myVacationRequestsModel.data![index].statusValue == 0) ?
      //                           Text(myVacationRequestsModel.data![index].status.toString(),
      //                             style: const TextStyle(
      //                               fontSize: 12,
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.red,
      //                             ),
      //                           ):
      //                           Text(myVacationRequestsModel.data![index].status.toString(),
      //                             style: const TextStyle(
      //                               fontSize: 12,
      //                               fontWeight: FontWeight.bold,
      //                               color: Colors.orange,
      //                             ),
      //                           )
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                   const SizedBox(
      //                     height: 5,
      //                   ),
      //                   Row(
      //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                     children: [
      //                       Text("${LocaleKeys.reason_for_vacation.tr()}:  ",
      //                         style: const TextStyle(
      //                             fontSize: 12
      //                         ),
      //                       ),
      //                       Expanded(child: Text(
      //                           myVacationRequestsModel.data![index].cause.toString())),
      //                       Container(
      //                         color: HexColor("#18AA4F"),
      //                         width: 70,
      //                         height: 35,
      //                         child: Row(
      //                           mainAxisAlignment: MainAxisAlignment.center,
      //                           children: [
      //                             Text("${myVacationRequestsModel.data![index].days} " ,
      //                               style: const TextStyle(
      //                                   color: Colors.white,
      //                                   fontWeight: FontWeight.bold,
      //                                   fontSize: 14
      //                               ),
      //                             ),
      //
      //                             Text(LocaleKeys.day_off.tr(),
      //                               style: const TextStyle(
      //                                   color: Colors.white,
      //                                   fontWeight: FontWeight.bold,
      //                                   fontSize: 14
      //                               ),
      //                             ),
      //                           ],
      //                         ),
      //                       ),
      //
      //                     ],
      //                   ),
      //                   const SizedBox(
      //                     height: 5,
      //                   ),
      //                   Row(
      //
      //                     children: [
      //                       Row(
      //                         children: [
      //                           Text(LocaleKeys.from.tr(),
      //                             style: const TextStyle(
      //                                 fontSize: 12
      //                             ),
      //                           ),
      //                           const SizedBox(
      //                             width: 5,
      //                           ),
      //                           Text(myVacationRequestsModel.data![index].start.toString(),
      //                             style: const TextStyle(
      //                                 fontSize: 12
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                       const SizedBox(
      //                         width: 10,
      //                       ),
      //                       Row(
      //                         children: [
      //                           Text(LocaleKeys.to.tr(),
      //                             style: const TextStyle(
      //                                 fontSize: 12
      //                             ),
      //                           ),
      //                           const SizedBox(
      //                             width: 5,
      //                           ),
      //                           Text(myVacationRequestsModel.data![index].end.toString(),
      //                             style: const TextStyle(
      //                                 fontSize: 12
      //                             ),
      //                           ),
      //                         ],
      //                       ),
      //                     ],
      //                   ),
      //                   const SizedBox(
      //                     height: 5,
      //                   ),
      //                   Row(
      //
      //                     children: [
      //                       Text(LocaleKeys.the_request_was_sent_day.tr(),
      //                         style: const TextStyle(
      //                             fontSize: 12
      //                         ),
      //                       ),
      //                      const SizedBox(
      //                        width: 10,
      //                      ),
      //                       Text(DateFormat('yyyy-MM-dd' ,"en").format(DateTime.parse(myVacationRequestsModel.data![index].createdAt.toString())),
      //                         style: const TextStyle(
      //                             fontSize: 12
      //                         ),
      //                       ),
      //                       /*IconButton(
      //                           onPressed: () {},
      //                           icon: Icon(
      //                             Icons.edit,
      //                             color: HexColor("#8F64E9"),
      //                             size: 14,
      //                           )),*/
      //                     ],
      //                   ),
      //                   const SizedBox(
      //                     height: 10,
      //                   )
      //                 ],
      //               ),
      //             ),
      //             separatorBuilder:(BuildContext context, int index)=> const Divider(),
      //             itemCount: myVacationRequestsModel.data!.length),
      //
      //       ],
      //     ),
      //   );
      // }
      // else{
      //   return showLoadingIndicator();
      // }
      //   }
      // ),
    );
  }

  // Widget showLoadingIndicator() {
  //   return const Center(
  //     child: CircularProgressIndicator(
  //       color: Colors.blue,
  //     ),
  //   );
  // }

  change() async {
    // await FlutterStatusbarcolor.setStatusBarColor(Colors.statusBarColor, animate: true);
  }
}
