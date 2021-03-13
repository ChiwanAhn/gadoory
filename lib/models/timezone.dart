import 'package:weather/weather.dart';
import 'package:timezone/browser.dart' as tz;

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
