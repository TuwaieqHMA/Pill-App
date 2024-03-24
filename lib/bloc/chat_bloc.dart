import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dash_chat_2/dash_chat_2.dart';

import 'package:get_it/get_it.dart';
import 'package:meta/meta.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:pill_app/services/gpt_api.dart';
import 'package:translator/translator.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final locator = GetIt.I.get<HomeData>();
  final translator = GoogleTranslator();
  ChatBloc() : super(ChatInitial()) {
    on<SendMessageEvent>(sendMessage);
    on<RemoveChatEvent>(removeChat);
    on<CreateImageEvent>(createImage);
  }

  FutureOr<void> sendMessage(
      SendMessageEvent event, Emitter<ChatState> emit) async {
    if (event.textMessage.text.trim().isNotEmpty) {
      locator.chatLog.insert(0, event.textMessage);
      locator.typingList.add(locator.bot);
      emit(UpdateChatState());

      try {
    final translatedText = await translator.translate(event.textMessage.text, to: 'en');
final answer = await ChatGPT().getChatAnswer(prompt: translatedText.text);

// Translate the answer back to the original language
final translatedAnswer = await translator.translate(answer, to: 'ar');

final newMessage = ChatMessage(
  user: event.typingUser,
  createdAt: DateTime.now(),
  text: translatedAnswer.text, // Use the translated answer
);
        locator.chatLog.insert(0, newMessage);
        locator.typingList.remove(locator.bot);
        emit(UpdateChatState());
        locator.saveChatLog();
      } catch (e) {
        print(e);
        emit(ErrorState(msg: "Error"));
      }
    } else {
      emit(ErrorState(msg: "Please Enter a message"));
    }
  }

  FutureOr<void> removeChat(RemoveChatEvent event, Emitter<ChatState> emit) {
    List<ChatMessage> oldMessageList = event.oldMessageList;

    oldMessageList.remove(event.messageToRemove);
    emit(UpdateChatState());
    locator.saveChatLog();
  }

  FutureOr<void> createImage(
      CreateImageEvent event, Emitter<ChatState> emit) async {
    if (event.textMessage.text.trim().isNotEmpty) {
      locator.chatLog.insert(0, event.textMessage);
      locator.typingList.add(locator.bot);
      emit(UpdateChatState());

      try {
        final answer =
            await ChatGPT().getImageAnswer(prompt: event.textMessage.text);
        final newMessage = ChatMessage(
            user: locator.bot,
            createdAt: DateTime.now(),
            medias: [
              ChatMedia(url: answer, fileName: "", type: MediaType.image,),
            ]);
        locator.chatLog.insert(0, newMessage);
        locator.typingList.remove(locator.bot);
        emit(UpdateChatState());
        locator.saveChatLog();
      } catch (e) {
        emit(ErrorState(msg: "Error"));
        locator.typingList.remove(locator.bot);
        emit(UpdateChatState());
      }
    } else {
      emit(ErrorState(msg: "Please Enter a message"));
    }
  }
}
