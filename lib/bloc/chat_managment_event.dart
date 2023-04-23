// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'chat_managment_bloc.dart';

abstract class ChatManagmentEvent extends Equatable {
  const ChatManagmentEvent();

  @override
  List<Object> get props => [];
}

class SendMessage extends ChatManagmentEvent {
  final ChatModel chat;
  final String receiverId;
  const SendMessage({
    required this.chat,
    required this.receiverId,
  });
}
