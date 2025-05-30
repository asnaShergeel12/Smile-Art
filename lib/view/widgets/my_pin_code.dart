import 'package:flutter/material.dart';

import 'package:pinput/pinput.dart';

import '../../constant/app_colors.dart';

class MyPinCode extends StatefulWidget {
  final Function(String) onChanged;
  final Function(String) onCompleted;
  final Color? color;
  final TextEditingController controller;

  const MyPinCode({
    super.key,
    required this.onChanged,
    required this.onCompleted,
    this.color, required this.controller,
  });

  @override
  State<MyPinCode> createState() => _MyPinCodeState();
}

class _MyPinCodeState extends State<MyPinCode> {
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(

      width: 48,
      height: 56,
      margin: const EdgeInsets.all(3),
      textStyle: TextStyle(
          fontSize: 18,
          color: widget.color ??kTextColor ,
          fontWeight: FontWeight.w400,
         ),
      decoration: BoxDecoration(
        color: kSecondaryColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kBorderColor, width: 1),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: kSecondaryColor.withOpacity(0.09),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: kPrimaryColor, width: 1),
      ),
    );

    return Pinput(
      controller: widget.controller,
      length: 6,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: kPrimaryColor.withOpacity(0.03),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: kPrimaryColor, width: 1),
        ),
      ),
      errorPinTheme:  defaultPinTheme.copyWith(
        textStyle: const TextStyle(
          fontSize: 18,
          color: kRedColor,
          fontWeight: FontWeight.w400,
        ),
        decoration: BoxDecoration(

          color: kRedColor.withOpacity(0.09),
          borderRadius: BorderRadius.circular(8),

          border: Border.all(color: kRedColor, width: 1),
        ),
      ),
      onChanged: widget.onChanged,
      onCompleted: widget.onCompleted,
    );
  }
}
