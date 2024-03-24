import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';

final locator = GetIt.I.get<HomeData>();
class Medication {
  final int? id;
  String medicationName;
  TimeOfDay? timeEat;
  String beforeAfterEating;
  int? numberPill;
  String userId;
  String currentStatus;
  DateTime? startDate;
  DateTime? endDate;

  Medication({
    this.id,
    required this.medicationName,
    required this.timeEat,
    required this.beforeAfterEating,
    required this.numberPill,
    required this.userId,
    required this.currentStatus,
    required this.startDate,
    required this.endDate,
  });

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'],
      medicationName: json['medication_name'],
      timeEat: locator.stringToTimeOfDay(json['time_eat']),
      beforeAfterEating: json['before_after_eating'],
      numberPill: json['number_pill'],
      userId: json['user_id'],
      currentStatus: json['current_status'],
      startDate: DateTime.parse(json['start_date']),
      endDate: DateTime.parse(json['end_date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      // 'id': id,  //No need to send ID as its automatically generated
      'medication_name': medicationName,
      'time_eat': '${timeEat!.hour}:${timeEat!.minute}',
      'before_after_eating': beforeAfterEating,
      'number_pill': numberPill,
      'user_id': userId,
      'current_status': currentStatus,
      'start_date': startDate!.toIso8601String(),
      'end_date': endDate!.toIso8601String(),
    };
  }
}
