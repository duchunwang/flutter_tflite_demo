import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tflite_example/components/bbox.dart';
import 'package:tflite_example/components/camera.dart';
import 'package:tflite_example/components/loading.dart';
import 'package:tflite_example/models/od_model.dart';
import 'package:tflite_example/utils/tf.dart';

class MainPage extends StatefulWidget {
  @override
  MainPageState createState() => new MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  void dispose() {
    TFHelper.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: TFHelper.loadSSDModel(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }
          return ChangeNotifierProvider<ODModel>(
            builder: (context) => ODModel(),
            child: Stack(
              children: <Widget>[
                Camera(),
                BBox(),
              ],
            ),
          );
        } else {
          return Loading('loading model');
        }
      },
    );
  }
}
