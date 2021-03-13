import 'package:flutter/material.dart';
import 'package:gadoory/models/timezone.dart';
import 'package:gadoory/styles/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TimeZoneCard extends StatelessWidget {
  const TimeZoneCard({Key key, this.timeZone, this.onTap}) : super(key: key);
  final TimeZone timeZone;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/city_${timeZone.displayName.replaceAll(' ', '_').toLowerCase()}.png'),
          ),
        ),
        child: Stack(
          children: [
            timeZone.weather != null
                ? Positioned(
                    top: 16,
                    right: 16,
                    child: Row(
                      children: [
                        Image.asset(
                          'assets/icon_weather_${timeZone.weather.weatherIcon.substring(0, 2)}.png',
                          width: 20,
                          height: 20,
                        ),
                        SizedBox(
                          width: 4,
                        ),
                        Container(
                          height: 24,
                          child: Text(
                            '${timeZone.weather.temperature.celsius.ceil()}°C',
                            style: GoogleFonts.lato(
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                                color: textColor,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                : Container(),
            Positioned(
              bottom: 16,
              left: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 19,
                    child: Text(
                      timeZone.displayName,
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: textColor,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 43,
                        child: Text(
                          DateFormat('hh:mm').format(timeZone.localTime),
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 36,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 6, 0, 0),
                        height: 14,
                        child: Text(
                          DateFormat('a').format(timeZone.localTime),
                          style: GoogleFonts.lato(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: textColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            timeZone.displayName != 'London'
                ? Container()
                : Center(
                    child: Image.asset(
                      'assets/heart.gif',
                      height: 50,
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
