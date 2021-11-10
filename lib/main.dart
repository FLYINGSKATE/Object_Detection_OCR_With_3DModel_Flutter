import 'package:flutter/material.dart';
import 'package:flutter_fbx3d_viewer/fbx_viewer/flutter_fbx3d_viewer.dart';
import 'package:vector_math/vector_math.dart' as Math;

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class Object3DDetails {
  String animationPath;
  String animationTexturePath;
  Math.Vector3 rotation;
  double zoom;
  Color color, lightColor;
  double gridTileSize;
  int animationLength;
  double animationSpeed;

  Object3DDetails(this.animationPath, this.animationTexturePath, this.rotation, this.zoom, this.animationLength, this.animationSpeed,
      {this.color = Colors.black, this.lightColor = Colors.white, this.gridTileSize = 0.5});
}

class MyWidget extends StatelessWidget {
  Fbx3DViewerController _fbx3DAnimationController=Fbx3DViewerController();

  @override
  Widget build(BuildContext context) {
    final object = Object3DDetails(
      "assets/turtle.fbx",
      "assets/turtle.png",
      Math.Vector3(216, 10, 230),
      3,
      25,
      0.4,
      color: Colors.black.withOpacity(0.2),
      lightColor: Colors.white.withOpacity(0.7),
      gridTileSize: 15.0,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Fbx3DViewer(
          lightPosition: Math.Vector3(20, 10, 10),
          lightColor: Colors.black.withOpacity(0.2),
          color: Colors.black.withOpacity(0.8),
          refreshMilliseconds: 1,
          size: Size(100, 100),
          initialZoom: object.zoom,
          endFrame: object.animationLength,
          initialAngles: object.rotation,
          fbxPath: object.animationPath,
          texturePath: object.animationTexturePath,
          animationSpeed: object.animationSpeed,
          fbx3DViewerController: _fbx3DAnimationController,
          showInfo: true,
          showWireframe: true,
          wireframeColor: Colors.blue.withOpacity(0.5),
          onHorizontalDragUpdate: (d) {
            if (object.animationPath.contains("turtle") || object.animationPath.contains("knight"))
              _fbx3DAnimationController.rotateZ(d);
            else
              _fbx3DAnimationController.rotateZ(-d);
          },
          onVerticalDragUpdate: (d) => _fbx3DAnimationController.rotateX(d),
          onZoomChangeListener: (zoom) => object.zoom = zoom,
          onRotationChangeListener: (Math.Vector3 rotation) => object.rotation.setFrom(rotation),
          panDistanceToActivate: 50,
          gridsTileSize: object.gridTileSize,
        ),
        Text(
          'What it Contains?',
          style: Theme.of(context).textTheme.headline4,
        ),
        Container(color: Colors.white,height: 300),
        SizedBox(height: 20,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: Icon(Icons.camera, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                primary: Colors.blue, // <-- Button color
                onPrimary: Colors.red, // <-- Splash color
              ),
            ),
            ElevatedButton(
              onPressed: () {},
              child: Icon(Icons.camera, color: Colors.white),
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                padding: EdgeInsets.all(20),
                primary: Colors.blue, // <-- Button color
                onPrimary: Colors.red, // <-- Splash color
              ),
            )
          ],
        )
      ],
    );
  }
}
