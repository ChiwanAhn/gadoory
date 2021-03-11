import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'main.dart';

class UI {
  static Color textColor = Color(0xFFFAFAFA);

  static Widget financeCard(double uber) {
    return DecoratedBox(
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          )),
      child: Stack(
        children: [
          Positioned(
            top: 24,
            left: 20,
            child: Image.asset(
              'assets/logo_uber.png',
              width: 60,
            ),
          ),
          uber == null
              ? Container()
              : Positioned(
                  bottom: 16,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            height: 28,
                            child: Text(
                              '\$',
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: textColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            height: 28,
                            child: Text(
                              uber.toString(),
                              style: GoogleFonts.lato(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 24,
                                  color: textColor,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
        ],
      ),
    );
  }

  static Widget timeZoneCard(TimeZone item) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
              'assets/city_${item.displayName.replaceAll(' ', '_').toLowerCase()}.png'),
        ),
      ),
      child: Stack(
        children: [
          item.weather != null
              ? Positioned(
                  top: 16,
                  right: 16,
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/icon_weather_${item.weather.weatherIcon.substring(0, 2)}.png',
                        width: 20,
                        height: 20,
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Container(
                        height: 24,
                        child: Text(
                          '${item.weather.temperature.celsius.ceil()}°C',
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
                    item.displayName,
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 43,
                  child: Text(
                    DateFormat.Hm().format(item.localTime),
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 36,
                        color: textColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
