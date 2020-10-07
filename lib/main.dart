import 'package:flutter/material.dart';
import 'api.dart';
import 'screens/home.dart';

void main() {

  var api = Api();
  api.search('flutter');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'YouFlutterTube',
      home: Home(),
    );
  }
}
