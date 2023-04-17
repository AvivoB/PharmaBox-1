import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:pharmabox/firebase/chat_service.dart';
import 'package:pharmabox/model/user_models/chat_model.dart';

part 'discussions_event.dart';
part 'discussions_state.dart';

class DiscussionsBloc extends Bloc<DiscussionsEvent, DiscussionsState> {
  ChatService chatService = ChatService();
  DiscussionsBloc() : super(DiscussionsInitial()) {
    on<GetDiscussions>((event, emit) async {
      try {
        List<ChatModel> discussions =
            await chatService.getDicussions(event.userId);
        emit(DiscussionsReady(discussions: discussions));
      } catch (e) {
        debugPrint(e.toString());
        emit(DiscussionsInitial());
      }
    });
  }
}
