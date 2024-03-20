import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
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
class SignupPage extends StatelessWidget {
  SignupPage({super.key, required this.canGoBack});

  final bool canGoBack;
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<AuthBloc>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size(context.getWidth(), 110),
          child: PageHeader(
            canGoBack: canGoBack,
            showLogo: false,
            height: 110,
            bottomText: 'إنشاء الحساب',
          )),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState){
            context.showErrorSnackBar(state.msg);
          }else if(state is AuthSucessState){
            context.showSuccessSnackBar(state.msg);
            context.push(LoginPage(canGoBack: false,), false);
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
                  textDirection: TextDirection.rtl,
                  controller: nameController,
                  label: 'الاسم',
                ),
                height24,
                SimplfiedHeaderTextField(
                  maxLength: 3,
                  textDirection: TextDirection.rtl,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  controller: ageController,
                  label: 'العمر',
                ),
                height24,
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
                height32,
                Align(
                    alignment: Alignment.center,
                    child: BottomButton(
                      onTap: (){
                        bloc.add(SignUpEvent(age: ageController.text, email: emailController.text, password: passwordController.text, name: nameController.text));
                      },
                      text: "إنشاء الحساب",
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
                      text: "لديك حساب مسبقاً؟ ",
                      style: TextStyle(
                          color: blackColor,
                          fontFamily: poppinsFont,
                          fontSize: 20,
                          fontWeight: FontWeight.w500),
                    ),
                    TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          context.push(LoginPage(canGoBack: false), false);
                        },
                      text: "تسجيل الدخول",
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
