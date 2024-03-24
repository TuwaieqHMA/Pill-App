part of 'chat_bloc.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class UpdateChatState extends ChatState {
}

final class ErrorState extends ChatState {
  final String msg;

  ErrorState({required this.msg});
}