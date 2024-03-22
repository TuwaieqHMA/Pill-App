part of 'medication_bloc.dart';

@immutable
sealed class MedicationEvent {}


final class ShowUserMedicationsEvent extends MedicationEvent {

}
final class AddMedicationEvent extends MedicationEvent {
  final Medication medication;
  final int? timesADay;


  AddMedicationEvent({required this.timesADay, required this.medication});
}

final class RemoveMedicationEvent extends MedicationEvent {
  final Medication medication;


  RemoveMedicationEvent({required this.medication});
}

final class EditMedication extends MedicationEvent {
  final Medication newMedication;
  final int medicationId;

  EditMedication({required this.medicationId, required this.newMedication});
}

final class UpdatePageEvent extends MedicationEvent {
  
}

final class MedicationStatusUpdateEvent extends MedicationEvent {
  Medication medication;
  String newStatus;
  MedicationStatusUpdateEvent({required this.medication, required this.newStatus});
}