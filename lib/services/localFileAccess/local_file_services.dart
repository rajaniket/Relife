import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class LocalFileServices {
  Future<File?> _cropImage(filepath) async {
    File? croppedImage = await ImageCropper().cropImage(
        sourcePath: filepath,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          // CropAspectRatioPreset.ratio4x3,
        ],
        androidUiSettings: const AndroidUiSettings(hideBottomControls: true));
    return croppedImage;
  }

  Future pickImageFromGallary() async {
    try {
      final image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 35);
      if (image == null) return;
      final imagePath = File(image.path);

      final croppedImage = await _cropImage(imagePath.path);
      return croppedImage;

      // Provider.of<PostCreateProvider>(context, listen: false)
      //     .setImagePath(croppedImage);
    } on PlatformException catch (e) {
      // print("error $e");
    }
  }

  //  Future pickImageFromCamera() async {
  //   try {
  //     final image = await ImagePicker().pickImage(source: ImageSource.camera);
  //     if (image == null) return;
  //     final imagePath = File(image.path);
  //     final croppedImage = await _cropImage(imagePath.path);

  //     Provider.of<PostCreateProvider>(context, listen: false)
  //         .setImagePath(imagePath);

  //     final cropedFile = imagePath;
  //   } on PlatformException catch (e) {
  //     print("error $e");
  //   }
  // }
}
