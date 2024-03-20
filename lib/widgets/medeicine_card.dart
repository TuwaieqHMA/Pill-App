import 'package:flutter/material.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';

class MedicineCart extends StatelessWidget {
  const MedicineCart({super.key, 
  // this.medicine, 
  this.formeHome = false});
  // final model_name? medicine; // ! object from Model
  
  final bool formeHome;

  @override
  Widget build(BuildContext context) {
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
          InkWell(
            onTap: () {
              // context.push(EditMedicinePage(), true); //! to be sure from screen page
            },
            child: formeHome
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      width16,
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            " تم أخذ الدواء ",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                fontFamily: poppinsFont,
                                color: greyColor1),
                          ),
                          Row(
                            children: [
                              Text(
                                " ص", //! will be change
                                style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: poppinsFont,
                                    color: greyColor1),
                              ),
                              Text(
                                " 9:00 ",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: poppinsFont,
                                    color: greyColor1),
                              ),
                            ],
                          ),
                        ],
                      ),
                      width8,
                      Container(
                        padding: const EdgeInsets.only(top: 15),
                        width: context.getWidth() * 0.02,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: goldColor),
                        child: const Text(""),
                      ),
                    ],
                  )
                : Image.asset("assets/icons/edit.png"),
          ),
          Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "الزنك", //! will be change
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        fontFamily: poppinsFont,
                        color: blackColor),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      !formeHome
                          ? Row(
                              children: [
                                const Text(
                                  " تم ", //! will be change
                                  style: TextStyle(
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
                      if (3 < 12) // !set morning or night
                        const Text(
                          "ص", //! will be change
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: poppinsFont,
                              color: greyColor),
                        ),
                      if (3 >= 12) // !set morning or night
                        const Text(
                          "م", //! will be change
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              fontFamily: poppinsFont,
                              color: greyColor),
                        ),
                      const Text(
                        " 9:00", //! will be change
                        style: TextStyle(
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
