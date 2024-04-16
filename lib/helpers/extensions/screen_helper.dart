import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_app/bloc/medication_bloc.dart';
import 'package:pill_app/models/medication_model.dart';
import 'package:pill_app/pages/edit_medication_page.dart';
import 'package:pill_app/utils/colors.dart';

extension Screen on BuildContext {
  double getWidth() {
    return MediaQuery.of(this).size.width;
  }

  double getHeight() {
    return MediaQuery.of(this).size.height;
  }

  push(Widget view, bool isPushOnly) {
    return Navigator.pushAndRemoveUntil(
        this,
        MaterialPageRoute(builder: (route) => view),
        (Route<dynamic> route) => isPushOnly);
  }

  pop() {
    return Navigator.pop(this);
  }

  showSuccessSnackBar(
    String msg,
  ) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: const TextStyle(
          color: whiteColor,
        ),
      ),
      backgroundColor: signatureGreencColor2,
    ));
  }

  showErrorSnackBar(
    String msg,
  ) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: const TextStyle(
          color: whiteColor,
        ),
      ),
      backgroundColor: calmRedColor,
    ));
  }

  showTopSnackBar(
    String msg,
  ) {
    ScaffoldMessenger.of(this).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: EdgeInsets.only(left: 16, right: 16, bottom: getHeight() - 200),
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: const TextStyle(
          color: whiteColor,
        ),
      ),
      backgroundColor: deepGreenColor,
    ));
  }

  showStatusDialog({
    required String title,
    required String dialogContent,
    required String action1,
    required String textStatus,
    required Medication medication,
    final onTap,
  }) {
    showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(
          title,
          textAlign: TextAlign.right,
          style: const TextStyle(
              fontSize: 25, fontWeight: FontWeight.w600, color: calmGreenColor),
        ),
        content: Text(
          dialogContent,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 16, color: blackColor),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: const Text(
                "إلغاء",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: greyColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if (textStatus == "إعادة جدولة") {
                pop();
                push(
                    EditMedicationPage(
                      medication: medication,
                      isChangingTime: true,
                    ),
                    true);
                context.read<MedicationBloc>().add(MedicationStatusUpdateEvent( medication: medication, newStatus: textStatus));
              } else {

                context.read<MedicationBloc>().add(MedicationStatusUpdateEvent(
                    medication: medication, newStatus: textStatus));
                context.pop();
              }
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child: Text(
                action1,
                textAlign: TextAlign.right,
                style: const TextStyle(
                    color: calmGreenColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
