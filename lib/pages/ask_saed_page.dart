import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/pages/test_pages/chat_page.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/widgets/container_saed.dart';
import 'package:pill_app/widgets/texet_saed.dart';

class AskSaedPage extends StatelessWidget {
  const AskSaedPage({super.key});
  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        width: context.getWidth() * 100,
        height: context.getWidth() * 50,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment(0.0, 0.0),
            colors: [deepGreenColor, signatureGreenColor],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Stack(children: [
          const ContainerSaed1(),
          const ContainerSaed3(),
          const ContainerSaed2(),
          Positioned(
              top: 155,
              right: 65,
              child: Container(
                height: 45,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.white,
                ),
                child: Center(
                  child: BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return Text(
                        'مرحبا ${locator.currentUser.name.split(" ")[0]}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          fontFamily: poppinsFont,
                          color: Colors.transparent.withOpacity(0.7),
                        ),
                      );
                    },
                  ),
                ),
              )),
          Positioned(
              top: 222,
              left: 110,
              child: Image.asset(
                'assets/images/saed_logo.png',
                height: 180,
                width: 180,
              )),
          Positioned(
              bottom: 288,
              right: 215,
              child: Image.asset(
                'assets/images/hand.png',
                height: 60,
                width: 60,
              )),
          const Positioned(
              bottom: 288,
              right: 138,
              child: TextSaed(
                text: 'ساعد',
                size: 38,
              )),
          const Positioned(
              bottom: 190,
              right: 175,
              child: TextSaed(
                text: 'أنا ساعد',
                size: 24,
              )),
          const Positioned(
              bottom: 150,
              right: 100,
              child: TextSaed(
                text: 'كيف يمكنني مساعدتك؟',
                size: 24,
              )),
          Positioned(
              bottom: 70,
              right: 160,
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatPage()),
                    );
                  },
                  child: Image.asset(
                    'assets/images/chat_button.png',
                    height: 50,
                    width: 50,
                  ))),
          const Positioned(
              bottom: 33,
              right: 172,
              child: TextSaed(
                text: 'انقر للتحدث',
                size: 16,
              )),
        ]),
      ),
    );
  }
}
