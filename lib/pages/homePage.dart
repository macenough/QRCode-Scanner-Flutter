import 'package:flutter/material.dart';
import 'package:qr_scanner/pages/scanQr.dart';

import 'generateQr.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //Display Image
          Image(
              image: NetworkImage(
                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQQyYwscUPOH_qPPe8Hp0HAbFNMx-TxRFubpg&usqp=CAU")),

          //First Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MaterialButton(
              padding: EdgeInsets.all(15),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => QRViewExample()));
              },
              child: Text(
                "Scan QR Code",
                style: TextStyle(color: Colors.indigo[900]),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.indigo.shade900),
              ),
            ),
          ),
          SizedBox(height: 15),

          //Second Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: MaterialButton(
              padding: EdgeInsets.all(15),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => GenerateQR()));
              },
              child: Text(
                "Generate QR Code",
                style: TextStyle(color: Colors.indigo[900]),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: Colors.indigo.shade900),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
