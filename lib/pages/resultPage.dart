import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ResultPage extends StatefulWidget {
  Barcode? result;

  ResultPage({Key? key, required this.result}) : super(key: key);

  @override
  _ResultPageState createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Result"),
        ),
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/resultimg.png'),
              SizedBox(height: 20,),
              Center(
                  child: Text(
                'Title: ${widget.result!.code.toString()}',
                style: TextStyle(fontSize: 20),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
