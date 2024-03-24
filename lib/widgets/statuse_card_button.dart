import 'package:flutter/material.dart';
import 'package:pill_app/utils/colors.dart';

class StatusCardButton extends StatelessWidget {
  StatusCardButton(
      {super.key,
      required this.color,
      required this.icon,
      required this.onPressed});
  Color color;
  IconData icon;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          minimumSize: const MaterialStatePropertyAll(Size(8, 10)),
          padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 8, vertical: 12)),
          maximumSize: const MaterialStatePropertyAll(Size(40, 40)),
          backgroundColor: MaterialStatePropertyAll(color),
          shape: const MaterialStatePropertyAll(RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            side: BorderSide.none,
          ))),
      onPressed: onPressed, 
      child: Icon(
        icon,
        color: whiteColor,
      ),
    );
  }
}
