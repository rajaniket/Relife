// ignore_for_file: prefer_const_constructors

import 'dart:developer';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getsocial_flutter_sdk/common/pagingquery.dart';
import 'package:getsocial_flutter_sdk/communities.dart';
import 'package:getsocial_flutter_sdk/communities/activity.dart';
import 'package:getsocial_flutter_sdk/communities/queries/usersquery.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/model/service%20model/others_profile_model.dart';
import 'package:relife/model/ui%20model/comments.dart';
import 'package:relife/providers/others_profile_provider.dart';
import 'package:relife/providers/post_provider.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/ui/pages/profile/other_user_profile.dart';
import 'package:relife/ui/pages/profile/profile_page.dart';
import 'package:relife/ui/pages/tabs/bottom_navigation_page.dart.dart';
import 'package:relife/ui/widgets/progress_loader.dart';
import 'package:shimmer/shimmer.dart';

// class PostFullViewPage extends StatefulWidget {
//   final String? personName, personRank, numberOfLikes, numOfComments;
//   final String? profileImageUrl;
//   final String? message;
//   final String? postImageUrl;
//   final String postId;
//   final int? postIndex;
//   final CommentItems? comments;
//   final bool? isLikedByMe;
//   final bool? isNotificationPost;
//   final Function(String numOflikes, bool isLikedByMe, String numOfComments,
//           List<GetSocialActivity>? postCommentsList)?
//       alertAboutLikesAndCommentsChanges;
//   final Function()? setNotificationReadStatusTrue;

//   const PostFullViewPage({
//     Key? key,
//     this.personName,
//     this.personRank,
//     this.message,
//     this.comments,
//     this.numberOfLikes,
//     this.numOfComments,
//     this.profileImageUrl,
//     this.postImageUrl,
//     required this.postId,
//     this.postIndex,
//     this.isLikedByMe,
//     this.alertAboutLikesAndCommentsChanges,
//     this.isNotificationPost = false,
//     this.setNotificationReadStatusTrue,
//   }) : super(key: key);

//   @override
//   State<PostFullViewPage> createState() => _PostFullViewPageState();
// }

// class _PostFullViewPageState extends State<PostFullViewPage> {
//   final _textEditingController = TextEditingController();
//   //String _typedComment = '';
//   ValueNotifier<String> _typedComment = ValueNotifier<String>("");
//   late bool isLikedByMe;
//   late String personName;
//   String? personRank;
//   String? profileImageUrl;
//   late String numberOfLikes;
//   late String numOfComments;
//   String? message;
//   String? postImageUrl;
//   late String postId;
//   int? postIndex;
//   List<GetSocialActivity>? postCommentsList;
//   late GetSocialActivity _activity;
//   final _scrollController = ScrollController();
//   String? _topic = "";
//   int? _ranking;
//   String? _relifeUserId; // from our backend
//   String? currentStreak;
//   GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();
//   List<Map<String, dynamic>> mentionData = [];
//   bool isLoadingComplete = false;
//   bool showRankShimmer = true;
//   late Future<bool> loadPostData;

//   // void updateLikeAndComments() async {
//   //   await Provider.of<DetailedPostProvider>(context, listen: false)
//   //       .loadAllComments(widget.postId);
//   //   await Provider.of<DetailedPostProvider>(context, listen: false)
//   //       .loadDetailedPosTById(widget.postId);
//   //   // print("_+_+_+_+_+_+_+_+_+_  initSyate");

//   //   setState(() {
//   //     _isLoading = false;
//   //   });
//   // }

//   Future<bool> _loadData() async {
//     postId = widget.postId;
//     // _activity = await Provider.of<DetailedPostProvider>(context, listen: false)
//     //     .loadDetailedPosTById(postId);
//     // postCommentsList =
//     //     await Provider.of<DetailedPostProvider>(context, listen: false)
//     //         .loadAllComments(postId);
//     await Future.wait(
//       [
//         Provider.of<DetailedPostProvider>(context, listen: false)
//             .loadDetailedPosTById(postId)
//             .then((result) {
//           _activity = result;
//         }),
//         Provider.of<DetailedPostProvider>(context, listen: false)
//             .loadAllComments(postId)
//             .then((value) {
//           postCommentsList = value;
//         }),
//       ],
//     );

//     personName = _activity.author.displayName;
//     profileImageUrl = _activity.author.avatarUrl;

//     numberOfLikes = _activity.reactionsCount["like"].toString() == 'null'
//         ? '0'
//         : _activity.reactionsCount["like"].toString();
//     numOfComments = _activity.commentsCount.toString();
//     message = _activity.text;
//     postImageUrl = _activity.attachments.isNotEmpty
//         ? _activity.attachments[0].imageUrl
//         : null;
//     isLikedByMe = _activity.myReactions.contains('like');

//     _topic = _activity.source.title;

//     // _relifeUserId = _activity.author.identities["relife_userId"]!;
//     if (_activity.properties.isNotEmpty) {
//       currentStreak = _activity.properties["streak"];
//     }
//     getRankTitle();

//     // if (this.mounted) {
//     //   setState(() {
//     //     _isLoading = false;
//     //   });
//     // }

//     return true;
//   }

//   getRankTitle() async {
//     if (_activity.author.identities["relife_userId"] != null) {
//       try {
//         // relife_userId is null for relife_app or if posted from dashboard
//         _relifeUserId = _activity.author.identities["relife_userId"]!;
//         // await Provider.of<OthersProfileProvider>(context, listen: false)
//         //     .getProfile(_relifeUserId!);

//         // OthersProfileModel? othersProfileModel =
//         //     Provider.of<OthersProfileProvider>(context, listen: false)
//         //         .othersProfileModel;
//         // if (othersProfileModel != null) {
//         //   for (int i = 0; i < othersProfileModel.details.habits.length; i++) {
//         //     if (othersProfileModel.details.habits[i].habitDetails.name ==
//         //         _topic) {
//         //       _ranking = othersProfileModel
//         //           .details.habits[i].habitDetails.leaderboardRank;
//         //       break;
//         //     }
//         //   }
//         // }

//         // personRank = "rank $_ranking in $_topic this month";
//       } catch (e) {
//         print("_______________ _______ _______ error: $e");
//       }
//     }
//     setState(() {
//       showRankShimmer = false;
//     });
//   }

//   Future<bool> onLikeButtonTapped(bool isLiked) async {
//     // isLiked ==> means state before button is pressed
//     if (!isLiked) {
//       Provider.of<DetailedPostProvider>(context, listen: false)
//           .setReaction(widget.postId);
//       isLikedByMe = true;
//       numberOfLikes = (int.parse(numberOfLikes) + 1).toString();
//     } else {
//       Provider.of<DetailedPostProvider>(context, listen: false)
//           .removeReaction(widget.postId);
//       isLikedByMe = false;
//       numberOfLikes = (int.parse(numberOfLikes) - 1).toString();
//     }
//     // log(_isLikedByMe.toString());
//     // log((!isLiked).toString());
//     // log("_______------_---_-_--");
//     return !isLiked;
//   }

//   postComments() async {
//     // postCommentsList =
//     //     await Provider.of<DetailedPostProvider>(context, listen: false)
//     //         .loadAllComments(postId);

//     postCommentsList =
//         await Provider.of<DetailedPostProvider>(context, listen: false)
//             .postNewComment(_typedComment.value, postId);
//     numOfComments = postCommentsList!.length.toString();

//     if (mounted) {
//       setState(() {});
//     }

//     // widget.alertAboutLikesAndCommentsChanges(
//     //     numberOfLikes, isLikedByMe, numOfComments, postCommentsList);
//     // print("- - - -  -   -  $numberOfLikes $numOfComments $isLikedByMe ");
//   }

//   @override
//   initState() {
//     loadPostData = _loadData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     print("_________________________________-  jjj");
//     return WillPopScope(
//       onWillPop: () async {
//         if (!widget.isNotificationPost!) {
//           widget.alertAboutLikesAndCommentsChanges!(
//               numberOfLikes, isLikedByMe, numOfComments, postCommentsList);
//           Navigator.pop(context);
//         } else if (widget.isNotificationPost!) {
//           widget.setNotificationReadStatusTrue;
//           Navigator.pop(context);
//         } else {
//           Navigator.pushReplacement(context,
//               MaterialPageRoute(builder: (_) => BottomNavigationPage()));
//         }
//         return true;
//       },
//       child: Builder(
//         builder: (context) {
//           return Scaffold(
//             bottomNavigationBar: isLoadingComplete
//                 ? BottomAppBar(
//                     color: const Color(0xffF7F6F2),
//                     elevation: 0,
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           bottom: MediaQuery.of(context).viewInsets.bottom),
//                       child: Container(
//                         width: MediaQuery.of(context).size.width,
//                         padding: EdgeInsets.only(
//                             left: 13.w, right: 13.w, bottom: 8.h, top: 5.h),
//                         decoration: BoxDecoration(
//                           color: Colors.white,

//                           borderRadius:
//                               BorderRadius.vertical(top: Radius.circular(25)), //25
//                         ),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 border: Border.all(
//                                     width: 2.r, color: const Color(0xffFA8A3C)),
//                                 shape: BoxShape.circle,
//                               ),
//                               child: ClipOval(
//                                 child: SizedBox(
//                                   height: 38.0.r,
//                                   width: 38.0.r,
//                                   child: profileImageUrl == null
//                                       ? CachedNetworkImage(
//                                           imageUrl:
//                                               'https://p.kindpng.com/picc/s/24-248549_vector-graphics-computer-icons-clip-art-user-profile.png',
//                                           progressIndicatorBuilder:
//                                               (context, url, downloadProgress) =>
//                                                   Center(
//                                             child: CircularProgressIndicator(
//                                                 value: downloadProgress.progress),
//                                           ),
//                                           errorWidget: (context, url, error) =>
//                                               const Icon(Icons.error),
//                                         )
//                                       : CachedNetworkImage(
//                                           imageUrl:
//                                               "https://relife.co.in/api/${Provider.of<ProfileProvider>(context, listen: false).profilePicture}",
//                                           key: ValueKey<String>(
//                                               Provider.of<ProfileProvider>(context,
//                                                       listen: false)
//                                                   .key),
//                                           progressIndicatorBuilder:
//                                               (context, url, downloadProgress) =>
//                                                   Center(
//                                             child: CircularProgressIndicator(
//                                                 value: downloadProgress.progress),
//                                           ),
//                                           errorWidget: (context, url, error) =>
//                                               const Icon(Icons.error),
//                                         ),
//                                 ),
//                               ),
//                             ),
//                             SizedBox(
//                               width: 10.w,
//                             ),
//                             Expanded(child: _buildTextField),
//                             SizedBox(
//                               width: 10.w,
//                             ),
//                             Material(
//                               color: Colors.transparent,
//                               child: ValueListenableBuilder(
//                                   valueListenable: _typedComment,
//                                   builder: (context, val, child) {
//                                     return InkWell(
//                                       borderRadius: BorderRadius.circular(5.r),
//                                       onTap: _typedComment.value != ''
//                                           ? () {
//                                               if (_typedComment.value != '') {
//                                                 // _textEditingController.clear();

//                                                 // Provider.of<DetailedPostProvider>(
//                                                 //         context,
//                                                 //         listen: false)
//                                                 //     .postNewComment(
//                                                 //         _typedComment, postId);
//                                                 postComments();
//                                                 setState(() {
//                                                   _typedComment.value = '';
//                                                 });
//                                                 key.currentState!.controller!
//                                                     .clear();
//                                                 // loadComments();
//                                                 // alerting post in feed for rebuilding

//                                                 _scrollController.animateTo(
//                                                   _scrollController
//                                                       .position.maxScrollExtent,
//                                                   duration:
//                                                       Duration(milliseconds: 500),
//                                                   curve: Curves.fastOutSlowIn,
//                                                 );
//                                               }
//                                             }
//                                           : null,
//                                       child: Text(
//                                         'post',
//                                         style: TextStyle(
//                                             fontSize: 18.sp,
//                                             fontWeight: FontWeight.w500,
//                                             color: _typedComment.value != ''
//                                                 ? AppColors.buttonColor
//                                                 : AppColors.buttonColor
//                                                     .withOpacity(0.5)),
//                                       ),
//                                     );
//                                   }),
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   )
//                 : null,
//             appBar: AppBar(
//               backgroundColor: Colors.transparent,
//               toolbarHeight: 0,
//               elevation: 0,
//               automaticallyImplyLeading: false,
//               systemOverlayStyle: const SystemUiOverlayStyle(
//                 statusBarColor: Color(0xffF7F6F2),
//                 statusBarIconBrightness:
//                     Brightness.dark, // For Android (dark icons)
//                 statusBarBrightness: Brightness.light, // For iOS (dark icons)
//               ),
//             ),
//             backgroundColor: const Color(0xffF7F6F2),
//     body: FutureBuilder(
//         future: loadPostData,
//         builder: (context, snap) {
//           print("______________  k kk +++++");
//           if (snap.connectionState == ConnectionState.done) {
//             if (snap.hasData) {
//               // Future.delayed(Duration.zero, () async {
//               //   setState(() {
//               //     isLoadingComplete = true;
//               //   });
//               // });
//               return NotificationListener<OverscrollIndicatorNotification>(
//                 onNotification:
//                     (OverscrollIndicatorNotification overscroll) {
//                   overscroll.disallowIndicator();
//                   return false;
//                 },
//                 child: SingleChildScrollView(
//                     controller: _scrollController,
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                               top: 5.h, left: 8.w, right: 10.w),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             children: [
//                               CircleAvatar(
//                                 backgroundColor: Colors.white,
//                                 radius: 16.r,
//                                 child: IconButton(
//                                   onPressed: () {
//                                     if (!widget.isNotificationPost!) {
//                                       widget.alertAboutLikesAndCommentsChanges!(
//                                           numberOfLikes,
//                                           isLikedByMe,
//                                           numOfComments,
//                                           postCommentsList);
//                                       Navigator.pop(context);
//                                     } else if (widget.isNotificationPost!) {
//                                       widget.setNotificationReadStatusTrue;
//                                       Navigator.pop(context);
//                                     } else {
//                                       Navigator.pushReplacement(
//                                           context,
//                                           MaterialPageRoute(
//                                               builder: (_) =>
//                                                   BottomNavigationPage()));
//                                     }
//                                   },
//                                   icon: const Icon(
//                                     Icons.arrow_back_ios_new_outlined,
//                                     size: 18,
//                                     color: Colors.black,
//                                   ),
//                                   splashRadius: 25.r,
//                                   constraints: const BoxConstraints(),
//                                 ),
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Expanded(child: _buildProfileRow()),
//                             ],
//                           ),
//                         ),
//                         SizedBox(
//                           height: 10.h,
//                         ),
//                         // _buildPostMessage(),
//                         Padding(
//                           padding: EdgeInsets.only(
//                               left: 15.w, right: 15.w, bottom: 15.h),
//                           child: Container(
//                             padding: EdgeInsets.all(14.r),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(24.0.r),
//                               color: Colors.transparent,
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 if (message != null)
//                                   Padding(
//                                     padding: EdgeInsets.symmetric(
//                                         horizontal: 8.w),
//                                     child: _buildPostMessage(),
//                                   ),
//                                 if (postImageUrl != null)
//                                   SizedBox(
//                                     height: 12.h,
//                                   ),
//                                 if (postImageUrl != null)
//                                   Center(
//                                     child: ClipRRect(
//                                         borderRadius:
//                                             BorderRadius.circular(24.0.r),
//                                         child: CachedNetworkImage(
//                                           imageUrl: postImageUrl!,
//                                           fit: BoxFit.cover,
//                                         )),
//                                   ),
//                                 SizedBox(
//                                   height: 20.0.h,
//                                 ),
//                                 Padding(
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 8.0.w),
//                                   child: _buildLikeRow(),
//                                 ),
//                                 // SizedBox(
//                                 //   height: 17.0.h,
//                                 // ),
//                                 SizedBox(
//                                   height: 5.0.h,
//                                 ),
//                                 Divider(
//                                   thickness: 1,
//                                 ),
//                                 SizedBox(
//                                   height: 5.0.h,
//                                 ),
//                                 // if (_isLoading == true)
//                                 //   const Center(
//                                 //       child: CircularProgressIndicator(
//                                 //     color: AppColors.buttonColor,
//                                 //   )),
//                                 // if (_isLoading != true)
//                                 Column(
//                                   children: [
//                                     for (int index =
//                                             (postCommentsList!.length - 1);
//                                         index >= 0;
//                                         index--)
//                                       _buildComment(
//                                           authorName:
//                                               postCommentsList![index]
//                                                   .author
//                                                   .displayName,
//                                           comment: postCommentsList![index]
//                                               .text!,
//                                           authorPic:
//                                               postCommentsList![index]
//                                                   .author
//                                                   .avatarUrl,
//                                           authorId: postCommentsList![index]
//                                               .author
//                                               .userId),
//                                   ],
//                                 ),

//                                 // const Spacer(), //this will take all blank space and will send the textfield in the bottom
//                               ],
//                             ),
//                           ),
//                         ),
//                       ],
//                     )),
//               );
//             } else if (snap.hasError) {
//               return Center(child: Text("something went wrong"));
//             }
//           }
//           return const Center(child: CircularProgressIndicator());
//         }),
//   );
// }
//       ),
//     );
//   }

//   get _buildTextField {
//     return FlutterMentions(
//       key: key,
//       // controller: _textEditingController,
//       onChanged: (val) {
//         // setState(() {
//         //   _typedComment = val.trim();
//         // });
//       },
//       suggestionListDecoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(
//           color: Colors.black12,
//         ),
//         borderRadius: BorderRadius.circular(30),
//       ),
//       suggestionPosition: SuggestionPosition.Top,
//       suggestionListHeight: 200,
//       decoration: InputDecoration(
//         hintText: 'add a comment',
//         hintStyle: TextStyle(
//           fontSize: 12.0.sp,
//           fontWeight: FontWeight.w300,
//         ),
//         contentPadding: EdgeInsets.only(
//             left: 16.0.w, right: 16.0.w, top: 10.0.h, bottom: 9.0.h),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(15.0.r),
//           borderSide: BorderSide.none,
//         ),
//         filled: true,
//         fillColor: AppColors.bottomSheetTextFieldColor,
//       ),
//       onMentionAdd: (data) {},
//       onMarkupChanged: (val) {
//         // setState(() {
//         //   _typedComment = val.trim();
//         // });
//         _typedComment.value = val.trim();
//         // print("____________________ $_typedComment");
//       },
//       onSearchChanged: (val1, val2) {
//         var query = UsersQuery.find(val2);
//         var pagingQuery = PagingQuery(query);
//         pagingQuery.limit = 20;
//         Communities.findUsers(pagingQuery).then((result) {
//           var userList = result.entries;

//           print(userList);
//           for (var userDetail in userList) {
//             if (!(mentionData.any((e) => e["id"] == userDetail.userId))) {
//               mentionData.add({
//                 'id': userDetail.userId,
//                 'display': userDetail.displayName,
//                 'full_name': userDetail.displayName,
//                 'photo': userDetail.avatarUrl,
//               });
//             }
//           }
//           setState(() {});
//         }).catchError((error) => print('Failed to find users, error: $error'));
//       },
//       mentions: [
//         Mention(
//           trigger: '@',
//           style: const TextStyle(
//             color: Color(0xff062540),
//             fontWeight: FontWeight.w500, //Color(0xffFA8A3C),
//           ),
//           disableMarkup: false,
//           data: mentionData.toList(),
//           matchAll: false,
//           suggestionBuilder: (data) {
//             return Container(
//               padding: const EdgeInsets.all(10.0),
//               child: ListTile(
//                 leading: Container(
//                   decoration: BoxDecoration(
//                     border: Border.all(
//                       color: Color(0xffFA8A3C),
//                     ),
//                     shape: BoxShape.circle,
//                   ),
//                   child: CircleAvatar(
//                     backgroundColor: Colors.transparent,
//                     backgroundImage: NetworkImage(
//                       data['photo'],
//                     ),
//                   ),
//                 ),
//                 title: Text(data['full_name']),
//               ),
//             );
//           },
//         ),
//         // Mention(
//         //   trigger: '#',
//         //   disableMarkup: true,
//         //   style: const TextStyle(
//         //     color: Colors.blue,
//         //   ),
//         //   data: [
//         //     {'id': 'reactjs', 'display': 'reactjs'},
//         //     {'id': 'javascript', 'display': 'javascript'},
//         //   ],
//         //   matchAll: true,
//         // )
//       ],
//     );
//   }

//   _buildPostMessage() {
//     // return Text(
//     //   message!,
//     //   style: TextStyle(
//     //     fontSize: 12.sp,
//     //     fontWeight: FontWeight.w400,
//     //   ),
//     // );
//     return ExpandableText(
//       message!,
//       expandText: "see more",
//       collapseText: "See Less",
//       style: TextStyle(
//         fontSize: 12.sp,
//         fontWeight: FontWeight.w400,
//       ),
//       urlStyle: TextStyle(
//         fontSize: 12.sp,
//         fontWeight: FontWeight.w400,
//         color: Colors.blue,
//       ),
//       linkStyle: TextStyle(
//         fontSize: 12.sp,
//         fontWeight: FontWeight.w600,
//         color: Color(0xffF08A5D),
//       ),
//       mentionStyle: TextStyle(
//         fontSize: 12.sp,
//         fontWeight: FontWeight.w500,
//         color: Colors.black,
//       ),
//       onMentionTap: (data) {
//         // print("_____________________-- $data");
//         // print(_activity.mentions);
//       },
//       maxLines: 8,
//       onUrlTap: (link) async {
//         String url = link;
//         bool isEmail = link.contains("@");
//         if (!isEmail) {
//           if (!Uri.parse(url).hasScheme) {
//             url = "http://" + link;
//           }
//         }
//         bool _validURL = Uri.parse(url).isAbsolute;
//         if (isEmail) {
//         } else if (_validURL) {
//           try {
//             await launch(
//               url,
//               customTabsOption: const CustomTabsOption(
//                 toolbarColor: Color(0xffF7F6F2),
//                 enableDefaultShare: true,
//                 enableUrlBarHiding: true,
//                 showPageTitle: true,
//                 extraCustomTabs: <String>[
//                   // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
//                   'org.mozilla.firefox',
//                   // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
//                   'com.microsoft.emmx',
//                 ],
//               ),
//             );
//           } catch (e) {
//             // rethrow;
//           }
//         }
//       },
//     );
//   }

//   Row _buildProfileRow() {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.center,
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Expanded(
//           child: Row(
//             children: [
//               GestureDetector(
//                 onTap: () async {
//                   if (_relifeUserId != null) {
//                     final personalProfile =
//                         Provider.of<ProfileProvider>(context, listen: false);
//                     if (_relifeUserId == personalProfile.userId) {
//                       Navigator.push(context, MaterialPageRoute(builder: (_) {
//                         return const ProfilePage();
//                       }));
//                     } else {
//                       final otherProfile = Provider.of<OthersProfileProvider>(
//                           context,
//                           listen: false);
//                       CustomProgressIndicator().buildShowDialog(context);
//                       await otherProfile.getProfile(_relifeUserId!);
//                       Navigator.pop(context);
//                       Navigator.push(context, MaterialPageRoute(builder: (_) {
//                         return OtherProfilePage(id: _relifeUserId!);
//                       }));
//                     }
//                   }
//                 },
//                 child: Container(
//                   decoration: BoxDecoration(
//                     border:
//                         Border.all(width: 2.r, color: const Color(0xffFA8A3C)),
//                     shape: BoxShape.circle,
//                   ),
//                   child: ClipOval(
//                     child: SizedBox(
//                       height: 48.0.r,
//                       width: 48.0.r,
//                       child: CachedNetworkImage(
//                         imageUrl: profileImageUrl!,
//                         progressIndicatorBuilder:
//                             (context, url, downloadProgress) => Center(
//                           child: CircularProgressIndicator(
//                               value: downloadProgress.progress),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 width: 10,
//               ),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () async {
//                         if (_relifeUserId != null) {
//                           final personalProfile = Provider.of<ProfileProvider>(
//                               context,
//                               listen: false);
//                           if (_relifeUserId == personalProfile.userId) {
//                             Navigator.push(context,
//                                 MaterialPageRoute(builder: (_) {
//                               return const ProfilePage();
//                             }));
//                           } else {
//                             final otherProfile =
//                                 Provider.of<OthersProfileProvider>(context,
//                                     listen: false);
//                             CustomProgressIndicator().buildShowDialog(context);
//                             await otherProfile.getProfile(_relifeUserId!);
//                             Navigator.pop(context);
//                             Navigator.push(context,
//                                 MaterialPageRoute(builder: (_) {
//                               return OtherProfilePage(id: _relifeUserId!);
//                             }));
//                           }
//                         }
//                       },
//                       child: Text(
//                         personName,
//                         style: TextStyle(
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w700,
//                             color: const Color(0xff062540)),
//                       ),
//                     ),
//                     // if (personRank != null)
//                     //   Text(
//                     //     personRank!,
//                     //     style: TextStyle(
//                     //         fontSize: 12.sp,
//                     //         fontWeight: FontWeight.w400,
//                     //         color: const Color(0xff062540)),
//                     //   )
//                     AnimatedSwitcher(
//                       duration: const Duration(milliseconds: 300),
//                       reverseDuration: const Duration(milliseconds: 00),
//                       child: personRank != null
//                           ? Text(
//                               // widget.personRank,
//                               personRank!,
//                               style: TextStyle(
//                                   fontSize: 12.sp,
//                                   fontWeight: FontWeight.w400,
//                                   color: const Color(0xff062540)),
//                             )
//                           : Visibility(
//                               visible: _activity
//                                       .author.identities["relife_userId"] !=
//                                   null,
//                               child: Padding(
//                                 padding:
//                                     const EdgeInsets.only(right: 30, top: 5),
//                                 child: Shimmer.fromColors(
//                                   baseColor: Color.fromARGB(255, 232, 228, 228),
//                                   highlightColor:
//                                       Color.fromARGB(255, 246, 238, 238),
//                                   enabled: true,
//                                   child: Container(
//                                     height: 8,
//                                     decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(7),
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                     )
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//         if (currentStreak != null && currentStreak != "")
//           Container(
//             decoration: BoxDecoration(
//                 color: const Color(0xffF08A5D).withOpacity(0.2),
//                 borderRadius: BorderRadius.circular(12.r)),
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
//             child: Center(
//               child: Row(
//                 children: [
//                   Text(
//                     // widget.personRank,
//                     currentStreak!,
//                     style: TextStyle(
//                         fontSize: 12.5,
//                         fontWeight: FontWeight.w400,
//                         color: Color(0xff062540)),
//                   ),
//                   SizedBox(
//                     width: 3,
//                   ),
//                   Center(
//                     child: Padding(
//                       padding: const EdgeInsets.only(bottom: 3),
//                       child: SvgPicture.asset(
//                         AppAssets.fireIcon,
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           )
//         // IconButton(
//         //   onPressed: () {},
//         //   splashRadius: 20.sp,
//         //   constraints: const BoxConstraints(),
//         //   icon: RotatedBox(
//         //     quarterTurns: 1,
//         //     child: SvgPicture.asset(
//         //       AppAssets.seeMoreIcon,
//         //       height: 20.sp,
//         //       color: const Color(0xff062540),
//         //     ),
//         //   ),
//         // )
//       ],
//     );
//   }

//   Row _buildLikeRow() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             LikeButton(
//               size: 22.54.h,
//               circleColor: const CircleColor(
//                   start: Color(0xffF08A5D), end: Color(0xffF08A5D)),
//               likeBuilder: (bool isLiked) {
//                 return isLiked
//                     ? SvgPicture.asset(
//                         AppAssets.heartFilled,
//                         height: 22.54.h,
//                       )
//                     : SvgPicture.asset(
//                         AppAssets.heart,
//                         height: 22.54.h,
//                       );
//               },
//               isLiked: isLikedByMe,
//               likeCount: int.parse(numberOfLikes),
//               likeCountPadding: EdgeInsets.only(left: 4.w),
//               countBuilder: (count, isLiked, text) {
//                 return Text(
//                   text,
//                   style: TextStyle(
//                     fontSize: 12.sp,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 );
//               },
//               onTap: onLikeButtonTapped,
//             ),
//             SizedBox(
//               width: 6.25.w,
//             ),
//             Padding(
//               padding: EdgeInsets.only(right: 4.w),
//               child: SvgPicture.asset(
//                 AppAssets.comment,
//                 height: 22.54.h,
//               ),
//             ),
//             Text(
//               numOfComments,
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w400,
//               ),
//             )
//           ],
//         ),
//         // IconButton(
//         //   onPressed: () {},
//         //   padding: EdgeInsets.only(right: 4.w),
//         //   constraints: const BoxConstraints(), //to remove the padding
//         //   icon: SvgPicture.asset(
//         //     AppAssets.shareIcon,
//         //     height: 22.54.h,
//         //   ),
//         // ),
//       ],
//     );
//   }

//   Padding _buildComment({
//     required String comment,
//     required String authorName,
//     required String? authorPic,
//     required String authorId,
//   }) {
//     return Padding(
//       padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w, bottom: 12.0.h),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(width: 1.r, color: const Color(0xffFA8A3C)),
//               shape: BoxShape.circle,
//             ),
//             child: ClipOval(
//               child: SizedBox(
//                 height: 19.25.r,
//                 width: 19.25.r,
//                 child: profileImageUrl == null
//                     ? CachedNetworkImage(
//                         imageUrl:
//                             'https://p.kindpng.com/picc/s/24-248549_vector-graphics-computer-icons-clip-art-user-profile.png',
//                         progressIndicatorBuilder:
//                             (context, url, downloadProgress) => Center(
//                           child: CircularProgressIndicator(
//                               value: downloadProgress.progress),
//                         ),
//                         errorWidget: (context, url, error) =>
//                             const Icon(Icons.error),
//                       )
//                     : CachedNetworkImage(
//                         imageUrl: authorPic!,
//                         progressIndicatorBuilder:
//                             (context, url, downloadProgress) => Center(
//                           child: CircularProgressIndicator(
//                               value: downloadProgress.progress),
//                         ),
//                         errorWidget: (context, url, error) =>
//                             const Icon(Icons.error),
//                       ),
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 6.75.w,
//           ),
//           Flexible(
//             child: ExpandableText(
//               " $comment",
//               prefixText: authorName,
//               prefixStyle: TextStyle(
//                 fontSize: 12.0.sp,
//                 fontWeight: FontWeight.w500,
//               ),
//               onPrefixTap: () async {
//                 // final personalProfile =
//                 //     Provider.of<ProfileProvider>(context, listen: false);
//                 // if (authorId == personalProfile.userId) {
//                 //   Navigator.push(context, MaterialPageRoute(builder: (_) {
//                 //     return const ProfilePage();
//                 //   }));
//                 // } else {
//                 //   final otherProfile = Provider.of<OthersProfileProvider>(
//                 //       context,
//                 //       listen: false);
//                 //   CustomProgressIndicator().buildShowDialog(context);
//                 //   await otherProfile.getProfile(authorId);
//                 //   Navigator.pop(context);
//                 //   Navigator.push(context, MaterialPageRoute(builder: (_) {
//                 //     return OtherProfilePage(id: authorId);
//                 //   }));
//                 // }
//               },
//               expandText: "see more",
//               collapseText: "See Less",
//               style: TextStyle(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w400,
//               ),
//               urlStyle: TextStyle(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.blue,
//               ),
//               linkStyle: TextStyle(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w500,
//                 color: const Color(0xffF08A5D),
//               ),
//               mentionStyle: TextStyle(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//               hashtagStyle: TextStyle(
//                 fontSize: 12.sp,
//                 fontWeight: FontWeight.w500,
//                 color: Colors.black,
//               ),
//               onMentionTap: (data) {
//                 // print("_____________________-- $data");
//                 // print(_activity.mentions);
//               },
//               maxLines: 8,
//               onUrlTap: (link) async {
//                 String url = link;
//                 bool isEmail = link.contains("@");
//                 if (!isEmail) {
//                   if (!Uri.parse(url).hasScheme) {
//                     url = "http://" + link;
//                   }
//                 }
//                 bool _validURL = Uri.parse(url).isAbsolute;
//                 if (isEmail) {
//                 } else if (_validURL) {
//                   try {
//                     await launch(
//                       url,
//                       customTabsOption: const CustomTabsOption(
//                         toolbarColor: Color(0xffF7F6F2),
//                         enableDefaultShare: true,
//                         enableUrlBarHiding: true,
//                         showPageTitle: true,
//                         extraCustomTabs: <String>[
//                           // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
//                           'org.mozilla.firefox',
//                           // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
//                           'com.microsoft.emmx',
//                         ],
//                       ),
//                     );
//                   } catch (e) {
//                     // rethrow;
//                   }
//                 }
//               },
//             ),
//           )
//           // Flexible(
//           //   child: RichText(
//           //       text: TextSpan(
//           //     style:
//           //         const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
//           //     children: [
//           //       TextSpan(
//           //         text: authorName,
//           //         style: TextStyle(
//           //           fontSize: 12.0.sp,
//           //           fontWeight: FontWeight.w500,
//           //         ),
//           //       ),
//           //       TextSpan(
//           //         text: ' $comment',
//           // style: TextStyle(
//           //   fontSize: 12.0.sp,
//           //   fontWeight: FontWeight.w400,
//           // ),
//           //       ),

//           //     ],
//           //   )),
//           // )
//         ],
//       ),
//     );
//   }
// }

class PostFullViewPage extends StatefulWidget {
  final String? personName, personRank, numberOfLikes, numOfComments;
  final String? profileImageUrl;
  final String? message;
  final String? postImageUrl;
  final String postId;
  final int? postIndex;
  final CommentItems? comments;
  final bool? isLikedByMe;
  final bool? isNotificationPost;
  final Function(String numOflikes, bool isLikedByMe, String numOfComments,
          List<GetSocialActivity>? postCommentsList)?
      alertAboutLikesAndCommentsChanges;
  final Function()? setNotificationReadStatusTrue;

  const PostFullViewPage({
    Key? key,
    this.personName,
    this.personRank,
    this.message,
    this.comments,
    this.numberOfLikes,
    this.numOfComments,
    this.profileImageUrl,
    this.postImageUrl,
    required this.postId,
    this.postIndex,
    this.isLikedByMe,
    this.alertAboutLikesAndCommentsChanges,
    this.isNotificationPost = false,
    this.setNotificationReadStatusTrue,
  }) : super(key: key);

  @override
  State<PostFullViewPage> createState() => _PostFullViewPageState();
}

class _PostFullViewPageState extends State<PostFullViewPage> {
  final _textEditingController = TextEditingController();
  //String _typedComment = '';
  ValueNotifier<String> _typedComment = ValueNotifier<String>("");
  late bool isLikedByMe;
  late String personName;
  String? personRank;
  String? profileImageUrl;
  late String numberOfLikes;
  late String numOfComments;
  String? message;
  String? postImageUrl;
  late String postId;
  int? postIndex;
  List<GetSocialActivity>? postCommentsList;
  late GetSocialActivity _activity;
  final _scrollController = ScrollController();
  String? _topic = "";
  int? _ranking;
  String? _relifeUserId; // from our backend
  String? currentStreak;
  GlobalKey<FlutterMentionsState> key = GlobalKey<FlutterMentionsState>();
  List<Map<String, dynamic>> mentionData = [];
  bool isLoadingComplete = false;
  bool showRankShimmer = true;
  late Future<bool> loadPostData;

  // void updateLikeAndComments() async {
  //   await Provider.of<DetailedPostProvider>(context, listen: false)
  //       .loadAllComments(widget.postId);
  //   await Provider.of<DetailedPostProvider>(context, listen: false)
  //       .loadDetailedPosTById(widget.postId);
  //   // print("_+_+_+_+_+_+_+_+_+_  initSyate");

  //   setState(() {
  //     _isLoading = false;
  //   });
  // }

  Future<bool> _loadData() async {
    postId = widget.postId;
    // _activity = await Provider.of<DetailedPostProvider>(context, listen: false)
    //     .loadDetailedPosTById(postId);
    // postCommentsList =
    //     await Provider.of<DetailedPostProvider>(context, listen: false)
    //         .loadAllComments(postId);
    await Future.wait(
      [
        Provider.of<DetailedPostProvider>(context, listen: false)
            .loadDetailedPosTById(postId)
            .then((result) {
          _activity = result;
        }),
        Provider.of<DetailedPostProvider>(context, listen: false)
            .loadAllComments(postId)
            .then((value) {
          postCommentsList = value;
        }),
      ],
    );

    personName = _activity.author.displayName;
    profileImageUrl = _activity.author.avatarUrl;

    numberOfLikes = _activity.reactionsCount["like"].toString() == 'null'
        ? '0'
        : _activity.reactionsCount["like"].toString();
    numOfComments = _activity.commentsCount.toString();
    message = _activity.text;
    postImageUrl = _activity.attachments.isNotEmpty
        ? _activity.attachments[0].imageUrl
        : null;
    isLikedByMe = _activity.myReactions.contains('like');

    _topic = _activity.source.title;

    // _relifeUserId = _activity.author.identities["relife_userId"]!;
    if (_activity.properties.isNotEmpty) {
      currentStreak = _activity.properties["streak"];
    }
    getRankTitle();

    // if (this.mounted) {
    //   setState(() {
    //     _isLoading = false;
    //   });
    // }

    return true;
  }

  getRankTitle() async {
    if (_activity.author.identities["relife_userId"] != null) {
      try {
        // relife_userId is null for relife_app or if posted from dashboard
        _relifeUserId = _activity.author.identities["relife_userId"]!;
        // await Provider.of<OthersProfileProvider>(context, listen: false)
        //     .getProfile(_relifeUserId!);

        // OthersProfileModel? othersProfileModel =
        //     Provider.of<OthersProfileProvider>(context, listen: false)
        //         .othersProfileModel;
        // if (othersProfileModel != null) {
        //   for (int i = 0; i < othersProfileModel.details.habits.length; i++) {
        //     if (othersProfileModel.details.habits[i].habitDetails.name ==
        //         _topic) {
        //       _ranking = othersProfileModel
        //           .details.habits[i].habitDetails.leaderboardRank;
        //       break;
        //     }
        //   }
        // }

        // personRank = "rank $_ranking in $_topic this month";
      } catch (e) {
        print("_______________ _______ _______ error: $e");
      }
    }
    setState(() {
      showRankShimmer = false;
    });
  }

  Future<bool> onLikeButtonTapped(bool isLiked) async {
    // isLiked ==> means state before button is pressed
    if (!isLiked) {
      Provider.of<DetailedPostProvider>(context, listen: false)
          .setReaction(widget.postId);
      isLikedByMe = true;
      numberOfLikes = (int.parse(numberOfLikes) + 1).toString();
    } else {
      Provider.of<DetailedPostProvider>(context, listen: false)
          .removeReaction(widget.postId);
      isLikedByMe = false;
      numberOfLikes = (int.parse(numberOfLikes) - 1).toString();
    }
    // log(_isLikedByMe.toString());
    // log((!isLiked).toString());
    // log("_______------_---_-_--");
    return !isLiked;
  }

  postComments() async {
    // postCommentsList =
    //     await Provider.of<DetailedPostProvider>(context, listen: false)
    //         .loadAllComments(postId);

    postCommentsList =
        await Provider.of<DetailedPostProvider>(context, listen: false)
            .postNewComment(_typedComment.value, postId);
    numOfComments = postCommentsList!.length.toString();

    if (mounted) {
      setState(() {
        loadPostData = _loadData();
      });
    }

    // widget.alertAboutLikesAndCommentsChanges(
    //     numberOfLikes, isLikedByMe, numOfComments, postCommentsList);
    // print("- - - -  -   -  $numberOfLikes $numOfComments $isLikedByMe ");
  }

  @override
  initState() {
    loadPostData = _loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("_________________________________-  jjj");
    var profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    print("https://relife.co.in/api/${profileProvider.profilePicture}");
    return WillPopScope(
      onWillPop: () async {
        if (!widget.isNotificationPost!) {
          widget.alertAboutLikesAndCommentsChanges!(
              numberOfLikes, isLikedByMe, numOfComments, postCommentsList);
          Navigator.pop(context);
        } else if (widget.isNotificationPost!) {
          widget.setNotificationReadStatusTrue;
          Navigator.pop(context);
        } else {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (_) => BottomNavigationPage()));
        }
        return true;
      },
      child: Material(
        color: const Color(0xffF7F6F2),
        child: FutureBuilder(
            future: loadPostData,
            builder: (context, snap) {
              if (snap.hasData) {
                return Scaffold(
                    bottomNavigationBar: Builder(builder: (context) {
                      return BottomAppBar(
                        color: const Color(0xffF7F6F2),
                        elevation: 0,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            padding: EdgeInsets.only(
                                left: 13.w, right: 13.w, bottom: 8.h, top: 5.h),
                            decoration: BoxDecoration(
                              color: Colors.white,

                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25)), //25
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2.r,
                                        color: const Color(0xffFA8A3C)),
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipOval(
                                    child: SizedBox(
                                      height: 38.0.r,
                                      width: 38.0.r,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            "https://relife.co.in/api/${profileProvider.profilePicture}",
                                        key: ValueKey<String>(
                                            Provider.of<ProfileProvider>(
                                                    context,
                                                    listen: false)
                                                .key),
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                        // errorWidget: (context, url, error) =>
                                        //     const Icon(Icons.error),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Expanded(child: _buildTextField),
                                SizedBox(
                                  width: 10.w,
                                ),
                                Material(
                                  color: Colors.transparent,
                                  child: ValueListenableBuilder(
                                      valueListenable: _typedComment,
                                      builder: (context, val, child) {
                                        return InkWell(
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                          onTap: _typedComment.value != ''
                                              ? () {
                                                  if (_typedComment.value !=
                                                      '') {
                                                    // _textEditingController.clear();

                                                    // Provider.of<DetailedPostProvider>(
                                                    //         context,
                                                    //         listen: false)
                                                    //     .postNewComment(
                                                    //         _typedComment, postId);
                                                    postComments();
                                                    setState(() {
                                                      _typedComment.value = '';
                                                    });
                                                    key.currentState!
                                                        .controller!
                                                        .clear();
                                                    // loadComments();
                                                    // alerting post in feed for rebuilding

                                                    _scrollController.animateTo(
                                                      _scrollController.position
                                                          .maxScrollExtent,
                                                      duration: Duration(
                                                          milliseconds: 500),
                                                      curve:
                                                          Curves.fastOutSlowIn,
                                                    );
                                                  }
                                                }
                                              : null,
                                          child: Text(
                                            'post',
                                            style: TextStyle(
                                                fontSize: 18.sp,
                                                fontWeight: FontWeight.w500,
                                                color: _typedComment.value != ''
                                                    ? AppColors.buttonColor
                                                    : AppColors.buttonColor
                                                        .withOpacity(0.5)),
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                    appBar: AppBar(
                      backgroundColor: Colors.transparent,
                      toolbarHeight: 0,
                      elevation: 0,
                      automaticallyImplyLeading: false,
                      systemOverlayStyle: const SystemUiOverlayStyle(
                        statusBarColor: Color(0xffF7F6F2),
                        statusBarIconBrightness:
                            Brightness.dark, // For Android (dark icons)
                        statusBarBrightness:
                            Brightness.light, // For iOS (dark icons)
                      ),
                    ),
                    backgroundColor: const Color(0xffF7F6F2),
                    body: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowIndicator();
                        return false;
                      },
                      child: SingleChildScrollView(
                          controller: _scrollController,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    top: 5.h, left: 8.w, right: 10.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      backgroundColor: Colors.white,
                                      radius: 16.r,
                                      child: IconButton(
                                        onPressed: () {
                                          if (!widget.isNotificationPost!) {
                                            widget.alertAboutLikesAndCommentsChanges!(
                                                numberOfLikes,
                                                isLikedByMe,
                                                numOfComments,
                                                postCommentsList);
                                            Navigator.pop(context);
                                          } else if (widget
                                              .isNotificationPost!) {
                                            widget
                                                .setNotificationReadStatusTrue;
                                            Navigator.pop(context);
                                          } else {
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        BottomNavigationPage()));
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios_new_outlined,
                                          size: 18,
                                          color: Colors.black,
                                        ),
                                        splashRadius: 25.r,
                                        constraints: const BoxConstraints(),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(child: _buildProfileRow()),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              // _buildPostMessage(),
                              Padding(
                                padding: EdgeInsets.only(
                                    left: 15.w, right: 15.w, bottom: 15.h),
                                child: Container(
                                  padding: EdgeInsets.all(14.r),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(24.0.r),
                                    color: Colors.transparent,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (message != null)
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.w),
                                          child: _buildPostMessage(),
                                        ),
                                      if (postImageUrl != null)
                                        SizedBox(
                                          height: 12.h,
                                        ),
                                      if (postImageUrl != null)
                                        Center(
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(24.0.r),
                                              child: CachedNetworkImage(
                                                imageUrl: postImageUrl!,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                      SizedBox(
                                        height: 20.0.h,
                                      ),
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.0.w),
                                        child: _buildLikeRow(),
                                      ),
                                      // SizedBox(
                                      //   height: 17.0.h,
                                      // ),
                                      SizedBox(
                                        height: 5.0.h,
                                      ),
                                      Divider(
                                        thickness: 1,
                                      ),
                                      SizedBox(
                                        height: 5.0.h,
                                      ),
                                      // if (_isLoading == true)
                                      //   const Center(
                                      //       child: CircularProgressIndicator(
                                      //     color: AppColors.buttonColor,
                                      //   )),
                                      // if (_isLoading != true)
                                      Column(
                                        children: [
                                          for (int index =
                                                  (postCommentsList!.length -
                                                      1);
                                              index >= 0;
                                              index--)
                                            _buildComment(
                                                authorName:
                                                    postCommentsList![index]
                                                        .author
                                                        .displayName,
                                                comment:
                                                    postCommentsList![index]
                                                        .text!,
                                                authorPic:
                                                    postCommentsList![index]
                                                        .author
                                                        .avatarUrl,
                                                authorId:
                                                    postCommentsList![index]
                                                        .author
                                                        .userId),
                                        ],
                                      ),

                                      // const Spacer(), //this will take all blank space and will send the textfield in the bottom
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ));
              } else if (snap.hasError) {
                return Center(child: Text("something went wrong"));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  get _buildTextField {
    return FlutterMentions(
      key: key,
      // controller: _textEditingController,
      onChanged: (val) {
        // setState(() {
        //   _typedComment = val.trim();
        // });
      },
      suggestionListDecoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.black12,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      suggestionPosition: SuggestionPosition.Top,
      suggestionListHeight: 200,
      decoration: InputDecoration(
        hintText: 'add a comment',
        hintStyle: TextStyle(
          fontSize: 12.0.sp,
          fontWeight: FontWeight.w300,
        ),
        contentPadding: EdgeInsets.only(
            left: 16.0.w, right: 16.0.w, top: 10.0.h, bottom: 9.0.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0.r),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: AppColors.bottomSheetTextFieldColor,
      ),
      onMentionAdd: (data) {},
      onMarkupChanged: (val) {
        // setState(() {
        //   _typedComment = val.trim();
        // });
        _typedComment.value = val.trim();
        // print("____________________ $_typedComment");
      },
      onSearchChanged: (val1, val2) {
        var query = UsersQuery.find(val2);
        var pagingQuery = PagingQuery(query);
        pagingQuery.limit = 20;
        Communities.findUsers(pagingQuery).then((result) {
          var userList = result.entries;

          print(userList);
          for (var userDetail in userList) {
            if (!(mentionData.any((e) => e["id"] == userDetail.userId))) {
              mentionData.add({
                'id': userDetail.userId,
                'display': userDetail.displayName,
                'full_name': userDetail.displayName,
                'photo': userDetail.avatarUrl,
              });
            }
          }
          setState(() {});
        }).catchError((error) => print('Failed to find users, error: $error'));
      },
      mentions: [
        Mention(
          trigger: '@',
          style: const TextStyle(
            color: Color(0xff062540),
            fontWeight: FontWeight.w500, //Color(0xffFA8A3C),
          ),
          disableMarkup: false,
          data: mentionData.toList(),
          matchAll: false,
          suggestionBuilder: (data) {
            return Container(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Color(0xffFA8A3C),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                      data['photo'],
                    ),
                  ),
                ),
                title: Text(data['full_name']),
              ),
            );
          },
        ),
        // Mention(
        //   trigger: '#',
        //   disableMarkup: true,
        //   style: const TextStyle(
        //     color: Colors.blue,
        //   ),
        //   data: [
        //     {'id': 'reactjs', 'display': 'reactjs'},
        //     {'id': 'javascript', 'display': 'javascript'},
        //   ],
        //   matchAll: true,
        // )
      ],
    );
  }

  _buildPostMessage() {
    // return Text(
    //   message!,
    //   style: TextStyle(
    //     fontSize: 12.sp,
    //     fontWeight: FontWeight.w400,
    //   ),
    // );
    return ExpandableText(
      message!,
      expandText: "see more",
      collapseText: "See Less",
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
      ),
      urlStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w400,
        color: Colors.blue,
      ),
      linkStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
        color: Color(0xffF08A5D),
      ),
      mentionStyle: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      onMentionTap: (data) {
        // print("_____________________-- $data");
        // print(_activity.mentions);
      },
      maxLines: 8,
      onUrlTap: (link) async {
        String url = link;
        bool isEmail = link.contains("@");
        if (!isEmail) {
          if (!Uri.parse(url).hasScheme) {
            url = "http://" + link;
          }
        }
        bool _validURL = Uri.parse(url).isAbsolute;
        if (isEmail) {
        } else if (_validURL) {
          try {
            await launch(
              url,
              customTabsOption: const CustomTabsOption(
                toolbarColor: Color(0xffF7F6F2),
                enableDefaultShare: true,
                enableUrlBarHiding: true,
                showPageTitle: true,
                extraCustomTabs: <String>[
                  // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
                  'org.mozilla.firefox',
                  // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
                  'com.microsoft.emmx',
                ],
              ),
            );
          } catch (e) {
            // rethrow;
          }
        }
      },
    );
  }

  Row _buildProfileRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              GestureDetector(
                onTap: () async {
                  if (_relifeUserId != null) {
                    final personalProfile =
                        Provider.of<ProfileProvider>(context, listen: false);
                    if (_relifeUserId == personalProfile.userId) {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return const ProfilePage();
                      }));
                    } else {
                      final otherProfile = Provider.of<OthersProfileProvider>(
                          context,
                          listen: false);
                      CustomProgressIndicator().buildShowDialog(context);
                      await otherProfile.getProfile(_relifeUserId!);
                      Navigator.pop(context);
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return OtherProfilePage(id: _relifeUserId!);
                      }));
                    }
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 2.r, color: const Color(0xffFA8A3C)),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: SizedBox(
                      height: 48.0.r,
                      width: 48.0.r,
                      child: CachedNetworkImage(
                        imageUrl: profileImageUrl!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        if (_relifeUserId != null) {
                          final personalProfile = Provider.of<ProfileProvider>(
                              context,
                              listen: false);
                          if (_relifeUserId == personalProfile.userId) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const ProfilePage();
                            }));
                          } else {
                            final otherProfile =
                                Provider.of<OthersProfileProvider>(context,
                                    listen: false);
                            CustomProgressIndicator().buildShowDialog(context);
                            await otherProfile.getProfile(_relifeUserId!);
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return OtherProfilePage(id: _relifeUserId!);
                            }));
                          }
                        }
                      },
                      child: Text(
                        personName,
                        style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff062540)),
                      ),
                    ),
                    // if (personRank != null)
                    //   Text(
                    //     personRank!,
                    //     style: TextStyle(
                    //         fontSize: 12.sp,
                    //         fontWeight: FontWeight.w400,
                    //         color: const Color(0xff062540)),
                    //   )
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      reverseDuration: const Duration(milliseconds: 00),
                      child: personRank != null
                          ? Text(
                              // widget.personRank,
                              personRank!,
                              style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xff062540)),
                            )
                          : Visibility(
                              visible: _activity
                                      .author.identities["relife_userId"] !=
                                  null,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(right: 30, top: 5),
                                child: Shimmer.fromColors(
                                  baseColor: Color.fromARGB(255, 232, 228, 228),
                                  highlightColor:
                                      Color.fromARGB(255, 246, 238, 238),
                                  enabled: true,
                                  child: Container(
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        if (currentStreak != null && currentStreak != "")
          Container(
            decoration: BoxDecoration(
                color: const Color(0xffF08A5D).withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.r)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            child: Center(
              child: Row(
                children: [
                  Text(
                    // widget.personRank,
                    currentStreak!,
                    style: TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff062540)),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 3),
                      child: SvgPicture.asset(
                        AppAssets.fireIcon,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        // IconButton(
        //   onPressed: () {},
        //   splashRadius: 20.sp,
        //   constraints: const BoxConstraints(),
        //   icon: RotatedBox(
        //     quarterTurns: 1,
        //     child: SvgPicture.asset(
        //       AppAssets.seeMoreIcon,
        //       height: 20.sp,
        //       color: const Color(0xff062540),
        //     ),
        //   ),
        // )
      ],
    );
  }

  Row _buildLikeRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            LikeButton(
              size: 22.54.h,
              circleColor: const CircleColor(
                  start: Color(0xffF08A5D), end: Color(0xffF08A5D)),
              likeBuilder: (bool isLiked) {
                return isLiked
                    ? SvgPicture.asset(
                        AppAssets.heartFilled,
                        height: 22.54.h,
                      )
                    : SvgPicture.asset(
                        AppAssets.heart,
                        height: 22.54.h,
                      );
              },
              isLiked: isLikedByMe,
              likeCount: int.parse(numberOfLikes),
              likeCountPadding: EdgeInsets.only(left: 4.w),
              countBuilder: (count, isLiked, text) {
                return Text(
                  text,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                );
              },
              onTap: onLikeButtonTapped,
            ),
            SizedBox(
              width: 6.25.w,
            ),
            Padding(
              padding: EdgeInsets.only(right: 4.w),
              child: SvgPicture.asset(
                AppAssets.comment,
                height: 22.54.h,
              ),
            ),
            Text(
              numOfComments,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            )
          ],
        ),
        // IconButton(
        //   onPressed: () {},
        //   padding: EdgeInsets.only(right: 4.w),
        //   constraints: const BoxConstraints(), //to remove the padding
        //   icon: SvgPicture.asset(
        //     AppAssets.shareIcon,
        //     height: 22.54.h,
        //   ),
        // ),
      ],
    );
  }

  Padding _buildComment({
    required String comment,
    required String authorName,
    required String? authorPic,
    required String authorId,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 8.0.w, right: 8.0.w, bottom: 12.0.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1.r, color: const Color(0xffFA8A3C)),
              shape: BoxShape.circle,
            ),
            child: ClipOval(
              child: SizedBox(
                height: 19.25.r,
                width: 19.25.r,
                child: profileImageUrl == null
                    ? CachedNetworkImage(
                        imageUrl:
                            'https://p.kindpng.com/picc/s/24-248549_vector-graphics-computer-icons-clip-art-user-profile.png',
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      )
                    : CachedNetworkImage(
                        imageUrl: authorPic!,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) => Center(
                          child: CircularProgressIndicator(
                              value: downloadProgress.progress),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
              ),
            ),
          ),
          SizedBox(
            width: 6.75.w,
          ),
          Flexible(
            child: ExpandableText(
              " $comment",
              prefixText: authorName,
              prefixStyle: TextStyle(
                fontSize: 12.0.sp,
                fontWeight: FontWeight.w500,
              ),
              onPrefixTap: () async {
                // final personalProfile =
                //     Provider.of<ProfileProvider>(context, listen: false);
                // if (authorId == personalProfile.userId) {
                //   Navigator.push(context, MaterialPageRoute(builder: (_) {
                //     return const ProfilePage();
                //   }));
                // } else {
                //   final otherProfile = Provider.of<OthersProfileProvider>(
                //       context,
                //       listen: false);
                //   CustomProgressIndicator().buildShowDialog(context);
                //   await otherProfile.getProfile(authorId);
                //   Navigator.pop(context);
                //   Navigator.push(context, MaterialPageRoute(builder: (_) {
                //     return OtherProfilePage(id: authorId);
                //   }));
                // }
              },
              expandText: "see more",
              collapseText: "See Less",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
              urlStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
                color: Colors.blue,
              ),
              linkStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: const Color(0xffF08A5D),
              ),
              mentionStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              hashtagStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              onMentionTap: (data) {
                // print("_____________________-- $data");
                // print(_activity.mentions);
              },
              maxLines: 8,
              onUrlTap: (link) async {
                String url = link;
                bool isEmail = link.contains("@");
                if (!isEmail) {
                  if (!Uri.parse(url).hasScheme) {
                    url = "http://" + link;
                  }
                }
                bool _validURL = Uri.parse(url).isAbsolute;
                if (isEmail) {
                } else if (_validURL) {
                  try {
                    await launch(
                      url,
                      customTabsOption: const CustomTabsOption(
                        toolbarColor: Color(0xffF7F6F2),
                        enableDefaultShare: true,
                        enableUrlBarHiding: true,
                        showPageTitle: true,
                        extraCustomTabs: <String>[
                          // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
                          'org.mozilla.firefox',
                          // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
                          'com.microsoft.emmx',
                        ],
                      ),
                    );
                  } catch (e) {
                    // rethrow;
                  }
                }
              },
            ),
          )
          // Flexible(
          //   child: RichText(
          //       text: TextSpan(
          //     style:
          //         const TextStyle(color: Colors.black, fontFamily: 'Poppins'),
          //     children: [
          //       TextSpan(
          //         text: authorName,
          //         style: TextStyle(
          //           fontSize: 12.0.sp,
          //           fontWeight: FontWeight.w500,
          //         ),
          //       ),
          //       TextSpan(
          //         text: ' $comment',
          // style: TextStyle(
          //   fontSize: 12.0.sp,
          //   fontWeight: FontWeight.w400,
          // ),
          //       ),

          //     ],
          //   )),
          // )
        ],
      ),
    );
  }
}
