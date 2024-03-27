import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/pages/profile_page.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';

class HomePageHeader extends StatelessWidget {
  const HomePageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    final authBloc = context.read<AuthBloc>();
    authBloc.add(GetUserInfoEvent());
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
            bottom: context.getHeight() * 0.16,
            child: const Text(
              "مرحباً ",
              style: TextStyle(
                  color: whiteColor,
                  fontSize: 32,
                  fontFamily: tajwalFont,
                  fontWeight: FontWeight.w700),
            ),
          ),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return Positioned(
                right: context.getWidth() * 0.07,
                bottom: context.getHeight() * 0.11,
                child: Text(
                  locator.currentUser.name.split(" ")[0],
                  style: const TextStyle(
                      color: whiteColor,
                      fontSize: 32,
                      fontFamily: tajwalFont,
                      fontWeight: FontWeight.w700),
                ),
              );
            },
          ),
    
          
              Positioned(
              top: context.getHeight() * 0.03,
              right: context.getWidth() * 0.85,
              child: IconButton(
                onPressed: () {
                  context.push(ProfilePage(), true);
                },
                icon: const Icon(
                  Icons.person,
                  color: whiteColor,
                ),
              )),
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
