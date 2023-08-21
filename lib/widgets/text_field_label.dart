import 'package:flutter/material.dart';
import 'package:pos/utils/constants/font_constants.dart';

Widget textFieldLabel({
  required String label,
  bool isRequired = false,
}) {
  return Row(
    children: [
      if (isRequired)
        const Text(
          "* ",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xffFF5555),
            fontWeight: FontWeight.bold,
            fontFamily: FontConstants.bold,
          ),
        ),
      Text(
        label,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          fontFamily: FontConstants.bold,
        ),
      ),
    ],
  );
}
