import 'package:firebase_storage/firebase_storage.dart';

class Groupement {
  String groupement;
  String image;
  Groupement({required this.groupement, required this.image});

  static dynamic fromJson(List<dynamic> json) {
    return json.map((e) async {
      final FirebaseStorage storage = FirebaseStorage.instance;
      final String imageName = e["image"];
      final Reference ref = storage.ref().child('groupements').child(imageName);
      String imageUrl = await ref.getDownloadURL();
      return Groupement(groupement: e["name"], image: imageUrl);
    }).toList();
  }
}
