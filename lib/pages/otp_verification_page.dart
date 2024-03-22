import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/pages/reset_password.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/bottom_button.dart';
import 'package:pill_app/widgets/page_header.dart';
import 'package:pill_app/widgets/simplfied_header_textfield.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';


// ignore: must_be_immutable
class OtpVerificationPage extends StatelessWidget {
  OtpVerificationPage({super.key,  required this.email});

  TextEditingController otpController = TextEditingController();
  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          preferredSize: Size(context.getWidth(), 110),
          child: const PageHeader(
            bottomText: "تحقق من الرمز",
            height: 110,
            canGoBack: true,
            showLogo: false,
            bottomTextAlignment: Alignment.center,
          )),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: BlocConsumer<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthOTPVerifiedState){
                context.showSuccessSnackBar(state.msg);
                context.push(ResetPasswordPage(), true);
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState){
                return const Center(child: CircularProgressIndicator(color: midGreenColor,),);
              }else {
              return ListView(
                shrinkWrap: true,
                children: [
                  height16,
                  Image.asset(
                    "assets/images/otp.png",
                    height: 350,
                    width: 350,
                  ),
                  const Text(
                    "تم إرسال الرمز إلى بريدك الإلكتروني، الرجاء إدخال الرمز",
                    style: TextStyle(
                        color: blackColor,
                        fontFamily: tajwalFont,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.right,
                  ),
                  height16,
                  OtpTextField(
                    numberOfFields: 6,
                    borderColor: greyColor,
                    focusedBorderColor: signatureGreenColor,
                    showFieldAsBox: true,
                    fieldWidth: context.getWidth() * .12,
                    fieldHeight: context.getWidth() * .12,
                    cursorColor: signatureGreenColor,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    onCodeChanged: (value) {
                      otpController.text = value;
                    },
                    onSubmit: (value) {
                      context.read<AuthBloc>().add(VerifyOtpEvent(email: email, otpToken: value));
                    },
                  ),
                  height16,
                  BottomButton(
                      onTap: () {
                        context.read<AuthBloc>().add(VerifyOtpEvent(email: email, otpToken: otpController.text));
                      },
                      text: "تحقق من الرمز",
                      fillColor: midGreenColor,
                      borderSide: BorderSide.none)
                ],
              );
              }
            },
          ),
        ),
      ),
    );
  }
}
