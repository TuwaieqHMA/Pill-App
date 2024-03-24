import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_app/bloc/medication_bloc.dart';
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
    final medicationBloc = context.read<MedicationBloc>();
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
              ? BlocConsumer<MedicationBloc, MedicationState>(
                  listener: (context, state) {
                    if (state is MedicationStatusUpdateState) {
                      context.showSuccessSnackBar("تم تحديث حالة الدواء بنجاح");
                    }
                  },
                  builder: (context, state) {
                    if (medication.currentStatus != "لم يتم" ||
                        state is MedicationStatusUpdateState) {
                      return Row(
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
                      );
                    } else if (medication.currentStatus == "لم يتم") {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          StatusCardButton(
                            color: redColor,
                            icon: Icons.cancel_outlined,
                            onPressed: () {
                              context.showStatusDialog(
                                  title: "تاكيد تخطي الدواء",
                                  dialogContent:
                                      "هل أنت متأكد من تخطي هذا الدواء ؟",
                                  action1: "تخطي",
                                  textStatus: "تم التخطي",
                                  medication: medication,
                                  onTap: () {
                                    medicationBloc.add(
                                        MedicationStatusUpdateEvent(
                                            medication: medication,
                                            newStatus: "تم التخطي"));
                                  });
                            },
                          ),
                          width8,
                          StatusCardButton(
                            color: goldColor,
                            icon: Icons.timer_outlined,
                            onPressed: () {
                              context.showStatusDialog(
                                title: "تاكيد إعادة جدولة الدواء",
                                dialogContent:
                                    "هل أنت متأكد من رغبتك في أعادة جدولة هذا الدواء ؟",
                                textStatus: "إعادة جدولة",
                                action1: "إعادة جدولة",
                                medication: medication,
                              );
                            },
                          ),
                          width8,
                          StatusCardButton(
                            color: calmGreenColor,
                            icon: Icons.done_outlined,
                            onPressed: () {

                              context.showStatusDialog(
                                  title: "تاكيد أخذ الدواء",
                                  dialogContent:
                                      " هل أنت متأكد من أخذ الجرعة ؟",
                                  action1: "تأكيد",
                                  textStatus: "تم أخذ الجرعة",
                                  medication: medication,
                                  onTap: () {
                                    medicationBloc.add(
                                        MedicationStatusUpdateEvent(
                                            medication: medication,
                                            newStatus: "تم أخذ الجرعة"));
                                  });
                            },
                          ),
                        ],
                      );
                    }
                    return const Text('أنا أحاول فيه');
                  },
                )

              // ================================================

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
                                  medication.currentStatus != "لم يتم"
                                      ? medication.currentStatus
                                      : medication.beforeAfterEating,
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
                      // ? // set morning or night
                      Text(
                        medication.timeEat!.period.name == "pm" ? "ص " : "م ",
                        style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: poppinsFont,
                            color: greyColor),
                      ),
                      Text(
                        "${medication.timeEat!.hourOfPeriod.toString()}:${medication.timeEat!.minute.toString()}",
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
