import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:paladinsedge/theme/index.dart' as theme;
import 'package:paladinsedge/widgets/index.dart' as widgets;

class GoogleButton extends StatelessWidget {
  final bool isLoggingIn;
  final void Function() onGoogleSignIn;

  const GoogleButton({
    required this.isLoggingIn,
    required this.onGoogleSignIn,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return widgets.Ripple(
      margin: const EdgeInsets.only(bottom: 25, left: 15, right: 15),
      width: width - 30,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF202020).withOpacity(0.25),
            blurRadius: 5,
            offset: const Offset(0, 5),
          )
        ],
      ),
      borderRadius: BorderRadius.circular(15),
      onTap: onGoogleSignIn,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Row(
        children: [
          isLoggingIn
              ? const widgets.LoadingIndicator(
                  lineWidth: 3,
                  size: 36,
                  color: theme.themeMaterialColor,
                )
              : Image.asset(
                  'assets/icons/google-colored.png',
                  width: 36,
                  height: 36,
                ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                'SignIn with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey.shade800,
                  fontFamily: GoogleFonts.poppins().fontFamily,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
