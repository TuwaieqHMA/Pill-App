import 'package:flutter/material.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.getWidth(),
      height: context.getHeight() * 0.29,
      child: Stack(
        children: [
          Container(
            width: context.getWidth(),
            height: context.getHeight() * 0.2,
            decoration: const BoxDecoration(
                color: calmGreenColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
          ),
          Positioned(
            right: context.getWidth() * 0.03,
            bottom: context.getHeight() * 0.14,
            child: const Text(
              "مرحباً ",
              style: TextStyle(
                  color: whiteColor,
                  fontSize: 32,
                  fontFamily: tajwalFont,
                  fontWeight: FontWeight.w700),
            ),
          ),
          Positioned(
            right: context.getWidth() * 0.07,
            bottom: context.getHeight() * 0.09,
            child: const Text(
              "سارة ",
              style: TextStyle(
                  color: whiteColor,
                  fontSize: 32,
                  fontFamily: tajwalFont,
                  fontWeight: FontWeight.w700),
            ),
          ),
          //  log out 
          // Positioned(
          //   top: context.getHeight() * 0.04,
          //   right: context.getWidth() * 0.07,
          //   child: InkWell(
          //     onTap: () {
          //       // TODO log out
          //     },
          //     child: const Row(
          //       children: [
          //         Text(
          //           "تسجيل الخروج",
          //           style: TextStyle(
          //               color: whiteColor,
          //               fontSize: 13,
          //               fontFamily: poppinsFont,
          //               fontWeight: FontWeight.w500),
          //         ),
          //         width8,
          //         Icon(Icons.login_outlined, color: whiteColor),
          //       ],
          //     ),
          //   ),
          // ),
          
          Positioned(
            top: context.getHeight() * 0.04,
            left: context.getWidth() * 0.07,
            child: InkWell(
              onTap: () {
                // TODO change language
              },
              child: Container(
                alignment: Alignment.center,
                width: context.getWidth() * 0.06,
                height: context.getWidth() * 0.06,
                decoration: BoxDecoration(
                  border: Border.all(color: goldColor, width: 2),
                ),
                child: const Text(
                  "E",
                  style: TextStyle(
                      color: whiteColor,
                      fontSize: 13,
                      fontFamily: poppinsFont,
                      fontWeight: FontWeight.w500),
                ),
              ),
            ),
          ),
          Positioned(
            top: context.getWidth() * 0.19,
            left: context.getWidth() * 0.06,
            child: Container(
              width: context.getWidth() * 0.28,
              height: context.getHeight() * 0.17,
              decoration: const BoxDecoration(
                  color: whiteColor,
                  image: DecorationImage(
                      image: AssetImage(
                        "assets/images/home_logo1.png",
                      ),
                      fit: BoxFit.contain),
                  borderRadius: BorderRadius.all(Radius.circular(35))),
            ),
          )
        ],
      ),
    );
  }
}
