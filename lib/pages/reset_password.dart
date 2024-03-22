import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/pages/login_page.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/bottom_button.dart';
import 'package:pill_app/widgets/page_header.dart';
import 'package:pill_app/widgets/simplfied_header_textfield.dart';

// ignore: must_be_immutable
class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({super.key});

  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

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
              if (state is AuthPasswordChangedState){
                context.showSuccessSnackBar(state.msg);
                context.push(LoginPage(canGoBack: false), false);
              }
            },
            builder: (context, state) {
              if (state is AuthLoadingState){
                return const Center(child: CircularProgressIndicator(color: midGreenColor,),);
              }else {
              return ListView(
                shrinkWrap: true,
                children: [
                  Image.asset(
                    "assets/images/reset_password.png",
                    height: 320,
                    width: 350,
                  ),
                  const Text(
                    "يرجى إدخال كلمة مرور جديدة",
                    style: TextStyle(
                        color: blackColor,
                        fontFamily: tajwalFont,
                        fontSize: 20,
                        fontWeight: FontWeight.w600),
                    textAlign: TextAlign.right,
                  ),
                  height16,
                  SimplfiedHeaderTextField(
                    controller: passwordController,
                    label: "كلمة المرور",
                  ),
                  height16,
                  SimplfiedHeaderTextField(
                    controller: rePasswordController,
                    label: "كلمة المرور مجدداً",
                  ),
                  height16,
                  BottomButton(
                      onTap: () {
                        context.read<AuthBloc>().add(ChangePasswordEvent(
                            password: passwordController.text,
                            rePassword: rePasswordController.text));
                      },
                      text: "تغيير الرمز",
                      fillColor: midGreenColor,
                      borderSide: BorderSide.none),
                  height16
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
