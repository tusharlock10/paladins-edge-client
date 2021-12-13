import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paladinsedge/widgets/index.dart' as widgets;

class TagLine extends StatelessWidget {
  const TagLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 15),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 15),
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(
                  'Feature rich\nPaladins manager',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: GoogleFonts.poppins().fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () => widgets.showInfoAlert(context),
            child: Container(
              transform: Matrix4.translationValues(25, 0, 0)..rotateZ(-0.12),
              child: Image.asset(
                'assets/icons/paladins.png',
                width: 140,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
