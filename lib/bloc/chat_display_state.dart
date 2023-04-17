// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_display_bloc.dart';

abstract class ChatDisplayState {
  const ChatDisplayState();
}

class ChatDisplayInitial extends ChatDisplayState {}

class MessagesReady extends ChatDisplayState {
  final List<ChatModel> messages;
  const MessagesReady({
    required this.messages,
  });
}

class MessagesFailed extends ChatDisplayState {}
