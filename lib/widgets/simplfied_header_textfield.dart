import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';

class SimplfiedHeaderTextField extends StatelessWidget {
  const SimplfiedHeaderTextField({
    super.key,
    required this.controller, required this.label, this.isObscured = false, this.textDirection, this.inputFormatters, this.maxLength, this.isEnabled = true, this.isReadOnly = false,
  });

  final String label;
  final bool? isObscured;
  final TextEditingController controller;
  final TextDirection? textDirection;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLength;
  final bool? isEnabled;
  final bool? isReadOnly;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label, style: const TextStyle(color: blackColor, fontFamily: tajwalFont, fontSize: 18, fontWeight: FontWeight.bold, ),),
        height8,
        TextField(
          readOnly: isReadOnly!,
          enabled: isEnabled,
          maxLength: maxLength,
          inputFormatters: inputFormatters,
          textDirection: textDirection,
          obscureText: isObscured!,
          controller: controller,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: lightGreyColor, width: 1.4,)
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: const BorderSide(color: signatureGreenColor, width: 2,)
            ),
          ),
        ),
      ],
    );
  }
}
