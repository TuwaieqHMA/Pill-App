import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/pages/add_medication_page.dart';
import 'package:pill_app/pages/bottom_nav_bar/bloc/bottom_nav_bar_bloc.dart';
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
            return
                Scaffold(
                  body: serviceLocator.pages[serviceLocator.selectedPage],
                    floatingActionButton: FloatingActionButton(
                      backgroundColor: calmGreenColor,
        
           child: const Icon(Icons.add, color: whiteColor, size: 35,), 
           onPressed: () {context.push(AddMedicationPage(), true);}),
       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                    bottomNavigationBar: 
                    
                    // SizedBox(
                    //   width: context.getWidth() ,
                    //   height: context.getHeight()  * 0.14,
                    //   child: Stack(
                    //     fit: StackFit.expand,
                        
                    //     children: [
                           
                          Padding(
                            padding: const EdgeInsets.only(
                              bottom:5,
                              // top:40,
                              ),
                            child: 
                            BottomNavigationBar(
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
                        
                    //     Positioned(
                    //         bottom: 35,
                    //         left: context.getWidth()* 0.48,
                            
                    //         child: SizedBox(
                    //     height: context.getWidth() * 0.15,
                    //     width: context.getHeight() * 0.07,
                    //     child: FloatingActionButton(
                    //         backgroundColor: calmGreenColor,
                    //         child: const Icon(
                    //           Icons.add,
                    //           size: 30,
                    //           color: whiteColor,
                    //         ),
                    //         onPressed: () {
                    //           context.push(AddMedicationPage(), true);
                    //         }),
                    //   ),
                    //   ),
                      
                    //     ],
                    //   ),
                    // ),

                  
                    );
          },
        );
      }),
    );
  }
}
