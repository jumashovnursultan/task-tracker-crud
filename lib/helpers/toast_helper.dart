import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
export 'package:toastification/toastification.dart';
import 'package:toastification/toastification.dart';

Future<void> showToast(
  BuildContext context, {
  required String msg,
  int duration = 5,
  bool showProgressBar = false,
  ToastificationType? type,
  Alignment alignment = Alignment.bottomCenter,
}) async {
  Color? bgColor;

  switch (type) {
    case ToastificationType.error:
      bgColor = Theme.of(context).colorScheme.error;
      break;
    case ToastificationType.success:
      bgColor = Theme.of(context).colorScheme.primary;
      break;
    case ToastificationType.info:
      bgColor = Color(0xff2358DF);
      break;
    case ToastificationType.warning:
      bgColor = Color(0xffFFC107);
      break;
    default:
      bgColor = Colors.white;
  }

  toastification
    ..dismissAll()
    ..show(
      context: context,
      type: type,
      description: Text(
        msg,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.ubuntu().fontFamily,
          letterSpacing: -.3,
          color: Colors.white,
        ),
        textAlign: TextAlign.left,
        overflow: TextOverflow.visible,
      ),
      alignment: alignment,
      showIcon: false,
      dragToClose: true,
      showProgressBar: showProgressBar,
      borderRadius: BorderRadius.circular(20),
      dismissDirection: DismissDirection.up,
      autoCloseDuration: Duration(seconds: duration),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      foregroundColor: Colors.white,
      backgroundColor: bgColor,
      borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
      animationDuration: Duration(milliseconds: 200),
      style: ToastificationStyle.fillColored,
      animationBuilder: (context, animation, alignment, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
}
