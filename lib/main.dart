import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/browser.dart' as tz;
import 'package:weather/weather.dart';

import 'ui.dart';

void main() async {
  await tz.initializeTimeZone();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'gadoory',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class TimeZone {
  String displayName;
  Weather weather;
  String locale;

  TimeZone(String displayName, String locale) {
    this.displayName = displayName;
    this.locale = locale;
  }

  DateTime get localTime {
    final timezone = tz.getLocation(locale);
    return tz.TZDateTime.from(DateTime.now(), timezone);
  }
}

class Finance {
  double today;
  double yesterday;

  double get diff => today - yesterday;

  double get diffRate => ((today / yesterday) - 1) * 100;
}

class _MyHomePageState extends State<MyHomePage> {
  var data = [
    TimeZone('Seoul', 'Asia/Seoul'),
    TimeZone('Hong Kong', 'Asia/Hong_Kong'),
    TimeZone('London', 'Europe/London'),
    TimeZone('New York', 'America/New_York'),
    TimeZone('Toronto', 'America/Toronto'),
    TimeZone('Los Angeles', 'America/Los_Angeles'),
    TimeZone('Seattle', 'America/Los_Angeles'),
  ];

  var uber;

  @override
  void initState() {
    super.initState();
    loop();
    weather();
    finance();
  }

  void loop() async {
    while (true) {
      update();
      await Future.delayed(Duration(seconds: 1));
    }
  }

  update() async {
    setState(() {});
  }

  void weather() async {
    WeatherFactory wf = WeatherFactory('34447a7ec0ffb652b17e901ef4e88004');
    for (var i = 0; i < data.length; i++) {
      data[i].weather = await wf.currentWeatherByCityName(data[i].displayName);
    }
    setState(() {});
  }

  void finance() async {
    var url = Uri.parse(
        'https://docs.google.com/spreadsheets/d/e/2PACX-1vRceLFXyWQfMpAI-8ravTmYNKBSD1ZhlRMLJn0Vln7odY621CHAQhihQpP0Lh2tVmgsbLD6uWeaVMsY/pub?gid=0&single=true&output=csv');
    var csv = await http.read(url);
    var list = csv.split(',');
    uber = Finance()
      ..today = double.parse(list.first)
      ..yesterday = double.parse(list.last);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 239, 228),
      body: Center(
        child: Container(
          width: 360,
          child: GridView.builder(
            padding: EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              childAspectRatio: 0.75,
            ),
            itemCount: data.length + 1,
            itemBuilder: (context, index) {
              return index < data.length
                  ? UI.timeZoneCard(data[index])
                  : UI.financeCard(uber);
            },
          ),
        ),
      ),
    );
  }
}
