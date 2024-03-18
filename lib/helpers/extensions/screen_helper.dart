import 'package:flutter/material.dart';
import 'package:pill_app/utils/colors.dart';

extension Screen on BuildContext {
  double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  push(BuildContext context, Widget view, bool isPushOnly) {
    return Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (route) => view), (Route<dynamic> route) => isPushOnly);
  }

  showSuccessSnackBar(BuildContext context, String msg,) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
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

  showErrorSnackBar(BuildContext context, String msg,) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      margin: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
      behavior: SnackBarBehavior.floating,
      content: Text(
        msg,
        style: const TextStyle(
          color: whiteColor,
        ),
      ),
      backgroundColor: redColor,
    ));
  }
}