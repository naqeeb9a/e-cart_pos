import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pos/utils/constants/font_constants.dart';

Widget textField({
  TextInputType keyboardType = TextInputType.text,
  required TextInputAction textInputAction,
  required String hintText,
  required TextEditingController controller,
  required FocusNode focusNode,
  bool isDroDown = false,
  List<TextInputFormatter>? inputFormatters,
  bool isPassword = false,
  bool isPhone = false,
  bool readOnly = false,
  bool isCode = false,
  bool isSearch = false,
  int minLines=1,
  void Function()? onTap
}) {
  return TextFormField(
    controller: controller,
    focusNode: focusNode,
    inputFormatters: inputFormatters,
    keyboardType: keyboardType,
    textInputAction: textInputAction,
    minLines: minLines,
    maxLines: 7,
    obscureText: isPassword,
      onTap: onTap,
      readOnly:readOnly,
    style: TextStyle(
        color: readOnly?Color(0xffBCBCBC):Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.w500,
        fontFamily: FontConstants.medium),
    decoration: InputDecoration(
        contentPadding: isSearch?EdgeInsets.symmetric(horizontal: 16):null,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isPhone ? 0 : 8),
            topRight: Radius.circular(isCode ? 0 : 8),
            bottomLeft: Radius.circular(isPhone ? 0 : 8),
            bottomRight: Radius.circular(isCode ? 0 : 8),
          ),
          borderSide: const BorderSide(
            color: Color(0xff76B139),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(isPhone ? 0 : 8),
            topRight: Radius.circular(isCode ? 0 : 8),
            bottomLeft: Radius.circular(isPhone ? 0 : 8),
            bottomRight: Radius.circular(isCode ? 0 : 8),
          ),
          borderSide: const BorderSide(
            color: Color(0xffEAEAEA),
          ),
        ),
        fillColor: readOnly?Color(0xffF1F2ED):Colors.white,
        filled: true,
        suffixIcon: isDroDown ? const Icon(Icons.keyboard_arrow_down) : null,
        hintText: hintText,
        hintStyle: const TextStyle(
            color: Color(0xffBCBCBC),
            fontSize: 15,
            fontWeight: FontWeight.w500,
            fontFamily: FontConstants.medium)),
  );
}
