import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:pharmabox/firebase/notifications_service.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';
import 'package:http/http.dart' as http;
import '../model/user_models/chat_model.dart';

class ChatService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  NotificationsService notificationsService = NotificationsService();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String getDocId(String firstId, String secondId) {
    if (firstId.compareTo(secondId) < 0) {
      return firstId + secondId;
    }
    return secondId + firstId;
  }

  Future<List<ChatModel>> getDicussions(String userId) async {
    return await _firebaseFirestore
        .collection("discussions")
        .doc(userId)
        .collection("latest_discussions")
        .get()
        .then((value) {
      return value.docs.map((e) => ChatModel.fromMap(e.data())).toList();
    });
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
      String firstId, String secondId) {
    String docId = getDocId(firstId, secondId);
    return _firebaseFirestore
        .collection("chat_room")
        .doc(docId)
        .collection("messages")
        .snapshots();
  }

  Future addMessage(ChatModel chat, String receiverId) async {
    String docId = getDocId(chat.senderId, receiverId);
    await _firebaseFirestore
        .collection("chat_room")
        .doc(docId)
        .collection("messages")
        .doc(DateTime.now().millisecondsSinceEpoch.toString())
        .set(chat.toMap());
    await _firebaseFirestore
        .collection("discussions")
        .doc(receiverId)
        .collection("latest_discussions")
        .doc(chat.senderId)
        .set(chat.toMap());

    await sendNotification(receiverId, chat.senderMessage);
  }

  Future sendNotification(String? recipientToken, String message) async {
    var serverKey =
        'AAAAPBMSj6k:APA91bHcgGJAgKFfYM6rKv9mqKfx92EQ4qXtcQ_OTFL5S1_ahmZeb4rtB0SbDp0lV91ZJZQ79W1npDiU_2pxNyTiNpHJ8WFIujumD4m17ZEoa3H19HuoghO7xykpU9epkUsHYNgG0PPm';

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'key=$serverKey',
    };

    var body = jsonEncode({
      'notification': {
        'title': 'New message',
        'body': message,
      },
      'to': recipientToken,
    });

    var response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headers,
      body: body,
    );

    print('FCM Response: ${response.body}');
  }

  Future<NonTitulaire> getPharmacieOwner(String userId) async {
    return await _firebaseFirestore
        .collection("users")
        .doc(userId)
        .get()
        .then((value) {
      return NonTitulaire.fromJson(value.data()!);
    });
  }
}
