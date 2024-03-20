import 'package:flutter/material.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key, this.isSmall = false,
  });

  final bool? isSmall;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset("assets/images/saed_logo.png", width: (isSmall!) ? 139 : null, height: (isSmall!) ? 135 : null,),
        Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.baseline,
      textBaseline: TextBaseline.alphabetic,
      children: [
        Image.asset("assets/icons/give_pill.png", width: (isSmall!) ? 26 : null, height: (isSmall!) ? 26 : null,),
        width8,
        Text("ساعد" ,style: TextStyle(color: whiteColor, fontFamily: tajwalFont, fontSize: (isSmall!) ? 24 : 28, fontWeight: FontWeight.w600), textAlign: TextAlign.end,)
      ],
    )
      ],
    );
  }
}