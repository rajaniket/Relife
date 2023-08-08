import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:getsocial_flutter_sdk/common/media_attachment.dart';
import 'package:getsocial_flutter_sdk/communities.dart';
import 'package:getsocial_flutter_sdk/communities/activitycontent.dart';
import 'package:getsocial_flutter_sdk/communities/postactivitytarget.dart';

class PostService {
  Future<bool> postActivity({
    String? topic,
    String? text,
    File? imagePath,
    Map<String, String>? properties,
    bool isThisGroup = false,
    String groupId = 'timeline', // feedId is bacically groups or timeline
  }) async {
    var activityContent = ActivityContent();

    if (properties != null) {
      activityContent.properties = properties;
    }

    if (text != null) {
      activityContent.text = text;
    }
    if (imagePath != null) {
      activityContent.attachments.add(MediaAttachment.withBase64Image(
          base64Encode(imagePath.readAsBytesSync())));
    }

    PostActivityTarget target = isThisGroup
        ? PostActivityTarget.group(groupId)
        : PostActivityTarget.topic(topic!);

    // if ((text == null && imagePath == null) || text == "") {
    // } else {

    // }
    Completer<bool> postUploadSuccess = Completer();

    log("_________ _ __________________ Activity properties = ${activityContent.properties}, $properties");

    var act =
        await Communities.postActivity(activityContent, target).then((result) {
      // print("result : $result");
      log("PostService  ______ $result");
      postUploadSuccess.complete(true);
    }).catchError((error) {
      postUploadSuccess.complete(false);
      // postUploadSuccess = false;
      log("post error :  $error ");
    });

    print("act : $act");

    return postUploadSuccess.future;
  }
}
