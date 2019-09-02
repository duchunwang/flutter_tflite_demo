import 'package:flutter/foundation.dart';

class ODModel extends ChangeNotifier {
  double _height;
  double _width;
  List _recognitions;

  get height => _height;
  get width => _width;
  get recognitions => _recognitions;

  set height(v) => _height = v;
  set width(v) => _width = v;

  void setODModel(recognitions) {
    this._recognitions = recognitions;
    notifyListeners();
  }
}
