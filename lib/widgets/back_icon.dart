import 'package:flutter/material.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/utils/colors.dart';

class BackIcon extends StatelessWidget {
  const BackIcon({super.key, this.onTap});

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: context.getWidth() * 0.1,
        height: context.getWidth() * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: glassGreyColor,
        ),
        child: const Icon(
          Icons.arrow_forward,
          color: greyColor,
        ),
      ),
    );
  }
}
