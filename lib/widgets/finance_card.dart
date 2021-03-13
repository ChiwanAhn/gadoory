import 'package:flutter/material.dart';
import 'package:gadoory/models/finance.dart';
import 'package:gadoory/styles/color.dart';
import 'package:google_fonts/google_fonts.dart';

class FinanceCard extends StatelessWidget {
  const FinanceCard({Key key, this.finance}) : super(key: key);
  final Finance finance;

  @override
  Widget build(BuildContext context) {
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
          finance == null
              ? Container()
              : Positioned(
                  bottom: 16,
                  left: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Image.asset(
                            'assets/icon_arrow_${finance.diff >= 0 ? 'up' : 'down'}.png',
                            width: 12,
                            height: 12,
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Container(
                            height: 14,
                            child: Text(
                              '${finance.diff.toStringAsFixed(2)} (${finance.diffRate.toStringAsFixed(2)}%)',
                              style: GoogleFonts.roboto(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                  color: Color(finance.diff >= 0
                                      ? 0xFF00FFA3
                                      : 0xFFFF4F4F),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 3,
                      ),
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
                              finance.today.toString(),
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
}
