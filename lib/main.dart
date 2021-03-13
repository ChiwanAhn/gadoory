import 'package:flutter/material.dart';
import 'package:gadoory/pages/home.dart';
import 'package:get/get.dart';
import 'package:timezone/browser.dart' as tz;

void main() async {
  await tz.initializeTimeZone();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'gadoory',
      home: MyHomePage(),
    );
  }
}
