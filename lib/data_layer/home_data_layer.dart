import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pill_app/models/medication_model.dart';
import 'package:pill_app/pages/add_medication_page.dart';
import 'package:pill_app/pages/ask_saed_page.dart';
import 'package:pill_app/pages/home_page.dart';
import 'package:pill_app/pages/my_med_page.dart';
import 'package:pill_app/pages/scan_page.dart';
import 'package:pill_app/utils/colors.dart';

class HomeData {
  List<Widget> pages = [
    const HomePage(),
    const MyMedPage(),
    AddMedicationPage(),
    const AskSaedPage(),
    const ScanPage()
  ];

  int selectedPage = 0;

  String currentUserId = "";
  String currentUserEmail = "";
  List<Medication> userMedicationList = [];

  TimePickerThemeData timePickerTheme() {
    return const TimePickerThemeData(
      backgroundColor: bgGreenColor,
      cancelButtonStyle: ButtonStyle(
          foregroundColor: MaterialStatePropertyAll(whiteColor),
          backgroundColor: MaterialStatePropertyAll(calmRedColor)),
      confirmButtonStyle: ButtonStyle(
        foregroundColor: MaterialStatePropertyAll(whiteColor),
        backgroundColor: MaterialStatePropertyAll(calmGreenColor),
      ),
      dayPeriodTextColor: whiteColor,
      dayPeriodColor: calmGreenColor,
      dayPeriodBorderSide: BorderSide(
        color: calmGreenColor,
      ),
      dialBackgroundColor: calmGreenColor,
      dialHandColor: signatureGreenColor,
      dialTextColor: whiteColor,
      entryModeIconColor: whiteColor,
      helpTextStyle: TextStyle(color: whiteColor),
      hourMinuteColor: calmGreenColor,
      hourMinuteTextColor: whiteColor,
    );
  }

  Future<TimeOfDay?> getTimeOfDay(BuildContext context) async {
    return await showTimePicker(
        cancelText: "الرجوع",
        confirmText: "إختيار",
        minuteLabelText: "دقيقة",
        hourLabelText: "ساعة",
        helpText: "إختيار الوقت",
        context: context,
        initialTime: TimeOfDay(
            hour: DateTime.now().hour, minute: DateTime.now().minute));
  }

  TimeOfDay stringToTimeOfDay(String tod) {
  final format = DateFormat.Hm();
  return TimeOfDay.fromDateTime(format.parse(tod));
}
}
