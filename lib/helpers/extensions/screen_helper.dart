import 'package:flutter/material.dart';
import 'package:pill_app/models/medication_model.dart';
import 'package:pill_app/pages/edit_medication_page.dart';
import 'package:pill_app/services/database_service.dart';
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

  showStatusDialog(
    String title,
    String dialogContent,
    String action1,
    String textStatus,
    Medication medication,
  ) {
    showDialog(
      context: this,
      builder: (context) => AlertDialog(
        title: Text(title, textAlign: TextAlign.right, style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: calmGreenColor),),
        content: Text(
          dialogContent,
          textAlign: TextAlign.right,
          style: const TextStyle(fontSize: 16, color: blackColor),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child:  const Text(
                "إلغاء",
                textAlign: TextAlign.left,
                style: TextStyle(color: greyColor, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              if(textStatus == "إعادة جدولة")
              {
                push(EditMedicationPage(medication: medication, isChangingTime: true,),  true);
              }else{
              DBService().updateCurrentState(
                  medication: medication, text: textStatus);
              Navigator.pop(context);}
            },
            child: Container(
              padding: const EdgeInsets.all(14),
              child:  Text(
                action1,
                textAlign: TextAlign.right,
                style: const TextStyle(color: calmGreenColor, fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
