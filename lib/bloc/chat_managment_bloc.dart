import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmabox/firebase/chat_service.dart';
import 'package:pharmabox/model/user_models/chat_model.dart';

part 'chat_managment_event.dart';
part 'chat_managment_state.dart';

class ChatManagmentBloc extends Bloc<ChatManagmentEvent, ChatManagmentState> {
  ChatService chatService = ChatService();
  ChatManagmentBloc() : super(ChatManagmentInitial()) {
    on<SendMessage>((event, emit) async {
      try {
        await chatService.addMessage(event.chat, event.receiverId);
        emit(MessageSent());
      } catch (e) {
        debugPrint(e.toString());
        emit(MessageFailed());
      }
    });
  }
}
