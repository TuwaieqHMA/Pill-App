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
    on<SendOtpEvent>(sendOtp);
    on<VerifyOtpEvent>(verifyOtp);
    on<ChangePasswordEvent>(changePassword);
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
          await DBService().signOut();
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

  FutureOr<void> checkSessionAvailability(
      CheckSessionAvailabilityEvent event, Emitter<AuthState> emit) async {
    final Session? session = await DBService().getCurrentSession();
    if (session != null) {
      locator.currentUserId = await DBService().getCurrentUserId();
    }
    emit(RedirectUserState(session: session));
  }

  FutureOr<void> sendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoadingState());

    if (event.email.trim().isNotEmpty) {
      try {
        await DBService().sendOtp(email: event.email);
        emit(AuthSucessState(msg: "تم إرسال رمز التحقق إلى بريدك الإلكتروني"));
      } catch (e) {
        emit(AuthErrorState(msg: "الإيميل غير معروف"));
      }
    } else {
      emit(AuthErrorState(msg: "الرجاء تعبئة حقل الإيميل لتغيير كلمة المرور"));
    }
  }

  FutureOr<void> verifyOtp(
      VerifyOtpEvent event, Emitter<AuthState> emit) async {
    if (event.otpToken.trim().isNotEmpty && event.otpToken.length == 6) {
      try {
        await DBService()
            .verifyOtp(email: event.email, otpToken: event.otpToken);
        emit(AuthSucessState(
            msg: "تم التحقق من هويتك يمكنك الآن تغيير كلمة المرور"));
      } catch (e) {
        emit(AuthErrorState(msg: "الرمز غير صحيح، يرجى المحاولة مرة اخرى"));
      }
    } else {
      emit(AuthErrorState(msg: "يرجة إدخال الرمز المكون من ست أرقام"));
    }
  }

  FutureOr<void> changePassword(
      ChangePasswordEvent event, Emitter<AuthState> emit) async{
    emit(AuthLoadingState());
    if (event.password.trim().isNotEmpty && event.rePassword.isNotEmpty) {
      if (event.password == event.rePassword) {
        try {
          await DBService().resetPassword(newPassword: event.password);
          emit(AuthSucessState(msg: "تم تغيير كلمة المرور بنجاح"));
          DBService().signOut();
        } catch (e) {
          emit(AuthErrorState(msg: "هناك مشكلة في خدمتنا، الرجاء المحاولة مرة أخرى"));
        }
      }else {
        emit(AuthErrorState(msg: "كلمتا السر غير متطابقتين"));
      }
    }else {
      emit(AuthErrorState(msg: "الرجاء تعبئة جميع الحقول"));
    }
  }
}
