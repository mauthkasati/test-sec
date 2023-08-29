import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OneOption extends StatelessWidget {
  final IconData iconData;
  final String description;
  final Function f;

  const OneOption(this.iconData, this.description, this.f, {super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.3),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              f();
            },
            iconSize: 50,
            icon: Icon(
              iconData,
              color: Colors.white,
              size: 50,
            ),
          ),
          SizedBox(
            height: h / 70,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: GoogleFonts.vazirmatn(
              color: Colors.white,
              textStyle: const TextStyle(
                fontSize: 18,
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
