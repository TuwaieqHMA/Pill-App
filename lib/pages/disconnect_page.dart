import 'package:flutter/material.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/spaces.dart';

class Disconnect extends StatelessWidget {
  const Disconnect({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("assets/images/offline-concept-illustration_114360-7063.jpg"),
              height16,
              Text(
                'No internet connection',
                style: TextStyle(fontSize: 30, color: deepGreenColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
