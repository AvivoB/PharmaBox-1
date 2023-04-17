import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pharmabox/model/user_models/non_titulaire.dart';

import '../model/user_models/chat_model.dart';

class ChatService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
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
