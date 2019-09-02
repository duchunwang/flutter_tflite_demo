import 'package:flutter/material.dart';

import 'pages/main_page.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('tflite example app'),
        ),
        body: MainPage(),
      ),
    );
  }
}
