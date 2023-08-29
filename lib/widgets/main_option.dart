import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

class MainOption extends StatelessWidget {
  final String text;
  final int numOfVacations;


  const MainOption(this.text,this.numOfVacations, {super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Container(
      height: h * 0.15,
      width: w * 0.4,
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: w * 0.22,
                height: h*0.05,
                child: Center(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.vazirmatn(
                      color: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: h*0.015),
          Text(
            '${numOfVacations} ${'days'.tr()}',
            textAlign: TextAlign.center,
            style: GoogleFonts.vazirmatn(
              color: Colors.white,
              textStyle: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
              ),
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
