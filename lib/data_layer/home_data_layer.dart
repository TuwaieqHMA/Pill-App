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
          "https://s3-alpha-sig.figma.com/img/e5e0/c9e3/10cab5574ab7b4b2f88e19f8ace08576?Expires=1711929600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=Abvv9l23w5TiYgwejTzYud~j99ncIW53RkU3qKnkHGpRtuRnBUT2ENMpr5A6cJVcwAlhd5I-033eaAmRw5klYYNftwjuYIp7QWYe97~2q3A56g8WO-HVcrjuFIeH0ZZUXDQcs46oR4klkFErMXHD9~CHhGJCrCkz44ALxBV1pNLCPDk-FMfkyXjC14QDLSJBuquYMVbSjx9mpfNR6PPYXtvtZNsz3z9uCd1e98lFewr3mV~OOcPRVQy2IYjTQVGqB58qzHphJFZQiowaSFPdDWYgzNiN6Rnl6J9EpFj6gIvzVqqvBCEEt9UcJO9S2iS8FYPPJSqcKYo4n3rAvAwEcQ__");
  ChatUser bot = ChatUser(
      id: "2",
      profileImage:
          "https://s3-alpha-sig.figma.com/img/eeea/025c/739e87fafc30dfb63f52a1a19898bc45?Expires=1711929600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=ZBU3Map7sK4G4X0xxOXTqyerVtH2FN9EBaB5Q2B4NMJXvHClFJE2p~iu9-rhBB1eJBgVD00XcG71oGILkTXi3LVxNVPJuKN0XE8CQKWv3aOJ2NfNjfBGLgzqNIpc8EWgBLWI3VDcLYdGb3pr78UIOoFftnlQmtjINx131VvaliFet40wtqODcG1JDCRN0lETjoM2lKjdA47LkAGWifyAJNHX92RWUo28mHSbA83eBFNxl7bTCASn3vv1XD3r1TuU9OIjsnPesFrfIXn~VMypbkZ8D9eQEHYtI1Ptw9GhE9h333Bv-u28Jjx~GFSFa3xbJHFqUuPXT8jUipPXWkxTVg__");

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
