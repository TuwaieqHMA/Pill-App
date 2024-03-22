part of 'medication_bloc.dart';

@immutable
sealed class MedicationState {}

final class MedicationInitial extends MedicationState {}

final class MedicationSucessState extends MedicationState {
  final String msg;

  MedicationSucessState({required this.msg});
}

final class MedicationErrorState extends MedicationState {
  final String msg;

  MedicationErrorState({required this.msg});
}

final class MedicationLoadingState extends MedicationState {

}

final class MedicationUpdateState extends MedicationState {
  
}