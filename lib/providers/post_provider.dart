import 'dart:async';

import 'package:flutter/material.dart';
import 'package:getsocial_flutter_sdk/communities/activity.dart';
import 'package:getsocial_flutter_sdk/getsocial_flutter_sdk.dart';
import 'package:relife/services/GetSocial/load_feed_service.dart';
import 'package:relife/services/GetSocial/post_comment_service.dart';

class AllPostsProvider extends ChangeNotifier {
  // List<GetSocialActivity>? userPostList = [];
  // List<String>? userPostsId = [];

  Future loadAllPosts({
    bool isThisGroup = false,
    String feedId = 'timeline',
    bool getPostByUser = false,
    UserId? userId,
  }) async {
    List<GetSocialActivity>? userPostList = [];
    userPostList = await LoadFeed().getAllPosts(
        groupId: feedId,
        isThisGroup: isThisGroup,
        getPostByUser: getPostByUser,
        userId: userId);
    print('Activities_provider__________________________: $userPostList');
    notifyListeners();
    return userPostList;
  }

  // Future setReaction(int index) async {
  //   var postId = loadPostActivityId(index);
  //   await LoadFeed().setRecation(postId);
  // }

  // Future removeReaction(int index) async {
  //   var postId = loadPostActivityId(index);
  //   await LoadFeed().removeRecation(postId);
  // }

  // isLikedByMe(int index) {
  //   return userPostList![index].myReactions.contains('like');
  // }

  // loadAuthorName(int index) {
  //   return userPostList![index].author.displayName;
  // }

  // loadAuthorProfileImage(int index) {
  //   return userPostList![index].author.avatarUrl;
  // }

  // loadAuthorId(int index) {
  //   return userPostList![index].author.userId;
  // }

  // loadAuthorPostText(int index) {
  //   return userPostList![index].text;
  // }

  // String? loadAuthorPostImage(int index) {
  //   var mediaListlength = userPostList![index].attachments.length;
  //   return mediaListlength > 0
  //       ? userPostList![index].attachments[0].imageUrl
  //       : null;
  // }

  // loadNumOfComments(int index) {
  //   return userPostList![index].commentsCount.toString();
  // }

  // loadNumofLikes(int index) {
  //   var output = userPostList![index].reactionsCount["like"].toString();
  //   return output == 'null' ? '0' : output;
  // }

  // loadPostActivityId(int index) {
  //   return userPostList![index].id;
  // }

  // loadRankingTitle() {
  //   return 'rank 2 in running this month';
  // }
}

class DetailedPostProvider extends ChangeNotifier {
  GetSocialActivity? detailedPost;
  List<GetSocialActivity>? postCommentsList = [];

  //for posting a new comment
  Future<List<GetSocialActivity>?> postNewComment(
      String comment, String postId) async {
    try {
      await PostCommentService().postComment(postId, comment);
      // Future.delayed(Duration(seconds: 1));
      postCommentsList = await LoadFeed().getAllCommentsOfPost(postId);
      // print(
      //     "all done_________________________________________  ${postCommentsList!.length}, ");
      // for (int i = 0; i < postCommentsList!.length; i++) {
      //   print(postCommentsList![i].text);
      // }
      notifyListeners();
      return postCommentsList;
    } catch (e) {
      rethrow;
    }
  }

  // load post in detailed using post id
  Future loadDetailedPosTById(String postId) async {
    detailedPost = await LoadFeed().getPostById(postId);
    return detailedPost;
    // notifyListeners();
  }

//for loading all comments associated with an post id (in getsocial comment is like a post , it can contain media too )
  Future loadAllComments(String postId) async {
    postCommentsList = await LoadFeed().getAllCommentsOfPost(postId);
    return postCommentsList;
    // print('AllComments__________________________: ${postCommentsList}');
    //notifyListeners();
  }

  Future setReaction(postId) async {
    await LoadFeed().setRecation(postId);
    // detailedPost = await LoadFeed().getPostById(postId);
    notifyListeners();
  }

  Future removeReaction(postId) async {
    await LoadFeed().removeRecation(postId);
    //  detailedPost = await LoadFeed().getPostById(postId);
    notifyListeners();
  }

  isLikedByMe(String postId) async {
    //  await loadDetailedPosTById(postId);
    return detailedPost!.myReactions.contains('like');
  }

  loadAuthorName(String postId) async {
    //  await loadDetailedPosTById(postId);
    return detailedPost!.author.displayName;
  }

  loadAuthorProfileImage(String postId) async {
    //   await loadDetailedPosTById(postId);
    return detailedPost!.author.avatarUrl;
  }

  loadAuthorId(String postId) async {
    //  await loadDetailedPosTById(postId);
    return detailedPost!.author.userId;
  }

  loadAuthorPostText(String postId) async {
    //  await loadDetailedPosTById(postId);
    return detailedPost!.text;
  }

  Future<String?> loadAuthorPostImage(String postId) async {
    // await loadDetailedPosTById(postId);
    var mediaListlength = detailedPost!.attachments.length;
    return mediaListlength > 0 ? detailedPost!.attachments[0].imageUrl : null;
  }

  loadNumOfComments(String postId) async {
    //  await loadDetailedPosTById(postId);
    return detailedPost!.commentsCount.toString();
  }

  loadNumofLikes(String postId) async {
    //  await loadDetailedPosTById(postId);
    var output = detailedPost!.reactionsCount["like"].toString();

    return output == 'null' ? '0' : output;
  }

  loadPostActivityId(String postId) async {
    //   await loadDetailedPosTById(postId);
    return detailedPost!.id;
  }

  loadRankingTitle() {
    return 'rank 2 in running this month';
  }
}
