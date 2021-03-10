import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather/weather.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_browser.dart';
// import 'package:intl/locale.dart';
import 'package:timezone/browser.dart' as tz;

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
      data[i].weather = await wf.currentWeatherByCityName(data[i].displayName);
      setState(() {});
    }
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
                final item = data[index];
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            item.displayName,
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                          item.weather != null
                              ? Image.network(
                                  'https://openweathermap.org/img/wn/${item.weather.weatherIcon}@2x.png',
                                  width: 50,
                                  height: 50,
                                )
                              : Container(),
                          item.weather != null
                              ? Text(
                                  '${item.weather.temperature.celsius.ceil()}°C')
                              : Container()
                        ],
                      ),
                      Text(
                        DateFormat.jms().format(item.localTime),
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
