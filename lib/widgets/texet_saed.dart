import 'package:flutter/material.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';

class TextSaed extends StatelessWidget {
  const TextSaed({
    super.key, this.size = 28, required this.text,
  });
  final String text;
final double? size;
  @override
  Widget build(BuildContext context) {
    return Text(text,style: TextStyle(
              fontSize: size,
              fontWeight: FontWeight.w800,
              fontFamily: poppinsFont,
              color: whiteColor,
            ),);
  }
}