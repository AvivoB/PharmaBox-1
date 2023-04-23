// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ChatModel {
  final String senderId;
  final String senderMessage;
  final String senderName;
  final String senderPoste;
  final String senderImage;
  ChatModel({
    required this.senderId,
    required this.senderMessage,
    required this.senderName,
    required this.senderPoste,
    required this.senderImage,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'senderMessage': senderMessage,
      'senderName': senderName,
      'senderPoste': senderPoste,
      'senderImage': senderImage,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      senderId: map['senderId'] as String,
      senderMessage: map['senderMessage'] as String,
      senderName: map['senderName'] as String,
      senderPoste: map['senderPoste'] as String,
      senderImage: map['senderImage'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ChatModel.fromJson(String source) =>
      ChatModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
