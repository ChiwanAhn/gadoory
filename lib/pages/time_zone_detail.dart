import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gadoory/models/timezone.dart';
import 'package:gadoory/styles/color.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TimeZoneDetail extends StatefulWidget {
  const TimeZoneDetail({Key key, @required this.timeZone}) : super(key: key);

  final TimeZone timeZone;

  @override
  _TimeZoneDetailState createState() => _TimeZoneDetailState();
}

class _TimeZoneDetailState extends State<TimeZoneDetail> {
  List<int> hearts = [];

  addHeart() {
    print(hearts);
    setState(() {
      hearts.add(DateTime.now().microsecondsSinceEpoch);
    });
  }

  removeHeart(int id) {
    setState(() {
      hearts.remove(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Color.fromARGB(255, 242, 239, 228),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            _buildBackgroundImage(),
            _buildWeatherIcon(),
            _buildTime(),
            _buildHeartButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBackgroundImage() {
    return Positioned(
      top: -16,
      left: -16,
      right: -16,
      bottom: -16, // FIXME: temporary code for rounded clipped images
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(
          sigmaX: 4,
          sigmaY: 4,
        ),
        child: Image(
          fit: BoxFit.cover,
          image: AssetImage(
              'assets/city_${widget.timeZone.displayName.replaceAll(' ', '_').toLowerCase()}.png'),
        ),
      ),
    );
  }

  Widget _buildWeatherIcon() {
    return Positioned(
      child: Center(
        child: Image.asset(
          'assets/icon_weather_${widget.timeZone.weather.weatherIcon.substring(0, 2)}.png',
          width: 20,
          height: 20,
        ),
      ),
    );
  }

  Widget _buildTime() {
    return Positioned(
      bottom: 24,
      left: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 19,
            child: Text(
              widget.timeZone.displayName,
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
                  DateFormat('hh:mm').format(widget.timeZone.localTime),
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
                  DateFormat('a').format(widget.timeZone.localTime),
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
    );
  }

  Widget _buildHeartButton() {
    return Positioned(
      bottom: 24,
      right: 24,
      child: Stack(
        children: [
          ...hearts
              .map(
                (e) => Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: FlyingHeartIcon(
                      id: e,
                      onFlyAway: (id) {},
                    ),
                  ),
                ),
              )
              .toList()
              .reversed,
          IconButton(
            icon: Icon(
              Icons.favorite_border_outlined,
              color: textColor,
            ),
            iconSize: 32,
            onPressed: () {
              addHeart();
            },
          ),
        ],
      ),
    );
  }
}

class FlyingHeartIcon extends StatefulWidget {
  FlyingHeartIcon({
    Key key,
    @required this.id,
    @required this.onFlyAway,
    this.iconSize = 32,
  }) : super(key: key);

  final int id;
  final Function(int id) onFlyAway;
  final double iconSize;

  @override
  _FlyingHeartIconState createState() => _FlyingHeartIconState();
}

class _FlyingHeartIconState extends State<FlyingHeartIcon>
    with TickerProviderStateMixin {
  AnimationController _controller;

  static const double maxY = -200;
  static const double maxX = 15;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _play();

    color = Color((Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1);

    leftOrRight = Random().nextDouble() > 0.5 ? -1 : 1;
    final variant = Random().nextDouble() * 10;

    vertical = Tween<double>(begin: 0, end: maxY)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease))
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              widget.onFlyAway(widget.id);
            }
          });
    horizontal = Tween<double>(begin: 0, end: (maxX + variant) * leftOrRight)
        .animate(CurvedAnimation(parent: _controller, curve: ShakeCurve()));
    weight = Tween<double>(begin: 1, end: 0.1 * leftOrRight)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
    opacity = Tween<double>(begin: 1, end: 0)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.ease));
  }

  Future<void> _play() async {
    try {
      await _controller.forward().orCancel;
    } on TickerCanceled {
      widget.onFlyAway(widget.id);
    }
  }

  Color color;
  int leftOrRight;
  Animation<double> vertical;
  Animation<double> horizontal;
  Animation<double> weight;
  Animation<double> opacity;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
              horizontal.value * weight.value +
                  (1 - weight.value) * 2 * leftOrRight,
              vertical.value),
          child: Opacity(
            opacity: opacity.value,
            child: Icon(
              Icons.favorite,
              color: color,
              size: widget.iconSize,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class ShakeCurve extends Curve {
  @override
  double transform(double t) => sin(t * pi * 2.5).abs();
}
