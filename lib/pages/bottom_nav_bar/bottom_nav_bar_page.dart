import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/pages/add_medication_page.dart';
import 'package:pill_app/pages/ask_saed_page.dart';
import 'package:pill_app/pages/bottom_nav_bar/bloc/bottom_nav_bar_bloc.dart';
import 'package:pill_app/pages/home_page.dart';
import 'package:pill_app/pages/my_med_page.dart';
import 'package:pill_app/pages/scan_page.dart';
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
        return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
          builder: (context, state) {
            return DefaultTabController(
              length: 5,
              child: Scaffold(
                  body: const TabBarView(children: [
                    HomePage(),
                    MyMedPage(),
                    AddMedicationPage(),
                    AskSaedPage(),
                    ScanPage()
                  ]),
                  bottomNavigationBar: TabBar(
                    labelPadding: const EdgeInsets.symmetric(horizontal:4,),
                      onTap: (value) {
                        bloc.add(ChangeNavEvent(index: value));
                      },
                      indicator: const UnderlineTabIndicator(
                          borderSide: BorderSide.none),
                      labelStyle: const TextStyle(
                          color: calmGreenColor,
                          fontSize: 13,
                          fontFamily: poppinsFont,
                          fontWeight: FontWeight.w500),
                      unselectedLabelStyle: const TextStyle(
                          color: greyColor,
                          fontSize: 13,
                          fontFamily: poppinsFont,
                          fontWeight: FontWeight.w500),
                      tabs: [
                        Tab(
                            icon: serviceLocator.selectedPage == 0
                                ? const Icon(
                                    Icons.dashboard,
                                    color: calmGreenColor,
                                  )
                                : const Icon(
                                    Icons.dashboard,
                                    color: greyColor,
                                  ),
                            text: "الرئيسية"),
                        Tab(
                            icon: SvgPicture.asset(
                                "assets/icons/drugs_icon.svg",
                                colorFilter: serviceLocator.selectedPage == 1
                                    ? const ColorFilter.mode(
                                        calmGreenColor, BlendMode.srcIn)
                                    : const ColorFilter.mode(
                                        greyColor, BlendMode.srcIn)),
                            text: "أدويتي"),

                        const Tab(child: Text("")),
                        Tab(
                            icon: SvgPicture.asset("assets/icons/message.svg",
                                colorFilter: serviceLocator.selectedPage == 3
                                    ? const ColorFilter.mode(
                                        calmGreenColor, BlendMode.srcIn)
                                    : const ColorFilter.mode(
                                        greyColor,
                                        BlendMode
                                            .srcIn)),
                            text: "اسأل ساعد"),
                        Tab(
                            icon: SvgPicture.asset("assets/icons/qr_scan.svg",
                                colorFilter: serviceLocator.selectedPage == 4
                                    ? const ColorFilter.mode(
                                        calmGreenColor, BlendMode.srcIn)
                                    : const ColorFilter.mode(
                                        greyColor, BlendMode.srcIn)),
                            text: "مسح دواء"),
                      ]),
                  floatingActionButton: Container(
                    decoration: const BoxDecoration(

                    // boxShadow: [
                    // BoxShadow(
                    //   color: calmGreenColor,
                    //   offset: Offset.zero,
                    //   blurRadius: 100.0
                    //  //  spreadRadius: 0.091,
                    // ),]
                    ),
                    height: context.getWidth(context) * 0.13,
                    width: context.getHeight(context) * 0.13,
                    child: FittedBox(
                      child: FloatingActionButton(
                          backgroundColor: calmGreenColor,
                          child: const Icon(
                            Icons.add,
                            size: 30,
                            color: whiteColor,
                          ),
                          onPressed: () {
                            context.push(context, AddMedicationPage(), false);
                            // TODO
                          }),
                    ),
                  ),
                  floatingActionButtonLocation: FloatingActionButtonLocation
                      .miniCenterDocked //centerDocked,
                  ),
            );
          },
        );
      }),
    );
  }
}
