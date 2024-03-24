import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pill_app/bloc/medication_bloc.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/models/medication_model.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:pill_app/utils/fonts.dart';
import 'package:pill_app/utils/spaces.dart';
import 'package:pill_app/widgets/home_page_header.dart';
import 'package:pill_app/widgets/medeicine_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final medicationBloc = context.read<MedicationBloc>();
    if (locator.userMedicationList.isEmpty) {
      medicationBloc.add(ShowUserMedicationsEvent());
    }
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const HomePageHeader(),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "أدويتي",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      fontFamily: poppinsFont,
                      color: blackColor,
                    ),
                  ),
                ],
              ),
            ),
            height24,
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: BlocConsumer<MedicationBloc, MedicationState>(
                  listener: (context, state) {
                    if (state is MedicationErrorState) {
                      context.showErrorSnackBar(state.msg);
                    }
                    
                  },
                  builder: (context, state) {
                    if (state is MedicationLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: midGreenColor,
                        ),
                      );
                    } else {
                      return (locator.userMedicationList.isNotEmpty)
                          ? ListView.builder(
                              itemCount: locator.userMedicationList.length,
                              itemBuilder: (context, index) {
                                return MedicineCard(
                                    fromHome: true,
                                    medication:
                                        locator.userMedicationList[index]);
                              },
                            )
                          : const Center(
                              child: Text(
                                "...لم يتم إضافة أي أدوية بعد",
                                style: TextStyle(
                                    color: greyTextColor,
                                    fontFamily: poppinsFont,
                                    fontSize: 24),
                              ),
                            );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
