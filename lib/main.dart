import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ocr/splash_screen.dart';


List<CameraDescription> cameras;

Future<void> main() async {
  // initialize the cameras when the app starts
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  // running the app
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData.dark(),
      home: Splash(),
      debugShowCheckedModeBanner: false,
    );
  }
}


