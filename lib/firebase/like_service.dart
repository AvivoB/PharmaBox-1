import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LikeService {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<int> getPharmacieLikes(String id) async {
    final DocumentSnapshot pharmacieDoc =
        await _firebaseFirestore.collection("pharmacies_likes").doc(id).get();
    if (!pharmacieDoc.exists) {
      return 0;
    }
    final dynamic infos = pharmacieDoc.data()!;
    return infos["count"];
  }

  Future<bool> checkPharmacieUser(String userId, String docId) async {
    print("called");
    final DocumentSnapshot pharmacieDoc = await _firebaseFirestore
        .collection("pharmacies_likes")
        .doc(docId)
        .get();
    if (pharmacieDoc.exists) {
      final dynamic infos = pharmacieDoc.data()!;
      if (!infos["users"].contains(userId)) {
        return false;
      } else {
        return true;
      }
    } else {
      return false;
    }
  }

  Future<bool> checkUsersLikes(String userId, String docId) async {
    final DocumentSnapshot pharmacieDoc =
        await _firebaseFirestore.collection("user_likes").doc(docId).get();
    final dynamic infos = pharmacieDoc.data()!;
    if (!infos["users"].contains(userId)) {
      return false;
    } else {
      return true;
    }
  }

  Future<int> getUserLikes(String id) async {
    final DocumentSnapshot pharmacieDoc =
        await _firebaseFirestore.collection("user_likes").doc(id).get();
    if (!pharmacieDoc.exists) {
      return 0;
    }
    final dynamic infos = pharmacieDoc.data()!;
    return infos["count"];
  }

  Future addUserLikes(String userId, String docId) async {
    final DocumentSnapshot pharmacieDoc =
        await _firebaseFirestore.collection("user_likes").doc(docId).get();
    if (pharmacieDoc.exists) {
      final dynamic infos = pharmacieDoc.data()!;
      if (!infos["users"].contains(userId)) {
        infos["users"].add(userId);
      }
      infos["count"] = infos["count"] + 1;
      await _firebaseFirestore.collection("user_likes").doc(docId).set(infos);
    } else {
      await _firebaseFirestore.collection("user_likes").doc(docId).set({
        "users": [userId],
        "count": 1
      });
    }
  }

  Future addPharmacieLikes(String userId, String docId) async {
    final DocumentSnapshot pharmacieDoc = await _firebaseFirestore
        .collection("pharmacies_likes")
        .doc(docId)
        .get();
    if (pharmacieDoc.exists) {
      final dynamic infos = pharmacieDoc.data()!;
      if (!infos["users"].contains(userId)) {
        infos["users"].add(userId);
      }
      infos["count"] = infos["count"] + 1;
      await _firebaseFirestore
          .collection("pharmacies_likes")
          .doc(docId)
          .set(infos);
    } else {
      await _firebaseFirestore.collection("pharmacies_likes").doc(docId).set({
        "users": [userId],
        "count": 1
      });
    }
  }

  Future removeUserLikes(String userId, String docId) async {
    final DocumentSnapshot pharmacieDoc =
        await _firebaseFirestore.collection("user_likes").doc(docId).get();
    final dynamic infos = pharmacieDoc.data()!;
    infos["users"].remove(userId);
    infos["count"] = infos["count"] - 1;
    await _firebaseFirestore.collection("user_likes").doc(docId).set(infos);
  }

  Future removePharmacieLikes(String userId, String docId) async {
    final DocumentSnapshot pharmacieDoc = await _firebaseFirestore
        .collection("pharmacies_likes")
        .doc(docId)
        .get();
    final dynamic infos = pharmacieDoc.data()!;
    infos["users"].remove(userId);
    infos["count"] = infos["count"] - 1;
    await _firebaseFirestore
        .collection("pharmacies_likes")
        .doc(docId)
        .set(infos);
  }
}
