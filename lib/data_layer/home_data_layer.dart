import 'dart:convert';

import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:pill_app/models/medication_model.dart';
import 'package:pill_app/models/saed_user.dart';
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
bool isInitializeSupabase=false;
bool isInitializeFierbase=false;


  String currentUserId = "";
  String currentUserEmail = "";
  List<Medication> userMedicationList = [];
  SaedUser currentUser = SaedUser(name: "بك", email: "someone@hotmail.com", password: "123456", age: 24);

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

  Future<TimeOfDay?> getTimeOfDay(BuildContext context, TimeOfDay? initialTime) async {
    return await showTimePicker(
        cancelText: "الرجوع",
        confirmText: "إختيار",
        minuteLabelText: "دقيقة",
        hourLabelText: "ساعة",
        helpText: "إختيار الوقت",
        context: context,
        initialTime: initialTime ?? TimeOfDay(
            hour: DateTime.now().hour, minute: DateTime.now().minute));
  }
  final box = GetStorage();
  List<ChatMessage> chatLog = [];
  List<ChatUser> typingList = [];

  ChatUser user = ChatUser(
      id: "1",
      profileImage:
          "assets/images/saed_logo.png");
  ChatUser bot = ChatUser(
      id: "2",
      profileImage:
          "assets/images/chat_user.png");

  HomeData() {
    loadChatLog();
  }
  void saveChatLog() async{
    final List<Map<String, dynamic>> jsonedList = [];

    for (var chat in chatLog) {
      jsonedList.add(chat.toJson());
    }
    await box.write("chatLog", json.encode(jsonedList));
  }

  void loadChatLog() async{
    final List<ChatMessage> newChatLog = [];
    final data = await box.read("chatLog");
    print(data);
    if(data != null){
      final messageList = json.decode(data);
      for (var chat in messageList) {
        newChatLog.add(ChatMessage.fromJson(chat));
      }
      chatLog = newChatLog;
    }else {
      chatLog = [];
    }
  }
 

  TimeOfDay stringToTimeOfDay(String tod) {
  final format = DateFormat.Hm();
  return TimeOfDay.fromDateTime(format.parse(tod));
}
}
