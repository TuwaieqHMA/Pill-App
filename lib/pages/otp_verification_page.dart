import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/bottom_button.dart';
import 'package:pill_app/widgets/page_header.dart';
import 'package:pill_app/widgets/simplfied_header_textfield.dart';

// ignore: must_be_immutable
class OtpVerificationPage extends StatelessWidget {
  OtpVerificationPage({super.key});

  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(preferredSize: Size(context.getWidth(), 110), child: 
      const PageHeader(bottomText: "تحقق من الرمز", height: 110, canGoBack: true, showLogo: false, bottomTextAlignment: Alignment.center,)),
      body: Center(child: Padding(
        padding: const EdgeInsets.only(left: 24, right: 24,),
        child: ListView(
          shrinkWrap: true,
          children: [
            height16,
            Image.asset("assets/images/otp.png", height: 350, width: 350,),
            const Text("تم إرسال الرمز إلى بريدك الإلكتروني، الرجاء إدخال الرمز", style: TextStyle(color: blackColor, fontFamily: tajwalFont, fontSize: 20, fontWeight: FontWeight.w600), textAlign: TextAlign.right,),
            height16,
            SimplfiedHeaderTextField(controller: otpController, label: "الرمز", inputFormatters: [FilteringTextInputFormatter.digitsOnly], maxLength: 6,),
            height16,
            BottomButton(
              onTap: (){

              },
              text: "تحقق من الرمز", fillColor: midGreenColor, borderSide: BorderSide.none)
            
          ],
        ),
      ),),
    );
  }
}