import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:pill_app/models/medication_model.dart';
import 'package:pill_app/services/database_service.dart';

part 'medication_event.dart';
part 'medication_state.dart';

class MedicationBloc extends Bloc<MedicationEvent, MedicationState> {
  final locator = GetIt.I.get<HomeData>();
  MedicationBloc() : super(MedicationInitial()) {
    on<ShowUserMedicationsEvent>(showMedication);
    on<AddMedicationEvent>(addMedication);
    on<UpdatePageEvent>(updatePage);
  }


  FutureOr<void> showMedication(
      ShowUserMedicationsEvent event, Emitter<MedicationState> emit) async {
    emit(MedicationLoadingState());

    try {
      locator.userMedicationList = await DBService().getUserMedications();
      emit(MedicationSucessState(msg: "تم تحميل أدويتك بنجاح"));
    } catch (e) {
      emit(MedicationErrorState(msg: "حدث خطأ في تحميل أدويتك"));
    }
  }

  FutureOr<void> addMedication(
      AddMedicationEvent event, Emitter<MedicationState> emit) async {
    emit(MedicationLoadingState());
    if (event.medication.medicationName.trim().isNotEmpty &&
        event.medication.beforeAfterEating.trim().isNotEmpty &&
        event.medication.endDate != null &&
        event.medication.numberPill != null &&
        event.medication.timeEat != null &&
        event.timesADay != null) {
      try {
        switch (event.timesADay) {
          case 1:
            await DBService().addMedication(event.medication);
            emit(MedicationSucessState(
                msg: "تم إضافة دواءك ${event.medication.medicationName}"));
            break;
          case 2:
          await DBService().addMedication(Medication(medicationName: "${event.medication.medicationName}- جرعة ١", timeEat: event.medication.timeEat, beforeAfterEating: event.medication.beforeAfterEating, numberPill: event.medication.numberPill, userId: event.medication.userId, currentStatus: event.medication.currentStatus, startDate: event.medication.startDate, endDate: event.medication.endDate));
          await DBService().addMedication(Medication(medicationName: "${event.medication.medicationName}- جرعة ٢", timeEat: ((event.medication.timeEat!.hour + 12) > 24) ? TimeOfDay(hour: event.medication.timeEat!.hour+ 12 - 24, minute: event.medication.timeEat!.minute) : TimeOfDay(hour: event.medication.timeEat!.hour + 12, minute: event.medication.timeEat!.minute), beforeAfterEating: event.medication.beforeAfterEating, numberPill: event.medication.numberPill, userId: event.medication.userId, currentStatus: event.medication.currentStatus, startDate: event.medication.startDate, endDate: event.medication.endDate));
          
            emit(MedicationSucessState(
                msg: "تم إضافة دواءك ${event.medication.medicationName}"));
                case 3:
          await DBService().addMedication(Medication(medicationName: "${event.medication.medicationName}- جرعة ١", timeEat: event.medication.timeEat, beforeAfterEating: event.medication.beforeAfterEating, numberPill: event.medication.numberPill, userId: event.medication.userId, currentStatus: event.medication.currentStatus, startDate: event.medication.startDate, endDate: event.medication.endDate));
          await DBService().addMedication(Medication(medicationName: "${event.medication.medicationName}- جرعة ٢", timeEat: ((event.medication.timeEat!.hour + 8) > 24) ? TimeOfDay(hour: event.medication.timeEat!.hour + 8 - 24, minute: event.medication.timeEat!.minute) : TimeOfDay(hour: event.medication.timeEat!.hour + 8, minute: event.medication.timeEat!.minute), beforeAfterEating: event.medication.beforeAfterEating, numberPill: event.medication.numberPill, userId: event.medication.userId, currentStatus: event.medication.currentStatus, startDate: event.medication.startDate, endDate: event.medication.endDate));
          await DBService().addMedication(Medication(medicationName: "${event.medication.medicationName}- جرعة ٣", timeEat: ((event.medication.timeEat!.hour + 16) > 24) ? TimeOfDay(hour: event.medication.timeEat!.hour + 16 - 24, minute: event.medication.timeEat!.minute) : TimeOfDay(hour: event.medication.timeEat!.hour + 16, minute: event.medication.timeEat!.minute), beforeAfterEating: event.medication.beforeAfterEating, numberPill: event.medication.numberPill, userId: event.medication.userId, currentStatus: event.medication.currentStatus, startDate: event.medication.startDate, endDate: event.medication.endDate));
          
            emit(MedicationSucessState(
                msg: "تم إضافة دواءك ${event.medication.medicationName}"));
          default:
        }
      } catch (e) {
        print(e);
        emit(MedicationErrorState(msg: "حدث خطأ أثناء إضافة دوائك"));
      }
    } else {
      emit(MedicationErrorState(msg: "!الرجاء تعبئة جميع الحقول"));
    }
  }

  FutureOr<void> updatePage(UpdatePageEvent event, Emitter<MedicationState> emit) {
    emit(MedicationUpdateState());
  }
}
