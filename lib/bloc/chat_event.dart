part of 'chat_bloc.dart';

@immutable
sealed class ChatEvent {}

final class SendMessageEvent extends ChatEvent {
  final ChatMessage textMessage;
  final List<ChatMessage> oldMessageList;
  final List<ChatUser> oldUserList;
  final ChatUser typingUser;
  
  SendMessageEvent({required this.typingUser,required this.oldMessageList, required this.textMessage, required this.oldUserList, required sentMessage});
}

final class RemoveChatEvent extends ChatEvent {
  final ChatMessage messageToRemove;
  final List<ChatMessage> oldMessageList;

  RemoveChatEvent({required this.messageToRemove, required this.oldMessageList});
}

final class CreateImageEvent extends ChatEvent {
  final ChatMessage textMessage;

  CreateImageEvent({required this.textMessage});
}