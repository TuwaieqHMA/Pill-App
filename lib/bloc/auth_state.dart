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