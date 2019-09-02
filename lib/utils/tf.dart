import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/services.dart';
import 'package:tflite/tflite.dart';

typedef void SSDCallBack(List recognitions);

class TFHelper {
  static bool _isDetecting = false;

  static Future<bool> loadSSDModel() async {
    Tflite.close();
    try {
      String res;
      res = await Tflite.loadModel(
          model: "assets/ssd_mobilenet.tflite",
          labels: "assets/ssd_mobilenet.txt");
      print(res);
    } on PlatformException catch (err) {
      print('Failed to load model.');
      throw err;
    }
    return true;
  }

  static Future<void> ssdOD(CameraImage img, SSDCallBack callBack) async {
    if (!_isDetecting) {
      _isDetecting = true;
      Tflite.detectObjectOnFrame(
        bytesList: img.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        model: "SSDMobileNet",
        imageHeight: img.height,
        imageWidth: img.width,
        numResultsPerClass: 1,
      ).then((recognitions) {
        _isDetecting = false;
        callBack(recognitions);
      });
    }
  }

  static void close() {
    Tflite.close();
  }
}
