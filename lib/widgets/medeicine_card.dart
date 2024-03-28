import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pill_app/bloc/medication_bloc.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/models/medication_model.dart';
import 'package:pill_app/pages/edit_medication_page.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/statuse_card_button.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:pill_app/widgets/timer.dart';

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
    return Column(
      children: [
        Container(
            margin: const EdgeInsets.only(top: 8),
            height: context.getHeight() * 0.03,
            width: context.getWidth() * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: calmGreenColor,
            ),
            child: Center(
                child: TimerBasic(
              format: CountDownTimerFormat.hoursMinutesSeconds,
              hour: (medication.timeEat!.hour - TimeOfDay.now().hour),
              minute: (medication.timeEat!.minute - TimeOfDay.now().minute),
              onEnd: () {
                if (medication.currentStatus != "تم التخطي") {
                  medicationBloc.add(
                    MedicationStatusUpdateEvent(
                      medication: medication,
                      newStatus: "تم التخطي",
                    ),
                  );
                }
              },
            ))),
        Container(
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
                          context.showSuccessSnackBar(
                              "تم تحديث حالة الدواء بنجاح");
                        }
                      },
                      builder: (context, state) {
                        if (medication.currentStatus != "لم يتم" ||
                            state is MedicationStatusUpdateState) {
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      medication.currentStatus,
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
                              GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return Dialog(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                        ),
                                        elevation: 5,
                                        child: Container(
                                          padding: EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "تأكيد العملية",
                                                style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              height16,
                                              Text(
                                                "يرجى تأكيد الإجراء الذي ترغب في القيام به",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              height16,
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  StatusCardButton(
                                                    color: redColor,
                                                    icon: Icons.cancel_outlined,
                                                    onPressed: () {
                                                      context.showStatusDialog(
                                                        title:
                                                            "تأكيد تخطي الدواء",
                                                        dialogContent:
                                                            "هل أنت متأكد من تخطي هذا الدواء ؟",
                                                        action1: "تخطي",
                                                        textStatus: "تم التخطي",
                                                        medication: medication,
                                                        onTap: () {
                                                          medicationBloc.add(
                                                            MedicationStatusUpdateEvent(
                                                              medication:
                                                                  medication,
                                                              newStatus:
                                                                  "تم التخطي",
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                  width8,
                                                  StatusCardButton(
                                                    color: goldColor,
                                                    icon: Icons.timer_outlined,
                                                    onPressed: () {
                                                      context.showStatusDialog(
                                                        title:
                                                            "تأكيد إعادة جدولة الدواء",
                                                        dialogContent:
                                                            "هل أنت متأكد من رغبتك في أعادة جدولة هذا الدواء ؟",
                                                        textStatus:
                                                            "إعادة جدولة",
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
                                                      Navigator.pop(context);
                                                      context.showStatusDialog(
                                                        title:
                                                            "تأكيد أخذ الدواء",
                                                        dialogContent:
                                                            " هل أنت متأكد من أخذ الجرعة ؟",
                                                        action1: "تأكيد",
                                                        textStatus:
                                                            "تم أخذ الجرعة",
                                                        medication: medication,
                                                        onTap: () {
                                                          medicationBloc.add(
                                                            MedicationStatusUpdateEvent(
                                                              medication:
                                                                  medication,
                                                              newStatus:
                                                                  "تم أخذ الجرعة",
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Icon(Icons.menu),
                              ),
                            ],
                          );
                        }
                        return const Text('أنا أحاول فيه');
                      },
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
                      Container(
                        constraints: BoxConstraints(maxWidth: 130),
                        child: Text(
                          medication.medicationName,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            fontFamily: poppinsFont,
                            color: blackColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
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
                                          shape: BoxShape.circle,
                                          color: greyColor),
                                      child: const Text(""),
                                    )
                                  ],
                                )
                              : const Text(""),
                          width8,
                          // ? // set morning or night
                          Text(
                            medication.timeEat!.period.name == "pm"
                                ? "م "
                                : "ص ",
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
                  width8,
                  Image.asset("assets/icons/pills_disabled.png"),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
