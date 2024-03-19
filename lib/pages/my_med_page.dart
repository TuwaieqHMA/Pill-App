import 'package:flutter/material.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/utils/colors.dart';

class MyMedPage extends StatelessWidget {
  const MyMedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Column(
        children: [
          Container(
            width: context.getWidth(context)* 0.1,
            height: context.getWidth(context)* 0.1,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: glassGreyColor,

              ),child: const Icon(Icons.arrow_back, color: greyColor,),
          ),
          const Text("My Med"),
        ],
      )),
    );
  }
}
