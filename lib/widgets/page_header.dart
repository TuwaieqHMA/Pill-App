import 'package:flutter/material.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/widgets/app_logo.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({
    super.key, required this.bottomText, required this.height, this.showLogo = true, required this.canGoBack, this.bottomTextAlignment,
  });

  final String bottomText;
  final double height;
  final bool? showLogo;
  final bool canGoBack;
  final Alignment? bottomTextAlignment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.getWidth(),
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
                  (canGoBack) ? IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: const Icon(Icons.arrow_back_ios_new_rounded, color: whiteColor,)) : const SizedBox(),
                  (showLogo!) ? const Align(
                    alignment: Alignment.center,
                    child: AppLogo(isSmall: true,)) : const SizedBox(),
                  Align(
                    alignment: bottomTextAlignment ?? Alignment.bottomRight,
                    child: Text(bottomText, style: const TextStyle(color: whiteColor, fontFamily: tajwalFont, fontSize: 24, fontWeight: FontWeight.bold),))
                ],
              ),
    );
  }
}