import 'package:flutter/material.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/medeicine_card.dart';

class MyMedPage extends StatelessWidget {
  const MyMedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              height32,
              const Text(
                "أدويتي",
                style: TextStyle(
                  fontSize: 33,
                  fontWeight: FontWeight.w800,
                  fontFamily: poppinsFont,
                  color: blackColor,
                ),
              ),
              height24,
              Expanded(
                child: ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.vertical,
                    children:  const [
                      MedicineCart(),                     
                      MedicineCart(),
                      MedicineCart(),
                      MedicineCart(),
                      MedicineCart(),
                      MedicineCart(),
                      MedicineCart(),
                      MedicineCart(),
                      MedicineCart(),
                      MedicineCart(),
                    ]),
              ),
            ],
          ),
        ),
      
      ),
    );
  }
}
