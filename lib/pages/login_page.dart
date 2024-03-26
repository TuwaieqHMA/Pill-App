import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/pages/bottom_nav_bar_page.dart';
import 'package:pill_app/pages/email_verify_page.dart';
import 'package:pill_app/pages/signup_page.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/bottom_button.dart';
import 'package:pill_app/widgets/page_header.dart';
import 'package:pill_app/widgets/simplfied_header_textfield.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key, required this.canGoBack});

  final bool canGoBack;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size(context.getWidth(), 370),
          child: PageHeader(
            canGoBack: canGoBack,
            height: 370,
            bottomText: 'تسجيل الدخول',
          )),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState){
            context.showErrorSnackBar(state.msg);
          }else if(state is AuthSucessState){
            context.showSuccessSnackBar(state.msg);
            context.push(const BottomNavBarPage(), false);
          }else if(state is AuthSignoutState){
            context.showSuccessSnackBar(state.msg);
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState){
            return const Center(child: CircularProgressIndicator(color: midGreenColor,),);
          }else {
          return Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 28),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SimplfiedHeaderTextField(
                  controller: emailController,
                  label: 'الإيميل',
                ),
                height24,
                SimplfiedHeaderTextField(
                  isObscured: true,
                  controller: passwordController,
                  label: 'كلمة المرور',
                ),
                TextButton(
                    style: const ButtonStyle(
                        padding: MaterialStatePropertyAll(EdgeInsets.zero),
                        overlayColor: MaterialStatePropertyAll(glassGreyColor)),
                    onPressed: () {
                      context.push(EmailVerifcationPage(), true);
                    },
                    child: const Text(
                      "هل نسيت كلمة المرور؟",
                      style: TextStyle(
                          color: deepGreenColor,
                          fontFamily: tajwalFont,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                height16,
                Align(
                    alignment: Alignment.center,
                    child: BottomButton(
                      onTap: (){
                        bloc.add(LoginEvent(email: emailController.text, password: passwordController.text));
                      },
                      text: "تسجيل الدخول",
                      fillColor: midGreenColor,
                      borderSide: BorderSide.none,
                      minSize: const Size(300, 60),
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
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push(SignupPage(canGoBack: false), false);
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
          );
          }
        },
      ),
    );
  }
}
