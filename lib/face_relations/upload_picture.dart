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
import 'package:resto_app/constants/used_APIs.dart';

// ignore: must_be_immutable
class UploadPicture extends StatefulWidget {
  final CameraDescription camera;
  String id;

  UploadPicture(
    this.id, {
    super.key,
    required this.camera,
  });

  @override
  State<UploadPicture> createState() => _UploadPictureState();
}

class _UploadPictureState extends State<UploadPicture> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isLoading = false;

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
          ? Container(
              width: w,
              height: h,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.cover,
                ),
              ),
              child: const SpinKitRing(color: Colors.white, size: 150),
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
                  _isLoading
                      ? SizedBox(
                          width: w,
                          height: h,
                          child:
                              const SpinKitRing(color: Colors.white, size: 150),
                        )
                      : FutureBuilder<void>(
                          future: _initializeControllerFuture,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return CameraPreview(_controller);
                            } else {
                              return const Center(
                                child: SpinKitRing(
                                  color: Colors.white,
                                  size: 150,
                                ),
                              );
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

                                logger.w('img path : ${image.path}');
                                if (!mounted) return;

                                //compress image to png
                                final compressedBytes =
                                    await FlutterImageCompress.compressWithFile(
                                  image.path,
                                  format: CompressFormat.png,
                                );

                                final pngImagePath = image.path.replaceAll(
                                  '.jpg',
                                  '.png',
                                );
                                final pngFile = File(pngImagePath);
                                await pngFile.writeAsBytes(compressedBytes!);

                                logger.w(
                                  'Conversion from JPG to PNG successfully\nPNG image path: $pngImagePath',
                                );

                                //call verify API
                                var request = http.MultipartRequest(
                                  'POST',
                                  Uri.parse(
                                    UsedAPIs.getVerifyAPIURL(),
                                  ),
                                );
                                request.files.add(
                                  await http.MultipartFile.fromPath(
                                    'known',
                                    pngImagePath,
                                  ),
                                );

                                // to show loading after clicking on camera
                                Timer(const Duration(milliseconds: 200), () {
                                  setState(() {
                                    _isLoading = true;
                                  });
                                });

                                http.StreamedResponse response =
                                    await request.send();

                                if (response.statusCode == 200) {
                                  String res =
                                      await response.stream.bytesToString();
                                  logger.w(
                                    'verify image successfully\nresponse : $res',
                                  );
                                  // response is 1 when the picture including a face
                                  // response is 0 otherwise
                                  if (res == '1') {
                                    var request2 = http.MultipartRequest(
                                      'POST',
                                      Uri.parse(
                                        UsedAPIs.getUploadFaceAPI(),
                                      ),
                                    );
                                    request2.fields.addAll({'id': widget.id});

                                    request2.files.add(
                                      await http.MultipartFile.fromPath(
                                        'image',
                                        pngImagePath,
                                      ),
                                    );
                                    http.StreamedResponse response2 =
                                        await request2.send();
                                    if (response2.statusCode == 200) {
                                      String res = await response2.stream
                                          .bytesToString();
                                      logger.w(
                                        'uploaded image successfully\nresponse : $res',
                                      );

                                      _isLoading = false;
                                      // ignore: use_build_context_synchronously
                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.SCALE,
                                        dialogType: DialogType.INFO,
                                        btnOkText: 'تأكيد',
                                        body: Center(
                                          child: Text(
                                            'idAddedSuccessfully'.tr(),
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
                                    } else {
                                      logger.w(
                                          'error in upload image\n${response2.reasonPhrase}');
                                    }
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    AwesomeDialog(
                                      context: context,
                                      animType: AnimType.SCALE,
                                      dialogType: DialogType.ERROR,
                                      btnOkText: 'ok'.tr(),
                                      btnOkOnPress: () {
                                        Navigator.of(context).pop();
                                      },
                                      body: Center(
                                        child: Text(
                                          'oneFaceMustExist'.tr(),
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
                                    ).show();
                                  }
                                } else {
                                  logger.w(
                                      'error in verify image\n${response.reasonPhrase}');
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
