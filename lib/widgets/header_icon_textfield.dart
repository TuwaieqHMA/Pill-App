import 'package:flutter/material.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';

class HeaderIconTextField extends StatelessWidget {
  const HeaderIconTextField({
    super.key, required this.headerText, required this.hintText, this.suffixIcon, this.controller, this.isreadOnly, this.prefixIcon, this.textDirection, this.onTap,
  });

  final String headerText;
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final TextDirection? textDirection;
  final TextEditingController? controller;
  final bool? isreadOnly;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          headerText,
          style: const TextStyle(
              color: blackColor,
              fontFamily: poppinsFont,
              fontSize: 15,
              fontWeight: FontWeight.w500),
        ),
        height8,
        TextField(
          onTap: onTap,
          readOnly: isreadOnly ?? false,
          controller: controller,
          textDirection: textDirection ?? TextDirection.rtl,
          cursorColor: greyColor,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: greyTextColor, fontFamily: poppinsFont, fontSize: 15, fontWeight: FontWeight.w500),
            hintTextDirection: textDirection ?? TextDirection.rtl,
              fillColor: glassGreyColor,
              filled: true,
              suffixIcon: (suffixIcon != null) ? Container(
                width: 16,
                height: 16,
                alignment: Alignment.center,
                child: suffixIcon
              ) : null,
              prefixIcon: (prefixIcon != null) ?Container(
                width: 16,
                height: 16,
                alignment: Alignment.center,
                child: prefixIcon
              ) : null,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none)),
        )
      ],
    );
  }
}
