import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  ImagePicker picker = ImagePicker();

  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        return image;
      }
      throw Exception("image not picked");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<XFile?> pickImageFromCamera() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        return image;
      }
      throw Exception("photo not picked");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
