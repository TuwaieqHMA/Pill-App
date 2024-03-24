part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

final class SignUpEvent extends AuthEvent {
  final String name;
  final String age;
  final String email;
  final String password;

  SignUpEvent({required this.age, required this.email, required this.password, required this.name});
}

final class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

final class SignOutEvent extends AuthEvent {}

final class CheckSessionAvailabilityEvent extends AuthEvent {
  
}

final class SendOtpEvent extends AuthEvent {
  final String email;

  SendOtpEvent({required this.email});
}

final class ResendOtpEvent extends AuthEvent {
  final String email;

  ResendOtpEvent({required this.email});
}

final class VerifyOtpEvent extends AuthEvent {
  final String email;

  final String otpToken;
  VerifyOtpEvent({required this.email, required this.otpToken});
}

final class ChangePasswordEvent extends AuthEvent {
  final String password;
  final String rePassword;

  ChangePasswordEvent({required this.password, required this.rePassword});
}

final class GetUserInfoEvent extends AuthEvent {
  
}

final class ActivateEditModeEvent extends AuthEvent {

}
final class DeactivateEditModeEvent extends AuthEvent {

}

final class EditProfileEvent extends AuthEvent {
  final String name;
  final String age;
  final String password;

  EditProfileEvent({required this.name, required this.age, required this.password});
}

final class GetFcmTokenEvent extends AuthEvent {
  
}