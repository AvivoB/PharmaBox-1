import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmabox/firebase/chat_service.dart';
import 'package:pharmabox/model/user_models/chat_model.dart';

part 'chat_display_event.dart';
part 'chat_display_state.dart';

class ChatDisplayBloc extends Bloc<ChatDisplayEvent, ChatDisplayState> {
  ChatService chatService = ChatService();
  ChatDisplayBloc() : super(ChatDisplayInitial()) {
    on<DisplayMessages>((event, emit) {
      try {
        chatService
            .getMessages(event.senderId, event.receiverId)
            .listen((event) => add(GetMessages(event: event)));
      } catch (e) {
        debugPrint(e.toString());
        emit(MessagesFailed());
      }
    });
    on<GetMessages>((event, emit) {
      emit(MessagesReady(
          messages: event.event.docs
              .map((snapshot) => ChatModel.fromMap(snapshot.data()))
              .toList()));
    });
  }
}
