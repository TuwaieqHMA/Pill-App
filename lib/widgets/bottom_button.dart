import 'package:flutter/material.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';

class BottomButton extends StatelessWidget {
   const BottomButton({
    super.key, required this.text, this.textstyle, required this.fillColor, required this.borderSide, this.onTap, this.minSize,
  });

  final String text;
  final TextStyle? textstyle;
  final Color fillColor;
  final BorderSide borderSide;
  final Function()? onTap;
  final Size? minSize;


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        minimumSize: MaterialStatePropertyAll(minSize ?? Size(context.getWidth(), 60)),
        backgroundColor: MaterialStatePropertyAll(fillColor),
        shape:  MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          side: borderSide,
        ))
      ),
      onPressed: onTap, child: Text(text, style: textstyle ?? const TextStyle(color: whiteColor, fontFamily: poppinsFont, fontSize: 20, fontWeight: FontWeight.w900),));
  }
}