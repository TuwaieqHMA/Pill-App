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