import 'package:flutter/material.dart';
import 'package:pill_app/utils/colors.dart';

class ContainerSaed3 extends StatelessWidget {
  const ContainerSaed3({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
       top: 135,
     left: 0,
      child: Container(
        height: 400,
        width: 400,
        decoration:   BoxDecoration(borderRadius: BorderRadius.circular(200),
          border: const Border(
            top: BorderSide(color: whiteColor,width: 1),
            bottom: BorderSide(color: whiteColor,width: 1),
            right: BorderSide(color: whiteColor,width: 1),
          ),
        ),
      ),
    );
  }
}

class ContainerSaed2 extends StatelessWidget {
  const ContainerSaed2({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 160,
     left: 24,
      child: Container(
        height: 350,
        width: 350,
        decoration:   BoxDecoration(borderRadius: BorderRadius.circular(175),
          border: const Border(
            top: BorderSide(color: whiteColor,width: 1),
            left: BorderSide(color: whiteColor,width: 1),
            bottom: BorderSide(color: whiteColor,width: 1),
          ),
        ),
      ),
    );
  }
}

class ContainerSaed1 extends StatelessWidget {
  const ContainerSaed1({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 180,
     left: 45,
      child: Container(
        height: 310,
        width: 310,
        decoration:   BoxDecoration(borderRadius: BorderRadius.circular(155),
          border: const Border(
            top: BorderSide(color: whiteColor,width: 1),
            right: BorderSide(color: whiteColor,width: 1),
            left: BorderSide(color: whiteColor,width: 1),
          ),
        ),
      ),
    );
  }
}

