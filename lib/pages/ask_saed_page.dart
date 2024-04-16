import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/pages/chat_page.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/widgets/container_saed.dart';
import 'package:pill_app/widgets/texet_saed.dart';

class AskSaedPage extends StatelessWidget {
  const AskSaedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Container(
          width: screenWidth,
          height: screenHeight,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment(0.0, 0.0),
              colors: [deepGreenColor, signatureGreenColor],
              tileMode: TileMode.clamp,
            ),
          ),
          child: Stack(
            children: [
              const Center(child: ContainerSaed1()),
              const Center(child: ContainerSaed3()),
              const Center(child: ContainerSaed2()),
              Positioned(
                top: screenHeight * 0.18,
                right: screenWidth * 0.13,
                child: Container(
                  height: screenHeight * 0.06,
                  width: screenWidth * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white,
                  ),
                  child: Center(
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return Text(
                          'مرحبا ${locator.currentUser.name.split(" ")[0]}',
                          style: TextStyle(
                            fontSize: screenHeight * 0.024,
                            fontWeight: FontWeight.w800,
                            fontFamily: poppinsFont,
                            color: Colors.transparent.withOpacity(0.7),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: context.getWidth(),
                  height: context.getHeight() * .31,
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/saed_logo.png',
                        height: screenHeight * 0.24,
                        width: screenHeight * 0.24,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/hand.png',
                            height: screenHeight * 0.07,
                            width: screenHeight * 0.07,
                          ),
                          const TextSaed(
                            text: 'ساعد',
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.25,
                right: screenWidth * 0.40,
                child: TextSaed(
                  text: 'أنا ساعد',
                  size: screenHeight * 0.030,
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.16,
                right: screenWidth * 0.24,
                child: TextSaed(
                  text: 'كيف يمكنني مساعدتك؟',
                  size: screenHeight * 0.030,
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.075,
                right: screenWidth * 0.39,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()),
                    );
                  },
                  child: Image.asset(
                    'assets/images/chat_button.png',
                    height: screenHeight * 0.05,
                    width: screenHeight * 0.05,
                  ),
                ),
              ),
              Positioned(
                bottom: screenHeight * 0.040,
                right: screenWidth * 0.42,
                child: TextSaed(
                  text: 'انقر للتحدث',
                  size: screenHeight * 0.016,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
