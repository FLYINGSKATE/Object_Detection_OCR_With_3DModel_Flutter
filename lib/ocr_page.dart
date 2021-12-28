
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobile_vision/flutter_mobile_vision.dart';
import 'package:flutter_ocr/realtime/live_camera.dart';

import 'main.dart';


class OCRPage extends StatefulWidget {
  @override
  _OCRPageState createState() => _OCRPageState();
}

class _OCRPageState extends State<OCRPage> {

  int _ocrCamera = FlutterMobileVision.CAMERA_BACK;
  String _text = "Try OCR";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff4B317A),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.black,
            title: Text('OCR & Object Detection'),
            centerTitle: true,
          ),
          body: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/thedetector.gif',
                        width: 250,
                        height: 250,
                      ),
                      SizedBox(height: 20,),
                      Text(_text,style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: EdgeInsets.only(left: 0.0, right: 0.0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.black,
                          child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("OCR Scanning",style: TextStyle(fontSize: 30),)),
                          onPressed: _read,
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                      SizedBox(height: 20,),
                      Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 0.0),
                        child: RaisedButton(
                          textColor: Colors.white,
                          color: Colors.black,
                          child:Padding(
                              padding: EdgeInsets.all(10),
                              child: Text("Object Detection",style: TextStyle(fontSize: 30),)),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => LiveFeed(cameras),
                            ),
                            );
                          },
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ),
                      ),
                    ],
                  )
                ),
              ],
            ),
          ),
      ),
    );
  }

  Future<Null> _read() async {
    List<OcrText> texts = [];
    try {
      texts = await FlutterMobileVision.read(
        camera: _ocrCamera,
        waitTap: true,
      );

      setState(() {
        _text = texts[0].value;
      });
    } on Exception {
      texts.add( OcrText('Failed to recognize text'));
    }
  }
}