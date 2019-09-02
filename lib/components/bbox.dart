import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tflite_example/models/od_model.dart';

class BBox extends StatelessWidget {
  List<Widget> renderBoxes(ODModel _model) {
    if (_model.recognitions == null ||
        _model.height == null ||
        _model.width == null) return [];

    final List _recognitions = _model.recognitions;

    double factorX = _model.width;
    double factorY =
        _model.height; //_model.width / _model.height * screen.width;
    Color blue = Color.fromRGBO(37, 213, 253, 1.0);
    List<Widget> ret = [];
    var list = _recognitions.map((re) {
      return Positioned(
        left: re["rect"]["x"] * factorX,
        top: re["rect"]["y"] * factorY,
        width: re["rect"]["w"] * factorX,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(
              color: blue,
              width: 2,
            ),
          ),
          child: Text(
            "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
            style: TextStyle(
              background: Paint()..color = blue,
              color: Colors.white,
              fontSize: 12.0,
            ),
          ),
        ),
      );
    }).toList();
    ret.addAll(list);
    return ret;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ODModel>(builder: (context, model, chlid) {
      return Stack(
        children: renderBoxes(model),
      );
    });
  }
}
