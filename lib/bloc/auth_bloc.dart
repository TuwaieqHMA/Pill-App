import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:pill_app/services/database_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final locator = GetIt.I.get<HomeData>();
  AuthBloc() : super(AuthInitial()) {

    on<SignUpEvent>(signUp);
    on<LoginEvent>(login);
    on<SignOutEvent>(signout);
    on<CheckSessionAvailabilityEvent>(checkSessionAvailability);
  }

  FutureOr<void> signUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.name.trim().isNotEmpty &&
        event.email.trim().isNotEmpty &&
        event.password.trim().isNotEmpty &&
        event.age.trim().isNotEmpty) {
      if (int.parse(event.age) >= 7 && int.parse(event.age) < 105) {
        try {
          await DBService().signUp(
              name: event.name,
              email: event.email,
              password: event.password,
              age: int.parse(event.age));
          emit(AuthSucessState(msg: "تم إنشاء الحساب بنجاح"));
        } on AuthException catch (_) {
          emit(AuthErrorState(msg: "الإيميل أو كلمة السر خاطئة"));
        } on Exception catch (_) {
          emit(AuthErrorState(msg: "هناك مشكلة، يرجى المحاولة في وقتٍ لاحق"));
        }
      } else {
        emit(AuthErrorState(msg: "الرجاء إدخال عمر بين ۷ و ۱۲۰ "));
      }
    } else {
      emit(AuthErrorState(msg: "يرجى إدخال جميع البيانات"));
    }
  }

  FutureOr<void> login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());
    if (event.email.trim().isNotEmpty && event.password.trim().isNotEmpty) {
      try {
        await DBService().login(
          email: event.email,
          password: event.password,
        );
        emit(AuthSucessState(msg: "تم تسجيل الدخول بنجاح"));
        locator.currentUserId = await DBService().getCurrentUserId();
      } on AuthException catch (_) {
        emit(AuthErrorState(msg: "الإيميل أو كلمة السر خاطئة"));
      } on Exception catch (_) {
        emit(AuthErrorState(msg: "هناك مشكلة، يرجى المحاولة في وقتٍ لاحق"));
      }
    } else {
      emit(AuthErrorState(msg: "يرجى إدخال جميع البيانات"));
    }
  }

  FutureOr<void> signout(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    try {
      await DBService().signOut();
      emit(AuthSucessState(msg: "تم تسجيل الخروج بنجاح"));
    } catch (e) {
      emit(AuthErrorState(msg: "هناك مشكلة، يرجى المحاولة في وقتٍ لاحق"));
    }
  }

  FutureOr<void> checkSessionAvailability(CheckSessionAvailabilityEvent event, Emitter<AuthState> emit) async{
      final Session? session = await DBService().getCurrentSession();
      if(session != null){
        locator.currentUserId = await DBService().getCurrentUserId();
      }
      emit(RedirectUserState(session: session));
  }
}
