import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/pages/otp_verification_page.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/bottom_button.dart';
import 'package:pill_app/widgets/page_header.dart';
import 'package:pill_app/widgets/simplfied_header_textfield.dart';

// ignore: must_be_immutable
class EmailVerifcationPage extends StatelessWidget {
  EmailVerifcationPage({super.key});

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: PreferredSize(
          preferredSize: Size(context.getWidth(), context.getHeight() * .14,),
          child: PageHeader(
            bottomText: "إعادة تعيين كلمة المرور",
            height: context.getHeight() * .14,
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
              if (state is AuthEmailVerifiedState){
                context.showSuccessSnackBar(state.msg);
                context.push(OtpVerificationPage(email: emailController.text,), true);
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
                    "assets/images/forget_password.png",
                    height: 350,
                    width: 350,
                  ),
                  const Text(
                    "ادخل الإيميل الخاص بك لتغيير كلمة المرور",
                    style: TextStyle(
                        color: blackColor,
                        fontFamily: tajwalFont,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.right,
                  ),
                  height16,
                  SimplfiedHeaderTextField(
                    controller: emailController,
                    label: "الإيميل",
                  ),
                  height16,
                  BottomButton(
                      onTap: () {context.read<AuthBloc>().add(SendOtpEvent(email: emailController.text));},
                      text: "إرسال رمز التحقق",
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
