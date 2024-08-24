import 'package:flutter/cupertino.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: WeatherApp(),
    );
  }
}