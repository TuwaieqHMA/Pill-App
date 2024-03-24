part of 'medication_bloc.dart';

@immutable
sealed class MedicationState {}

final class MedicationInitial extends MedicationState {}

final class MedicationAddedState extends MedicationState {
  final String msg;

  MedicationAddedState({required this.msg});
}

final class MedicationReadState extends MedicationState {
  final String msg;

  MedicationReadState({required this.msg});
}

final class MedicationEditedState extends MedicationState {
  final String msg;

  MedicationEditedState({required this.msg});
}

final class MedicationRemovedState extends MedicationState {
  final String msg;

  MedicationRemovedState({required this.msg});
}

final class MedicationErrorState extends MedicationState {
  final String msg;

  MedicationErrorState({required this.msg});
}

final class MedicationLoadingState extends MedicationState {

}

final class MedicationUpdateState extends MedicationState {
  
}

final class MedicationStatusUpdateState extends MedicationState {
  final Map<String, dynamic> updatedMedication;
  MedicationStatusUpdateState({required this.updatedMedication});

}