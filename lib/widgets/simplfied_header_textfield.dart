import 'package:flutter/material.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';

class SimplfiedHeaderTextField extends StatelessWidget {
  const SimplfiedHeaderTextField({
    super.key,
    required this.emailController, required this.label, this.isObscured = false,
  });

  final String label;
  final bool? isObscured;
  final TextEditingController emailController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(label, style: const TextStyle(color: blackColor, fontFamily: tajwalFont, fontSize: 18, fontWeight: FontWeight.bold, ),),
        height8,
        TextField(
          obscureText: isObscured!,
          controller: emailController,
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
