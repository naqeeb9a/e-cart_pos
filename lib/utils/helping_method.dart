import 'package:flutter/material.dart';

class HelpingMethods {
  openAndReplaceScreen({
    required BuildContext context,
    required Widget screen,
  }) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => screen));
  }

  openScreen({
    required BuildContext context,
    required Widget screen,
  }) {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => screen));
  }
}
