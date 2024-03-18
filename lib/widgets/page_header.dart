import 'package:flutter/material.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/widgets/app_logo.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key, required this.bottomText,
  });

  final String bottomText;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(context),
      height: 370,
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 32),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16)),
          gradient: LinearGradient(
              colors: [deepGreenColor, signatureGreenColor],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back_ios_new_rounded, color: whiteColor,)),
                  const Align(
                    alignment: Alignment.center,
                    child: AppLogo(isSmall: true,)),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text(bottomText, style: const TextStyle(color: whiteColor, fontFamily: tajwalFont, fontSize: 24, fontWeight: FontWeight.bold),))
                ],
              ),
    );
  }
}