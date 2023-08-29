import 'dart:async';
import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:camera/camera.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:resto_app/constants/used_APIs.dart';
import '../MainScreens/options_screen.dart';
import '../providers/main_provider.dart';

class TakePicture extends StatefulWidget {
  final CameraDescription camera;

  const TakePicture({super.key, required this.camera});

  @override
  State<TakePicture> createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isLoading = false;
  String? path;
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.max,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // define used provider
    final proMain = Provider.of<MainProvider>(context);

    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'faceDetector'.tr(),
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
      ),
      body: _isLoading
          ? Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                SizedBox(
                  height: w/6,
                ),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('...حاري التحميل' ,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        // height: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(200),
                            border: Border.all(
                                color: Color(0xFFE4E4E4),
                                width: 3
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            //height: 346,
                            //width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xFFF2F2F2),
                                borderRadius: BorderRadius.circular(200),
                                border: Border.all(
                                  color: Color(0xFFE4E4E4),

                                )
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(120.0),
                              child: Image.file(File(path!),height: 100,),

                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 80,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      )
          : Container(
        height: h,
        width: w,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(_controller);
                } else {
                  return const SpinKitRing(
                      color: Colors.white, size: 150);
                }
              },
            ),
            Positioned(
              bottom: 15,
              child: SizedBox(
                width: w,
                child: Center(
                  child: SizedBox(
                    width: w / 5,
                    height: h / 10,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: const CircleBorder(),
                      ),
                      onPressed: () async {
                        var logger = Logger();
                        try {
                          await _initializeControllerFuture;
                          final image = await _controller.takePicture();
                          path = image.path;
                          // final File capturedImageFile = File(image.path);
                          // final decodedImage = await decodeImageFromList(await capturedImageFile.readAsBytes());
                          //
                          // final int imageHeight = decodedImage.height;
                          // final int imageWidth = decodedImage.width;

                          logger.w('img path : ${image.path}');

                          if (!mounted) return;

                          // compress to png
                          final compressedBytes =
                          await FlutterImageCompress.compressWithFile(
                            image.path,
                            // minHeight: (imageHeight*0.75).toInt(),
                            // minWidth: (imageWidth*0.75).toInt(),
                            format: CompressFormat.png,
                          );
                          final pngImagePath = image.path.replaceAll(
                            '.jpg',
                            '.png',
                          );
                          final pngFile = File(pngImagePath);
                          await pngFile.writeAsBytes(compressedBytes!);

                          logger.w(
                            'Conversion from JPG to PNG successful!\nPNG image path: $pngImagePath',
                          );
                          String s = ('message').toString();

                          // request Face Recognition API
                          // it receives a parameter unknown with the png image path
                          var request = http.MultipartRequest(
                            'POST',
                            Uri.parse(
                              UsedAPIs.getRecognitionAPIURL(),
                            ),
                          );
                          request.files.add(
                            await http.MultipartFile.fromPath(
                              'unknown',
                              pngImagePath,
                            ),
                          );

                          // to show loading after clicking on camera button(after taking a picture)
                          Timer(const Duration(milliseconds: 200), () {
                            setState(() {
                              _isLoading = true;
                            });
                          });

                          // send request
                          http.StreamedResponse response =
                          await request.send();

                          // check response
                          // the response is 0 when there is no matching face
                          // the response is id of employee if there is matching face
                          if (response.statusCode == 200) {
                            String res =
                            await response.stream.bytesToString();

                            logger.w(
                                'employee list : ${proMain.employeesList}');

                            _isLoading = false;
                            if (res.trim() != '0') {
                              logger
                                  .w('recognition done\nresponse : $res');
                              // set employees list to get id and name
                              // proMain.setEmployeeListFromAPI();

                              int id = 1000;
                              String name = 'default';

                              String empInfo = '';
                              // find the name of user id
                              for (var element in proMain.employeesList) {
                                empInfo += '${element['id']}\n';
                                empInfo += '${element['name']}\n';
                                if (element['id'].toString().trim() ==
                                    res.trim()) {
                                  id = element['id'];
                                  name = element['name'];
                                }
                              }
                              logger.w(empInfo);

                              proMain.setMsgID(0);

                              // go to options Screen
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      OptionsScreen(name, id),
                                ),
                              );

                              return;
                            } else {
                              logger.w(
                                  'Face is not match\nresponse : $res');
                              _isLoading = false;
                              // ignore: use_build_context_synchronously
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.INFO,
                                btnOkText: 'ok'.tr(),
                                body: Center(
                                  child: Text(
                                    'wrongFace'.tr(),
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
                                btnOkOnPress: () {
                                  Navigator.of(context).pop();
                                },
                                title: 'This is Ignored',
                                desc: 'This is also Ignored',
                              ).show();
                            }
                          } else {
                            logger.w(
                                'error in recognition\n${response.reasonPhrase}');

                            _isLoading = false;
                            // ignore: use_build_context_synchronously
                            AwesomeDialog(
                              context: context,
                              animType: AnimType.SCALE,
                              dialogType: DialogType.INFO,
                              btnOkText: 'ok'.tr(),
                              body: Center(
                                child: Text(
                                  'serverError'.tr(),
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
                              btnOkOnPress: () {
                                Navigator.of(context).pop();
                              },
                              title: 'This is Ignored',
                              desc: 'This is also Ignored',
                            ).show();
                          }
                        } catch (e) {
                          logger.w('error in try-catch\n$e');
                        }
                      },
                      child: const Icon(
                        Icons.camera_alt,
                        size: 30,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
