import 'package:flutter/material.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pill_app/bloc/chat_bloc.dart';
import 'package:pill_app/data_layer/home_data_layer.dart';
import 'package:pill_app/helpers/extensions/screen_helper.dart';
import 'package:pill_app/utils/colors.dart';
import 'package:translator/translator.dart';

class ChatPage extends StatelessWidget {
   ChatPage({super.key});
final translator = GoogleTranslator();
  @override
  Widget build(BuildContext context) {
    final locator = GetIt.I.get<HomeData>();
    return BlocConsumer<ChatBloc, ChatState>(
      listener: (context, state) {
        if (state is ErrorState){
          context.showErrorSnackBar(state.msg);
        }
      },
      builder: (context, state) {
          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [deepGreenColor, signatureGreencColor2, signatureGreenColor],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
            body: DashChat(
              inputOptions:  InputOptions(
                sendButtonBuilder: (Function onSend) {
              return  InkWell(
                onTap: (){
               onSend();
                },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: goldColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
                  ),
                );
              },
              inputDecoration: InputDecoration(
                     hintText: "...اكتب رسالة",
                hintStyle: const TextStyle(color: Colors.grey), 
                filled: true, 
                fillColor: Colors.white, // Background color of the text field
              
                border: OutlineInputBorder( // Define the border of the text field
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,)
             )),
              typingUsers: locator.typingList,
                messageOptions: MessageOptions(
                  maxWidth: MediaQuery.of(context).size.width * 0.5,
                  showCurrentUserAvatar: true,
                  currentUserContainerColor: glassGreyColor,
                  borderRadius: 15,
                  containerColor: glassGreyColor,
                  textColor: blackColor,
                  currentUserTextColor: blackColor,
                  showTime: true,
                  onLongPressMessage: (message) {
                    context.read<ChatBloc>().add(RemoveChatEvent(messageToRemove: message, oldMessageList: locator.chatLog));
                  },
                  avatarBuilder: (p0, onPressAvatar, onLongPressAvatar) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10),
                        child: Image.network(
                          p0.profileImage!,
                          width: 60,
                          height: 60,
                        ),
                      ),
                    );
                  },
                ),
                currentUser: locator.user,
            onSend: (ChatMessage sentMessage) async {
              if (sentMessage.text.startsWith("/Image:") || sentMessage.text.startsWith("image:")){
                sentMessage.text = sentMessage.text.replaceAll("/image:", "").replaceAll("/Image:", "");
                context.read<ChatBloc>().add(CreateImageEvent(textMessage: sentMessage));
              } else {
                final translatedText = await translator.translate(sentMessage.text, to: 'ar');
                sentMessage.text = translatedText.text;
                context.read<ChatBloc>().add(SendMessageEvent(typingUser: locator.bot, oldMessageList: locator.chatLog, textMessage: sentMessage, oldUserList: locator.typingList, sentMessage: null));
              }
            },
                messages: locator.chatLog),
                 floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
                  floatingActionButton: FloatingActionButton(
                    onPressed: () {
            Navigator.pop(context);
                    },
                    backgroundColor: glassGreyColor,
                    child: Image.asset(
            'assets/icons/right.png',
            height: 28,
            width: 28,
                    ),
                  ),
                    ),
          );
        
      },
    );
  }
}
