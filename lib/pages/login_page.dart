import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/bottom_button.dart';
import 'package:pill_app/widgets/page_header.dart';
import 'package:pill_app/widgets/simplfied_header_textfield.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size(context.getWidth(), 370),
          child: const PageHeader(
            bottomText: 'تسجيل الدخول',
          )),
      body: Padding(
        padding:  const EdgeInsets.only(left: 16, right: 16, top: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            SimplfiedHeaderTextField(
              emailController: emailController,
              label: 'الإيميل',
            ),
            height24,
            SimplfiedHeaderTextField(
              emailController: passwordController,
              label: 'كلمة المرور',
            ),
            TextButton(
                style: const ButtonStyle(
                    padding: MaterialStatePropertyAll(EdgeInsets.zero),
                    overlayColor: MaterialStatePropertyAll(glassGreyColor)),
                onPressed: () {},
                child: const Text(
                  "هل نسيت كلمة المرور؟",
                  style: TextStyle(
                      color: deepGreenColor,
                      fontFamily: tajwalFont,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
            height16,
            const Align(
                alignment: Alignment.center,
                child: BottomButton(
                  text: "تسجيل الدخول",
                  fillColor: midGreenColor,
                  borderSide: BorderSide.none,
                  minSize: Size(300, 60),
                )),
            height8,
            Align(
              alignment: Alignment.center,
              child: RichText(
                  text: TextSpan(children: [
                const TextSpan(
                  text: "لا يوجد لديك حساب؟ ",
                  style: TextStyle(
                      color: blackColor,
                      fontFamily: poppinsFont,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                ),
                TextSpan(
                  recognizer: TapGestureRecognizer()..onTap = (){
                    
                  },
                  text: "سجل الآن",
                  style: const TextStyle(
                      color: deepGreenColor,
                      fontFamily: poppinsFont,
                      fontSize: 20,
                      fontWeight: FontWeight.w500),
                )
              ])),
            )
          ],
        ),
      ),
    );
  }
}
