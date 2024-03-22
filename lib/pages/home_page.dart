import 'package:flutter/material.dart';
import 'package:pill_app/models/medication_model.dart';
import 'package:pill_app/services/database_service.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/home_page_header.dart';
import 'package:pill_app/widgets/medeicine_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HomePageHeader(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "أدويتي",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: poppinsFont,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ),
            height24,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children: [
                      MedicineCard(
                        fromHome: true,
                        medication: Medication( //Used as an example to test the UI
                            medicationName: "الزنك",
                            timeEat: const TimeOfDay(hour: 10, minute: 30),
                            beforeAfterEating: "بعد الأكل",
                            numberPill: 1,
                            userId: "33ddgrgt",
                            currentStatus: "لم يتم",
                            startDate: DateTime.now(),
                            endDate:
                                DateTime.now().add(const Duration(days: 20))),
                      ),
                      // MedicineCard(fromHome: true ,),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
