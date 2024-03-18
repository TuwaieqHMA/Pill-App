import 'package:flutter/material.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/pages/login_page.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/app_logo.dart';
import 'package:pill_app/widgets/bottom_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: noColor,
      body: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [deepGreenColor, signatureGreenColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: const SafeArea(
            child: Column(children: [
              height186,
              AppLogo(),
            ]),
          )),
      bottomSheet: Container(
        width: context.getWidth(context),
        height: 303,
        padding: const EdgeInsets.only(left: 38, right: 38, top: 34),
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          children: [
            BottomButton(
              fillColor: midGreenColor,
              text: "تسجيل دخول",
              borderSide: BorderSide.none,
              onTap: () {
                context.push(context, LoginPage(), true);
              },
            ),
            height28,
             BottomButton(
                text: "الدخول كزائر",
                textstyle: const TextStyle(color: blackColor, fontFamily: poppinsFont, fontSize: 20, fontWeight: FontWeight.w900),
                fillColor: whiteColor,
                borderSide: const BorderSide(color: deepGreenColor, width: 1),
                onTap: (){},),
                
          ],
        ),
      ),
    );
  }
}
