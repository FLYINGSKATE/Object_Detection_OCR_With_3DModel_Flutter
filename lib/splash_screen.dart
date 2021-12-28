import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_ocr/ocr_page.dart';


class Splash extends StatefulWidget {
  @override
  VideoState createState() => VideoState();
}



class VideoState extends State<Splash> with SingleTickerProviderStateMixin{

  var _visible = true;

  AnimationController animationController;
  Animation<double> animation;

  startTime() async {
    var _duration = new Duration(seconds: 10);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => OCRPage()));
  }

  @override
  void initState() {
    super.initState();



    animationController = new AnimationController(
        vsync: this, duration: new Duration(seconds: 1));
    animation =
    new CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation.addListener(() => this.setState(() {}));
    animationController.forward();

    setState(() {
      _visible = !_visible;
    });
    startTime();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Color(0xff4B317A),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Image.asset(
              'assets/thedetector.gif',
              width: animation.value * 250,
              height: animation.value * 250,
            ),
            Text("Hi , I'm the Detector!",style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold),
            ),
          ],
        ),
      )
    );
  }
}
