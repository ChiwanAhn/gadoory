import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather/weather.dart';

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
  Weather weather;

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
    TimeZone('New York', -5),
    TimeZone('Toronto', -5),
    TimeZone('Los Angeles', -8),
    TimeZone('Seattle', -8),
  ];

  @override
  void initState() {
    super.initState();
    loop();
    weather();
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
      data[i].weather = await wf.currentWeatherByCityName(data[i].name);
      setState(() {});
    }
  }

  String getTimeText(int index) {
    var utc = DateTime.now().toUtc();
    var time = utc.add(data[index].timeZoneOffset);
    var hour = time.hour.toString().padLeft(2, '0');
    var minute = time.minute.toString().padLeft(2, '0');
    var second = time.second.toString().padLeft(2, '0');
    return '$hour:$minute:$second';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 242, 239, 228),
      body: Center(
        child: Container(
          width: 500,
          child: GridView.count(
            childAspectRatio: 1.3,
            crossAxisCount: 2,
            children: List.generate(
              data.length,
              (index) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data[index].name,
                            style: TextStyle(fontSize: 20),
                          ),
                          data[index].weather != null
                              ? Image.network(
                                  'https://openweathermap.org/img/wn/${data[index].weather.weatherIcon}@2x.png',
                                  width: 50,
                                  height: 50,
                                )
                              : Container(),
                          data[index].weather != null
                              ? Text(
                                  '${data[index].weather.temperature.celsius.ceil()}°C')
                              : Container()
                        ],
                      ),
                      Text(
                        getTimeText(index),
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
