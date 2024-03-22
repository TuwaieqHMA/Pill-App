part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthSucessState extends AuthState {
  final String msg;

  AuthSucessState({required this.msg});
}

final class AuthErrorState extends AuthState {
  final String msg;

  AuthErrorState({required this.msg});
}

final class AuthLoadingState extends AuthState {}

final class RedirectUserState extends AuthState {
  final Session? session;

  RedirectUserState({required this.session});
}
final class AuthSignUpState extends AuthState {
  final String msg;

  AuthSignUpState({required this.msg});
}

final class AuthSignoutState extends AuthState {
  final String msg;

  AuthSignoutState({required this.msg});
}

final class AuthEmailVerifiedState extends AuthState {
  final String msg;

  AuthEmailVerifiedState({required this.msg});
}

final class AuthOtpResentState extends AuthState {
  final String msg;

  AuthOtpResentState({required this.msg});
}

final class AuthOTPVerifiedState extends AuthState {
  final String msg;

  AuthOTPVerifiedState({required this.msg});
}

final class AuthPasswordChangedState extends AuthState {
  final String msg;

  AuthPasswordChangedState({required this.msg});
}
final class ShowUserInfoState extends AuthState {
  final SaedUser user;

  ShowUserInfoState({required this.user});
}

final class IsEditingProfileState extends AuthState {
  final bool isEditing;

  IsEditingProfileState({required this.isEditing});
}