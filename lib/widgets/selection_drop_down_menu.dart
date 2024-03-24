import 'package:flutter/material.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';

class SelectionDropDownMenu extends StatelessWidget {
  const SelectionDropDownMenu({
    super.key,
    required this.controller, required this.hintText, required this.itemList, this.icon, this.onSelected, this.initialValue, this.isEnabled = true, this.helperText,
  });

  final TextEditingController controller;
  final String hintText;
  final List<DropdownMenuEntry<dynamic>> itemList;
  final Widget? icon;
  final Function(dynamic)? onSelected;
  final dynamic initialValue;
  final bool? isEnabled;
  final String? helperText;


  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      helperText: helperText,
      enabled: isEnabled!,
      initialSelection: initialValue,
      onSelected: onSelected,
      textStyle: const TextStyle(color: blackColor, fontFamily: poppinsFont, fontSize: 14, fontWeight: FontWeight.w500),
      menuHeight: 160,
      selectedTrailingIcon: const Icon(Icons.arrow_drop_up_rounded, color: greyColor,),
      trailingIcon: const Icon(Icons.arrow_drop_down_rounded, color: greyColor,),
      enableFilter: true,
      hintText: hintText,
      menuStyle: MenuStyle(
        shape: MaterialStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14)
        )),
        surfaceTintColor: const MaterialStatePropertyAll(noColor),
        backgroundColor: const MaterialStatePropertyAll(glassGreyColor)
      ),
      leadingIcon: Container(
        height: 20,
        width: 20,
        alignment: Alignment.center,
        child: icon),
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: const TextStyle(color: blackColor, fontFamily: poppinsFont, fontSize: 13, fontWeight: FontWeight.w500),
        fillColor: glassGreyColor,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none),
      ),
      controller: controller,
      dropdownMenuEntries: itemList
      ,
    );
  }
}