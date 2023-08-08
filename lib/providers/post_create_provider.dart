import 'dart:io';

import 'package:flutter/material.dart';
import 'package:relife/services/GetSocial/post_service.dart';

class PostCreateProvider extends ChangeNotifier {
  String? text;
  File? imagePath;

  void setText(text) {
    this.text = text;
  }

  void setImagePath(File? imagePath) {
    this.imagePath = imagePath;
    notifyListeners();
  }

  Future<bool?> sharePost(
      {bool isThisGroup = false,
      String feedId = 'timeline',
      String? topic,
      Map<String, String>? properties}) async {
    bool? result;
    result = await PostService().postActivity(
        topic: topic,
        text: text,
        imagePath: imagePath,
        groupId: feedId,
        isThisGroup: isThisGroup,
        properties: properties);

    // await Future.delayed(const Duration(seconds: 3));
    if (result == true) {
      text = null;
      imagePath = null;
      notifyListeners();
    }
    return result;
  }

  bool isPostEmpty() {
    if (text == null && imagePath == null) return true;
    return false;
  }
}
