import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/bottom_button.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class ScanPage extends StatelessWidget {
  const ScanPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body:  SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              height32,
               const Align(
                alignment: Alignment.centerRight,
                 child: Text(
                  "مسح الدواء",
                  style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.w800,
                    fontFamily: poppinsFont,
                    color: blackColor,
                  ),
                               ),
               ),
              height48,
              
              Image.asset("assets/images/qr_code.png",
              width: context.getWidth()* 0.8,
              height: context.getHeight()* 0.38,
              ),
              height32,
              const Text(
                " بإمكانك إضافة دوائك إلى قائمة الأدوية الخاصة بك من خلال مسح  الباركود ، والحصول على المزيد من المعلومات عنه",
                
                // "تمكن من إضافة الدواء بسرعة من خلال مسح الباركود ",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  fontFamily: poppinsFont,
                  color: blackColor,
                ),
              ),
              height24,
              const Text(
                "نحن نسعى لتوفير تجربة مريحة و مفيدة لك في مجال الرعاية الصحية و إدارة الأدوية الشخصية ",
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  fontFamily: poppinsFont,
                  color: greyColor,
                ),
              ),
              height32,
              BottomButton(
                onTap: () async{
                  var res = await context.push(const SimpleBarcodeScannerPage(), true);
                  print(res); 
                },
                fillColor: signatureGreenColor,
                text: "إمسح الآن",
                textstyle: const TextStyle(color: whiteColor, fontSize: 24, fontWeight: FontWeight.w500),
                borderSide: BorderSide.none,
              ),


            ],
          ),
        ),
      ),
  
    );
  }
}