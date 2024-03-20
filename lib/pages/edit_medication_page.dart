import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/models/medication_model.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/back_icon.dart';
import 'package:pill_app/widgets/bottom_button.dart';
import 'package:pill_app/widgets/header_icon_textfield.dart';
import 'package:pill_app/widgets/selection_drop_down_menu.dart';

// ignore: must_be_immutable
class EditMedicationPage extends StatelessWidget {
  EditMedicationPage({super.key, required this.medication});
  final Medication medication;
  TextEditingController medicationNameController = TextEditingController();
  TextEditingController durationController = TextEditingController();
  TextEditingController pillCountController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController beforeAfterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    medicationNameController.text = medication.medicationName;
    durationController.text = (medication.startDate.difference(medication.endDate).inDays.toString());
    pillCountController.text = medication.numberPill.toString();
    timeController.text = "${medication.timeEat.hour}:${medication.timeEat.minute}";
    beforeAfterController.text = medication.beforeAfterEating;
    final locator = GetIt.I.get<HomeData>();
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          scrolledUnderElevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: BackIcon(
                onTap: () {
                  context.pop();
                },
              ),
            )
          ],
        ),
        body: Theme(
          data: ThemeData(
                  timePickerTheme: locator.timePickerTheme(),
                  bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.black54)
                ),
          child: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                height8,
                const Text(
                  "تعديل الدواء",
                  style: TextStyle(
                      color: blackColor,
                      fontFamily: poppinsFont,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
                height16,
                HeaderIconTextField(
                  controller: medicationNameController,
                  headerText: "اسم الدواء",
                  hintText: "اكتب...",
                  suffixIcon: SvgPicture.asset(
                    "assets/icons/drugs_icon.svg",
                    colorFilter:
                        const ColorFilter.mode(greyColor, BlendMode.srcIn),
                  ),
                ),
                height32,
                const Text(
                  "مدة و عدد حبات الدواء",
                  style: TextStyle(
                      color: blackColor,
                      fontFamily: poppinsFont,
                      fontSize: 15,
                      fontWeight: FontWeight.w500),
                ),
                height8,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    SelectionDropDownMenu(
                      onSelected: (value) {
                        pillCountController.text = "حبة     $value";
                      },
                      controller: pillCountController,
                      hintText: "......  حبة",
                      itemList: List.generate(
                          3,
                          (index) => DropdownMenuEntry(
                              value: index + 1, label: "${index + 1}")),
                      icon: SvgPicture.asset("assets/icons/duo_pills.svg"),
                    ),
                    SelectionDropDownMenu(
                      onSelected: (value) {
                        durationController.text = "يوم   $value";
                      },
                      controller: durationController,
                      hintText: "......  يوم",
                      itemList: List.generate(
                          30,
                          (index) => DropdownMenuEntry(
                              value: index + 1, label: "${index + 1}")),
                      icon: SvgPicture.asset("assets/icons/calendar.svg"),
                    ),
                  ],
                ),
                height16,
                const Text(
                "قبل أو بعد الأكل",
                style: TextStyle(
                    color: blackColor,
                    fontFamily: poppinsFont,
                    fontSize: 15,
                    fontWeight: FontWeight.w500),
              ),
              height8,
              SelectionDropDownMenu(
                controller: beforeAfterController,
                hintText: "......",
                itemList: const [
                  DropdownMenuEntry(value: "قبل الأكل", label: "قبل الأكل"),
                  DropdownMenuEntry(value: "بعد الأكل", label: "بعد الأكل")
                ],
                icon: SvgPicture.asset("assets/icons/calendar.svg"),
              ),
              height16,
                Builder(
                  builder: (context) {
                    return HeaderIconTextField(
                      controller: timeController,
                      headerText: "وقت الإشعار",
                      hintText: "اضغط للإختيار...",
                      prefixIcon: SvgPicture.asset(
                        "assets/icons/bell.svg",
                        colorFilter:
                            const ColorFilter.mode(greyColor, BlendMode.srcIn),
                      ),
                      isreadOnly: true,
                      onTap: () async{
                        final TimeOfDay? pickedTime = await locator.getTimeOfDay(context);
                        if (pickedTime != null){
                          timeController.text = "${pickedTime.hour}:${pickedTime.minute}";
                        }
                      },
                    );
                  }
                ),
              ],
            ),
          ),
        ),
        bottomSheet: Padding(
          padding: const EdgeInsets.only(left: 28, right: 28, bottom: 29),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              BottomButton(
                onTap: (){},
                text: "حفظ",
                fillColor: calmGreenColor,
                borderSide: BorderSide.none,
                textstyle: const TextStyle(
                    color: whiteColor,
                    fontFamily: poppinsFont,
                    fontSize: 25,
                    fontWeight: FontWeight.w800),
              ),
              height16,
              BottomButton(
                onTap: (){},
                text: "حذف",
                fillColor: whiteColor,
                borderSide: const BorderSide(color: calmGreenColor, strokeAlign: BorderSide.strokeAlignInside, width: 1),
                textstyle: const TextStyle(
                    color: greyColor1,
                    fontFamily: poppinsFont,
                    fontSize: 25,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ));
  }

  
}
