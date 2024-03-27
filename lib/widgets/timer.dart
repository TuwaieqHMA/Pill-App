import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';

class TimerBasic extends StatelessWidget {
  final CountDownTimerFormat format;
  final bool inverted;
  final int hour;
  final int minute;
  Function()? onEnd;

  TimerBasic({
    required this.format,
    required this.hour,
    required this.minute,
    this.inverted = false,
    this.onEnd,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TimerCountdown(
      enableDescriptions: false,
      format: format,
      endTime: DateTime.now().add(
        Duration(
          hours: hour,
          minutes: minute,
        ),
      ),
      onEnd: onEnd,
      timeTextStyle: TextStyle(
        color: (inverted) ? purple : CupertinoColors.white,
        fontWeight: FontWeight.w300,
        fontSize: 14,
        fontFeatures: const <FontFeature>[
        fontFeatures: const <FontFeature>[
          FontFeature.tabularFigures(),
        ],
      ),
      colonsTextStyle: TextStyle(
        color: (inverted) ? purple : CupertinoColors.white,
        fontWeight: FontWeight.w300,
        fontSize: 12,
        fontFeatures: const <FontFeature>[
        fontFeatures: const <FontFeature>[
          FontFeature.tabularFigures(),
        ],
      ),
    );
  }
}

const Color purple = Color.fromARGB(255, 63, 45, 149);
