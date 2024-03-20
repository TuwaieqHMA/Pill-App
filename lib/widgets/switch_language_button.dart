import 'package:flutter/material.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';

class SwitchLanguageButton extends StatelessWidget {
  const SwitchLanguageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: context.getHeight() * 0.04,
      left: context.getWidth() * 0.07,
      child: InkWell(
        onTap: () {
          // TODO change language
        },
        child: Container(
          alignment: Alignment.center,
          width: context.getWidth() * 0.06,
          height: context.getWidth() * 0.06,
          decoration: BoxDecoration(
            border: Border.all(color: goldColor, width: 2),
          ),
          child: const Text(
            "E",
            style: TextStyle(
                color: whiteColor,
                fontSize: 13,
                fontFamily: poppinsFont,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}