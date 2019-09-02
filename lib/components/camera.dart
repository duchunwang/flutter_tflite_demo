import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tflite_example/models/od_model.dart';
import 'package:tflite_example/utils/tf.dart';

import 'loading.dart';

class Camera extends StatefulWidget {
  @override
  CameraState createState() => CameraState();
}

class CameraState extends State<Camera> {
  final GlobalKey _key = GlobalKey();
  CameraController controller;

  @override
  void dispose() {
    controller?.stopImageStream();
    controller?.dispose();
    super.dispose();
  }

  Future initCamera() async {
    var cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    await controller.initialize();
  }

  void startCameraOD(ODModel odModel) {
    controller.startImageStream((CameraImage img) {
      var size = _key.currentContext.size;
      odModel.height = size.height;
      odModel.width = size.width;
      TFHelper.ssdOD(img, odModel.setODModel);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initCamera(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          startCameraOD(Provider.of<ODModel>(context, listen: false));
          return AspectRatio(
            key: _key,
            aspectRatio: controller.value.aspectRatio,
            child: CameraPreview(controller),
          );
        } else {
          return Loading('initing camera');
        }
      },
    );
  }
}
