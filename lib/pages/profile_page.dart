import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/bottom_button.dart';
import 'package:pill_app/widgets/page_header.dart';
import 'package:pill_app/widgets/simplfied_header_textfield.dart';

// ignore: must_be_immutable
class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    final authBloc = context.read<AuthBloc>();
    if (!isEditing) {
      nameController.text = locator.currentUser.name;
    ageController.text = locator.currentUser.age.toString();
    emailController.text = locator.currentUser.email;
    passwordController.text = locator.currentUser.password;
    }
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(context.getWidth(), context.getHeight() * .20),
          child: PageHeader(
              showLogo: false,
              bottomText: "حسابك الشخصي",
              height: context.getHeight() * .15,
              canGoBack: true)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is IsEditingProfileState){
              isEditing = state.isEditing;
            }else if (state is ShowUserInfoState){
              nameController.text = locator.currentUser.name;
    ageController.text = locator.currentUser.age.toString();
    emailController.text = locator.currentUser.email;
    passwordController.text = locator.currentUser.password;
            }else if (state is AuthErrorState){
              context.showErrorSnackBar(state.msg);
            }
          },
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return const Center(
                child: CircularProgressIndicator(
                  color: midGreenColor,
                ),
              );
            } else {
              return ListView(
                shrinkWrap: true,
                children: [
                  height16,
                  SizedBox(
                    height: 80,
                    width: 80,
                    child: Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          "assets/images/default_profile.jpg",
                        ),
                      ),
                    ),
                  ),
                  height32,
                  SimplfiedHeaderTextField(
                    label: "الاسم",
                    controller: nameController,
                    textDirection: TextDirection.rtl,
                    isEnabled: isEditing,
                    isReadOnly: !isEditing,
                  ),
                  height16,
                  SimplfiedHeaderTextField(
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    label: "العمر",
                    controller: ageController,
                    textDirection: TextDirection.rtl,
                    isEnabled: isEditing,
                    isReadOnly: !isEditing,
                  ),
                  height16,
                  SimplfiedHeaderTextField(
                    label: "الإيميل",
                    controller: emailController,
                    textDirection: TextDirection.rtl,
                    isEnabled: false,
                    isReadOnly: true,
                  ),
                  height16,
                  SimplfiedHeaderTextField(
                    isObscured: true,
                    label: "كلمة المرور",
                    controller: passwordController,
                    textDirection: TextDirection.rtl,
                    isEnabled: isEditing,
                    isReadOnly: !isEditing,
                  ),
                  height16,
                  (isEditing) ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      BottomButton(
                        onTap: () {
                          authBloc.add(DeactivateEditModeEvent());
                        },
                        minSize: Size(context.getWidth() * .2, 50),
                          text: "إلغاء",
                          fillColor: calmRedColor,
                          borderSide: BorderSide.none),
                      BottomButton(
                        onTap: () {
                          authBloc.add(EditProfileEvent(name: nameController.text, age: ageController.text, password: passwordController.text));
                        },
                        minSize: Size(context.getWidth() * .6, 50),
                          text: "حفظ",
                          fillColor: signatureGreencColor2,
                          borderSide: BorderSide.none),
                    ],
                  ) : BottomButton(
                        onTap: () {
                          authBloc.add(ActivateEditModeEvent());
                        },
                        minSize: Size(context.getWidth() * .6, 50),
                          text: "تعديل",
                          fillColor: signatureGreencColor2,
                          borderSide: BorderSide.none),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
