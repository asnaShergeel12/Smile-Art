import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../constant/app_colors.dart';
import 'my_text_widget.dart';

class MyTextField extends StatefulWidget {
  MyTextField({
    super.key,
    this.controller,
    required this.label,
    this.hint,
    this.onChanged,
    this.isObSecure = false,
    this.marginBottom = 18.0,
    this.maxLines,
    this.isFilled = true,
    this.filledColor,
    this.focusedFilledColor,
    this.fhintColor,
    this.hintColor,
    this.bordercolor,
    this.isright,
    this.radius = 10,
    this.prefixIcon,
    this.suffixtext,
    this.suffixIcon,
    this.suffixTap,
    this.keyboardType,
    this.showFlag,
    this.labelColor,
    this.labelWeight,
    this.validator,
    this.textColor,
    this.isoptional = false,
    this.fbordercolor,
    this.focusedLabelColor,
    this.useCountryCodePicker = false,
    this.useOutlinedBorder = true,
  });

  final String label;
  String? hint, suffixtext;
  TextEditingController? controller;
  ValueChanged<String>? onChanged;
  bool? isObSecure,
      isoptional,
      isFilled,
      isright,
      useCountryCodePicker,
      showFlag,
      useOutlinedBorder;
  double? marginBottom;
  int? maxLines;
  double? radius;
  Widget? suffixIcon;
  Widget? prefixIcon;
  Color? filledColor,
      focusedFilledColor,
      focusedLabelColor,
      hintColor,
      bordercolor,
      fbordercolor,
      fhintColor,
      textColor,
      labelColor;
  FontWeight? labelWeight;
  TextInputType? keyboardType;
  VoidCallback? suffixTap;
  String? Function(String?)? validator;

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  late FocusNode _focusNode;
  final ValueNotifier<bool> _focusNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _focusNotifier.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    _focusNotifier.value = _focusNode.hasFocus;
  }

  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: [
        const MoveEffect(
          curve: Curves.ease,
          duration: Duration(milliseconds: 500),
          transformHitTests: false,
        )
      ],
      child: Padding(
        padding: EdgeInsets.only(bottom: widget.marginBottom!),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ValueListenableBuilder(
              valueListenable: _focusNotifier,
              builder: (_, isFocused, child) {
                return TextFormField(
                  cursorColor: kSecondaryColor,
                  keyboardType: widget.keyboardType,
                  maxLines: widget.maxLines ?? 1,
                  controller: widget.controller,
                  onChanged: widget.onChanged,
                  obscureText: widget.isObSecure!,
                  obscuringCharacter: '*',
                  style: TextStyle(
                    fontSize: 15,
                    color: widget.textColor ?? kTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                  validator: widget.validator,
                  textAlign: widget.isright == true ? TextAlign.right : TextAlign.left,
                  focusNode: _focusNode,
                  decoration: InputDecoration(
                    labelText: widget.label, // Added labelText here
                    labelStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isFocused
                          ? widget.focusedLabelColor ?? kPrimaryColor
                          : widget.labelColor ?? kGreyColor,
                    ),
                    prefixIcon: widget.prefixIcon,
                    suffixIcon: widget.suffixIcon != null
                        ? GestureDetector(
                      onTap: widget.suffixTap,
                      child: widget.suffixIcon,
                    )
                        : null,
                    hintText: widget.hint,
                    hintStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: isFocused
                          ? widget.fhintColor ?? kPrimaryColor.withOpacity(0.5)
                          : widget.hintColor ?? kPrimaryColor.withOpacity(0.5),
                    ),
                    filled: true,
                    fillColor: isFocused
                        ? widget.focusedFilledColor ?? kSecondaryColor
                        : widget.filledColor ?? kSecondaryColor,
                    enabledBorder: widget.useOutlinedBorder == true
                        ? OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.bordercolor ?? kBorderColor, width: 1),
                      borderRadius: BorderRadius.circular(widget.radius ?? 10),
                    )
                        : UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.bordercolor ?? kPrimaryColor, width: 1),
                    ),
                    focusedBorder: widget.useOutlinedBorder == true
                        ? OutlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.fbordercolor ?? kPrimaryColor, width: 1),
                      borderRadius: BorderRadius.circular(widget.radius ?? 10),
                    )
                        : UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: widget.fbordercolor ?? kPrimaryColor.withOpacity(0.3),
                          width: 1.5),
                    ),
                    errorBorder: widget.useOutlinedBorder == true
                        ? OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: kRedColor, width: 1),
                      borderRadius: BorderRadius.circular(widget.radius ?? 10),
                    )
                        : const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: kRedColor, width: 1),
                    ),
                    focusedErrorBorder: widget.useOutlinedBorder == true
                        ? OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: kRedColor, width: 1),
                      borderRadius: BorderRadius.circular(widget.radius ?? 10),
                    )
                        : const UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: kRedColor, width: 1.5),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
