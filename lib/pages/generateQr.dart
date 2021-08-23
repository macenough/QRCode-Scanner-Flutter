import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'dart:ui' as ui;
import 'package:image_gallery_saver/image_gallery_saver.dart';

class GenerateQR extends StatefulWidget {
  @override
  _GenerateQRState createState() => _GenerateQRState();
}

class _GenerateQRState extends State<GenerateQR> {
  String qrData = "https://github.com/ChinmayMunje";
  TextEditingController qrdataFeed = TextEditingController();
  final controller = ScreenshotController();

  @override
  Widget build(BuildContext context) => Screenshot(
        controller: controller,
        child: SafeArea(
          child: Scaffold(
            //Appbar having title
            appBar: AppBar(
              title: Text("Generate QR Code"),
            ),
            body: Container(
              padding: EdgeInsets.all(20),
              child: SingleChildScrollView(
                //Scroll view given to Column
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    buildQrImage(),
                    buildTextField(),
                    SizedBox(height: 20),
                    //TextField for input link
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      //Button for generating QR code
                      child: MaterialButton(
                        onPressed: () async {
                          //a little validation for the textfield
                          if (qrdataFeed.text.isEmpty) {
                            final image = await controller.capture();
                            if (image == null) return;
                            await saveImage(image);
                            setState(() {
                              qrData = "";
                              print(qrData.toString());
                            });
                          } else {
                            final image = await controller.capture();
                            if (image == null) return;
                            await saveImage(image);  ////this method is used to images saved in gallery..
                            setState(() {
                              qrData = qrdataFeed.text.toString();
                              print(qrdataFeed.text.toString());
                            });
                          }
                        },
                        //Title given on Button
                        child: Text(
                          "Generate QR Code",
                          style: TextStyle(
                            color: Colors.indigo[900],
                          ),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.indigo.shade900),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                      //Button for generating QR code
                      child: MaterialButton(
                        onPressed: () async {
                          final image = await controller.capture();
                          saveAndShare(
                              image!); //this method is used to images that have been saved will be shared in the galleryshare image

                        },
                        //Title given on Button
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.share,
                              size: 18,
                              color: Colors.indigo.shade900,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              "Share",
                              style: TextStyle(
                                color: Colors.indigo[900],
                              ),
                            ),
                          ],
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          side: BorderSide(color: Colors.indigo.shade900),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );

  buildTextField() {
    return Container(
      child: TextField(
        controller: qrdataFeed,
        decoration: InputDecoration(hintText: "Enter Something Here.."),
      ),
    );
  }

  buildQrImage() => SingleChildScrollView(
        child: QrImage(data: qrData),
      );

  Future<String?> saveImage(Uint8List image) async {
    await [Permission.storage].request();
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '_')
        .replaceAll(':', '_');
    final name = "screenshot_$time";
    final result = await ImageGallerySaver.saveImage(image, name: name);
    print(result.toString());
    return result['filePath'];
  }

  Future saveAndShare(Uint8List bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final image = File('${directory.path}/flutter.png');
    image.writeAsBytesSync(bytes);
    await Share.shareFiles([image.path]);
  }
}
