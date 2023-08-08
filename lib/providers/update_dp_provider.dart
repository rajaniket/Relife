import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:relife/services/API/update_dp_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateDpProvider extends ChangeNotifier {
  Future<int> updateDp() async {
    var file = await ImagePicker()
        .pickImage(source: ImageSource.gallery, imageQuality: 40);
    if (file == null) {
      return 404;
    }
    final imagePath = File(file.path);
    final croppedImage = await _cropImage(imagePath.path);

    String? token = await getsharedToken();
    var response = await UpdateDpService().updateDp(croppedImage!.path, token!);
    return response.statusCode;
  }

  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

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
}
