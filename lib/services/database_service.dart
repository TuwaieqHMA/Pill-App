import 'package:pill_app/models/medication_model.dart';
import 'package:pill_app/models/saed_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DBService {
  final supabase = Supabase.instance.client;

  Future signUp(
      {required String name,
      required int age,
      required String email,
      required String password}) async {
    await supabase.auth.signUp(email: email, password: password);

    await supabase
        .from("User")
        .insert(SaedUser(name: name, email: email, password: password, age: age));
  }

  Future login({required String email, required String password}) async {
    await supabase.auth.signInWithPassword(
      email: email,
      password: password);
  }

  Future signOut() async {
    await supabase.auth.signOut();
  }

  Future<Session?> getCurrentSession() async {
    final currentSession = supabase.auth.currentSession;

    return currentSession;
  }

  Future<String> getCurrentUserId() async {
    final userId = supabase.auth.currentUser!.id;

    return userId;
  }

  Future sendOtp({required String email}) async {
    await supabase.auth.signInWithOtp(email: email);
  }

  Future verifyOtp({required String email, required String otpToken}) async {
    await supabase.auth.verifyOTP(token: otpToken, type: OtpType.email, email: email);
  }

  Future resetPassword({required String newPassword}) async {
    await supabase.auth.updateUser(UserAttributes(password: newPassword));
  }

  Future<List<Medication>> getUserMedications() async {
    List<Medication> medList = [];
    final jsonList = await supabase.from("Medication").select().eq("user_id", await getCurrentUserId());

    for (var medication in jsonList) {
      medList.add(Medication.fromJson(medication));
    }
    return medList;
  }

  Future<void> addMedication(Medication medication) async {
    await supabase.from("Medication").insert(medication.toJson());
  }

  Future<void> removeMedication(Medication medication) async {
    await supabase.from("Medication").delete().eq("id", medication.id!);
  }

  Future<void> editMedication(Medication newMedication, int medicationId) async {
    await supabase.from("Medication").update(newMedication.toJson()).eq("id", medicationId);
  }

}
