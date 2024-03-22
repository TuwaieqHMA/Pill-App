
import 'package:flutter/material.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/models/medication_model.dart';
import 'package:pill_app/pages/edit_medication_page.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/statuse_card_button.dart';

class MedicineCard extends StatelessWidget {
  const MedicineCard(
      {super.key, this.fromHome = false, required this.medication});
  final Medication medication;

  final bool fromHome;

  @override
  Widget build(BuildContext context) {
    final Color color;
    switch (medication.currentStatus) {
      case "تم أخذ الجرعة":
        color = calmGreenColor;
        break;
      case "تم التخطي":
        color = calmRedColor;
        break;
      case "أعادة جدولة":
        color = goldColor;
        break;

      default:
        color = Colors.transparent;
    }

    print(medication.medicationName);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      width: context.getWidth() * 0.8,
      height: context.getWidth() * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: glassGreyColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          fromHome
              ? medication.currentStatus != "لم يتم"
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        width16,
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                medication.currentStatus,
                                // " تم أخذ الدواء ",
                                style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: poppinsFont,
                                    color: greyColor1),
                              ),
                            ]),
                        width8,
                        Container(
                          padding: const EdgeInsets.only(top: 15),
                          width: context.getWidth() * 0.02,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: color),
                          child: const Text(""),
                        ),
                      ],
                    )
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StatusCardButton(
                          color: redColor,
                          icon: Icons.cancel_outlined,
                          onPressed: () {
                            context.showStatusDialog(
                              "تاكيد تخطي الدواء", 
                              "هل أنت متأكد من تخطي هذا الدواء ؟", 
                              "تخطي",                              
                              "تم التخطي",
                              medication, 
                            );

                          },
                        ),
                        width8,
                        StatusCardButton(
                          color: goldColor,
                          icon: Icons.timer_outlined,
                          onPressed: () {
                             context.showStatusDialog(
                              "تاكيد إعادة جدولة الدواء", 
                              "هل أنت متأكد من رغبتك في أعادة جدولة هذا الدواء ؟", 
                              "إعادة جدولة",                              
                              "إعادة جدولة",
                              medication, 
                            );
                          },
                        ),
                        width8,
                        StatusCardButton(
                          color: calmGreenColor,
                          icon: Icons.done_outlined,
                          onPressed: () {
                            // TODO update status
                            //! update status convert to bloc
                          
                          context.showStatusDialog("تاكيد أخذ الدواء", " هل أنت متأكد من أخذ الجرعة ؟",  "تأكيد", "تم أخذ الجرعة", medication);
                          },
                        ),
                      ],
                    )
              : InkWell(
                  onTap: () {
                    context.push(
                        EditMedicationPage(
                          medication: medication,
                        ),
                        true);
                  },
                  child: Image.asset("assets/icons/edit.png")),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    medication.medicationName,

                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: poppinsFont,
                        color: blackColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      !fromHome
                          ? Row(
                              children: [
                                Text(
                                  medication.currentStatus != "لم يتم" ?
                                  medication.currentStatus :
                                  medication.beforeAfterEating,
                                  style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: poppinsFont,
                                      color: greyColor),
                                ),
                                width8,
                                Container(
                                  width: context.getWidth() * 0.008,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: greyColor),
                                  child: const Text(""),
                                )
                              ],
                            )
                          : const Text(""),
                      width8,
                      12 < 12
                          ? // set morning or night
                          const Text(
                              " ص ", //! will be change
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: poppinsFont,
                                  color: greyColor),
                            )
                          : const Text(
                              "م ", //! will be change
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: poppinsFont,
                                  color: greyColor),
                            ),
                      Text(
                        "${medication.timeEat.hour.toString()}:${medication.timeEat.minute.toString()}",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: poppinsFont,
                            color: greyColor),
                      ),
                    ],
                  ),
                ],
              ),
              width32,
              Image.asset("assets/icons/pills_disabled.png"),
            ],
          ),
        ],
      ),
    );
  }
}
