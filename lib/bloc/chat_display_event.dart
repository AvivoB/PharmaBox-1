// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_display_bloc.dart';

abstract class ChatDisplayEvent {
  const ChatDisplayEvent();
}

class DisplayMessages extends ChatDisplayEvent {
  final String senderId;
  final String receiverId;
  const DisplayMessages({
    required this.senderId,
    required this.receiverId,
  });
}

class GetMessages extends ChatDisplayEvent {
  QuerySnapshot<Map<String, dynamic>> event;
  GetMessages({
    required this.event,
  });
}
