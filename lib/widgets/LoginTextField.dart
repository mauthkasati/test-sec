import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginTextField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final String text;
  final IconData iconData;
  final bool isPass;

  LoginTextField(this.controller, this.text, this.iconData, this.isPass,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    return Container(
      margin: EdgeInsets.only(top: h / 30),
      width: w * 0.75,
      // padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border: Border.all(width: 0.5, color: Colors.black12),
      ),
      child: Center(
        child: TextFormField(
          controller: controller,
          textAlign: TextAlign.end,
          cursorColor: Color(0xFFe63639),
          obscureText: isPass,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 14,horizontal: 15),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15), // Set border radius
              borderSide: BorderSide(color: Colors.blue), // Set border color
              gapPadding: 5, // Set padding between the border and input text
            ),
            hoverColor: const Color(0xFF00b1eb),
            hintText: '* $text',
            hintStyle: GoogleFonts.vazirmatn(
              color: Colors.black,
              textStyle: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
              decoration: TextDecoration.none,
            ),

            focusColor: const Color(0xFF00b1eb),
            prefixIcon: Icon(
              iconData,
              color: const Color(0xFF00b1eb),
              size: 30,
            ),
          ),
        ),
      ),
    );
  }
}
