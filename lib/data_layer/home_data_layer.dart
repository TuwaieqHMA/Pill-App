import 'package:flutter/material.dart';
import 'package:pill_app/pages/add_medication_page.dart';
import 'package:pill_app/pages/ask_saed_page.dart';
import 'package:pill_app/pages/home_page.dart';
import 'package:pill_app/pages/my_med_page.dart';
import 'package:pill_app/pages/scan_page.dart';

class HomeData {
    List<Widget> pages = [
    const HomePage(),
    const MyMedPage(),
    const AddMedicationPage(),
    const AskSaedPage(),
    const ScanPage()
   ];

  int selectedPage = 0 ;
  
  String currentUserId = "";
}