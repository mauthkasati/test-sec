import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../face_relations/take_picture.dart';
import '../providers/main_provider.dart';

class OneUser extends StatelessWidget {
  final String name;
  final String? faceData;
  final int id;

  const OneUser(this.name, this.faceData,this.id, {super.key});

  @override
  Widget build(BuildContext context) {
    final proMain = Provider.of<MainProvider>(context);
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        AwesomeDialog(
                context: context,
                animType: AnimType.SCALE,
                dialogType: DialogType.QUESTION,
                btnOkText: 'ok'.tr(),
                btnCancelText: 'cancel'.tr(),
                body: Center(
                  child: Text(
                    '${'doYouWantToUpdateFaceID'.tr()} $name',
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
                  final cameras = await availableCameras();
                  final firstCamera = cameras.firstWhere(
                        (camera) => camera.lensDirection == CameraLensDirection.front,
                  );
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      // builder: (context) => FaceDetectorView(proMain.employeesList),
                      builder: (context) => TakePicture(camera: firstCamera),
                    ),
                  );
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     // builder: (context) => FaceDetectorView2(id,name),
                  //   ),
                  // );
                },
                btnCancelOnPress: () {
                })
            .show();
      },
      child: Container(
        margin: EdgeInsets.only(top: h / 500),
        height: h / 15,
        width: w * 0.85,
        padding: EdgeInsets.only(left: h * 3 / 100, right: h * 3 / 260),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.3),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                faceData != null ? Icons.check : Icons.cancel_outlined,
                color:
                    faceData != null ? Colors.green.shade500 : Colors.red.shade500,
                size: 30,
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    name,
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
                  SizedBox(width: w * 0.05),
                  Container(
                    height: h / 13,
                    width: h / 13,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.person),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
