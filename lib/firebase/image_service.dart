import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ImageService {
  ImagePicker picker = ImagePicker();
  ImageCropper cropper = ImageCropper();
  Future<XFile?> pickImageFromGallery() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        final croppedFile = await cropper.cropImage(
          sourcePath: image.path,
          compressQuality: 100,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        );
        if (croppedFile != null) {
          
          final img = XFile(croppedFile.path);
          return img;
        }
        return image;
      }
      throw Exception("image not picked");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future multiImagePicker() async {
    try {
      final List<XFile?> images = await picker.pickMultiImage();
      if (images.isNotEmpty) {
        List<XFile?> croppedFiles = [];
        for (XFile? image in images) {
          final croppedFile = await cropper.cropImage(
            sourcePath: image!.path,
            compressQuality: 100,
            aspectRatioPresets: [
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio3x2,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPreset.ratio16x9
            ],
          );
          if (croppedFile != null) {
                     final img = XFile(croppedFile.path);
                    croppedFiles.add(img);
          }
        }
        if (croppedFiles.isNotEmpty) {
            return croppedFiles;
          }
        return images;
      }
      throw Exception("images not picked");
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<XFile?> pickImageFromCamera() async {
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        final croppedFile = await cropper.cropImage(
          sourcePath: image.path,
          compressQuality: 100,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
        );
        if (croppedFile != null) {
          final img = XFile(croppedFile.path);
          return img;
        }
        return image;
      }
      throw Exception("photo not picked");
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
