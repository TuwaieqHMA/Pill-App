import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pill_app/bloc/auth_bloc.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/pages/add_medication_page.dart';
import 'package:pill_app/bloc/bottom_nav_bar_bloc.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';

class BottomNavBarPage extends StatelessWidget {
  const BottomNavBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final serviceLocator = GetIt.I.get<HomeData>();

    return BlocProvider(
      create: (context) => BottomNavBarBloc(),
      child: Builder(builder: (context) {
        final bloc = context.read<BottomNavBarBloc>();
        final authBloc = context.read<AuthBloc>();
        authBloc.add(GetFcmTokenEvent());
        return BlocConsumer<BottomNavBarBloc, BottomNavBarState>(
          listener: (context, state) {
            FirebaseMessaging.onMessage.listen((payload) async {
              final notification = payload.notification;
              if (notification != null) {
                context.showTopSnackBar(
                    '${notification.title} : ${notification.body}');
              }
            });
          },
          builder: (context, state) {
            return Scaffold(
              body: serviceLocator.pages[serviceLocator.selectedPage],
              floatingActionButton: FloatingActionButton(
                  backgroundColor: calmGreenColor,
                  child: const Icon(
                    Icons.add,
                    color: whiteColor,
                    size: 35,
                  ),
                  onPressed: () {
                    context.push(AddMedicationPage(), true);
                  }),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerDocked,
              bottomNavigationBar: Padding(
                padding: const EdgeInsets.only(
                  bottom: 5,
                ),
                child: BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  currentIndex: serviceLocator.selectedPage,
                  elevation: 0,
                  onTap: (value) {
                    if (value != 2) {
                      bloc.add(ChangeNavEvent(index: value));
                    }
                  },
                  iconSize: 30,
                  showSelectedLabels: true,
                  showUnselectedLabels: true,
                  selectedItemColor: calmGreenColor,
                  selectedLabelStyle: const TextStyle(
                    color: calmGreenColor,
                    fontSize: 13,
                    fontFamily: poppinsFont,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    color: greyColor,
                    fontSize: 13,
                    fontFamily: poppinsFont,
                    fontWeight: FontWeight.w500,
                  ),
                  unselectedItemColor: greyColor,
                  items: [
                    BottomNavigationBarItem(
                        icon: serviceLocator.selectedPage == 0
                            ? const Icon(
                                Icons.dashboard,
                                color: calmGreenColor,
                              )
                            : const Icon(
                                Icons.dashboard,
                                color: greyColor,
                              ),
                        label: "الرئيسية"),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/icons/drugs_icon.svg",
                          colorFilter: serviceLocator.selectedPage == 1
                              ? const ColorFilter.mode(
                                  calmGreenColor, BlendMode.srcIn)
                              : const ColorFilter.mode(
                                  greyColor, BlendMode.srcIn)),
                      label: "أدويتي",
                    ),
                    const BottomNavigationBarItem(
                      icon: SizedBox.shrink(),
                      label: "",
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset("assets/icons/message.svg",
                          colorFilter: serviceLocator.selectedPage == 3
                              ? const ColorFilter.mode(
                                  calmGreenColor, BlendMode.srcIn)
                              : const ColorFilter.mode(
                                  greyColor, BlendMode.srcIn)),
                      label: "اسأل ساعد",
                    ),
                    BottomNavigationBarItem(
                        icon: SvgPicture.asset("assets/icons/qr_scan.svg",
                            colorFilter: serviceLocator.selectedPage == 4
                                ? const ColorFilter.mode(
                                    calmGreenColor, BlendMode.srcIn)
                                : const ColorFilter.mode(
                                    greyColor, BlendMode.srcIn)),
                        label: "مسح دواء"),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
