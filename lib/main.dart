import 'dart:async';

import 'package:flutter/material.dart';

void main() {
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
  String name;
  Duration timeZoneOffset;

  TimeZone(this.name, int offset) {
    this.timeZoneOffset = Duration(hours: offset);
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var data = [
    TimeZone('Seoul', 9),
    TimeZone('Hong Kong', 8),
    TimeZone('Berlin', 1),
    TimeZone('London', 0),
    TimeZone('Toronto', -5),
    TimeZone('New York', -5),
    TimeZone('Los Angeles', -8),
    TimeZone('Seattle', -8),
  ];

  DateTime utc = DateTime.now().toUtc();

  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    while (true) {
      update();
      await Future.delayed(Duration(seconds: 1));
    }
  }

  update() async {
    utc = DateTime.now().toUtc();
    setState(() {});
  }

  String getTimeText(int index) {
    var time = utc.add(data[index].timeZoneOffset);
    var hour = time.hour.toString().padLeft(2, '0');
    var minute = time.minute.toString().padLeft(2, '0');
    var second = time.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                Text(
                  data[index].name,
                  style: TextStyle(fontSize: 30),
                ),
                Text(
                  getTimeText(index),
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
