part of 'chat_managment_bloc.dart';

abstract class ChatManagmentState extends Equatable {
  const ChatManagmentState();

  @override
  List<Object> get props => [];
}

class ChatManagmentInitial extends ChatManagmentState {}

class MessageSent extends ChatManagmentState {}

class MessageFailed extends ChatManagmentState {}
