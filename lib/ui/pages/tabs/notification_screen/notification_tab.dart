import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:getsocial_flutter_sdk/getsocial_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/providers/post_provider.dart';
import 'package:relife/ui/pages/post_full_view__page/post_page.dart';

class NotificationPostDetails {
  String authorName = "";
  String? postText;
  String? postImageUrl;
  NotificationPostDetails({
    required this.authorName,
    this.postText,
    this.postImageUrl,
  });
}

class NotificationTabScreen extends StatefulWidget {
  const NotificationTabScreen({Key? key}) : super(key: key);

  @override
  State<NotificationTabScreen> createState() => _NotificationTabScreenState();
}

class _NotificationTabScreenState extends State<NotificationTabScreen> {
  // Future<bool> getFutureNotification() async {
  //   final notificationProvider =
  //       Provider.of<NotificationProvider>(context, listen: false);
  //   notificationProvider.setListToEmpty();

  //   List<dynamic> listOfNotification =
  //       await GetNotificationService().getNotificationResult();

  //   listOfNotification.forEach((notification) async {
  //     Map<String, User> user = await Communities.getUsers(
  //         UserIdList.create([notification.sender.userId]));
  //     if (user[notification.sender.userId] != null) {
  //       if (notification.type == 'comment' ||
  //           notification.type == 'activity_like' ||
  //           notification.type == 'related_comment') {
  //         var image =
  //             await GetGetSocialUser().getUser(notification.sender.userId);
  //         // print(
  //         //     '---------------Notifi------${DateFormat('dd-MM-yyyy h:mma').format(DateTime.fromMillisecondsSinceEpoch(notification.createdAt * 1000).add(const Duration(hours: 0, minutes: 00)))}');

  //         notificationProvider.addNotification(
  //           NotificationModel(
  //             notificationId: notification.id,
  //             message: notification.text!,
  //             isRead: notification.status == "read" ? true : false,
  //             createdAt: timeago.format(DateTime.fromMillisecondsSinceEpoch(
  //                 notification.createdAt * 1000)),

  //             postId: notification.notificationAction!.data['\$activity_id'],
  //             notificationType: notification.type,
  //             userId: 0, userProfilel: image!,
  //             // .difference(
  //             //   DateTime.now(),
  //             // )
  //             // .toString(),
  //           ),
  //         );
  //       }
  //     }
  //   });
  //   return true;
  // }

  ValueNotifier<bool> updatePage = ValueNotifier(false);
  List<NotificationPostDetails> listoFNotificationActivity = [];

  Future<List<GetSocialNotification>> getFutureNotification() async {
    List<GetSocialNotification> notification = [];
    listoFNotificationActivity = [];
    await Notifications.get(PagingQuery(NotificationsQuery.withStatuses(
      [NotificationStatus.unread, NotificationStatus.read],
    ))).then((value) {
      PagingResult<GetSocialNotification> result = value;

      notification = result.entries;
      log("Notification Result______ ${notification.length}} ---------------- : $notification");

      //print(notification);
    });

    for (int i = 0; i < notification.length; i++) {
      GetSocialActivity activity =
          await Provider.of<DetailedPostProvider>(context, listen: false)
              .loadDetailedPosTById(
                  notification[i].notificationAction!.data['\$activity_id']!);

      listoFNotificationActivity.add(NotificationPostDetails(
          authorName: activity.author.displayName,
          postImageUrl: activity.attachments.isNotEmpty
              ? activity.attachments[0].imageUrl
              : null,
          postText: activity.text));

      //print(activity);
    }

    updatePage.value = false;

    return notification;
  }

  Future<void> refreshNotificationList() async {
    // await getFutureNotification();

    await Future.delayed(const Duration(seconds: 1));
    updatePage.value = true;
    return;
  }

  @override
  void initState() {
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    //   final notificationProvider =
    //       Provider.of<NotificationProvider>(context, listen: false);
    // });
    // firebase optional
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print('A new onMessageOpenedApp event was published!');
    //   RemoteNotification? notification = message.notification;
    //   AndroidNotification? android = message.notification?.android;
    //   if (notification != null && android != null) {
    //     showDialog(
    //         context: context,
    //         builder: (_) {
    //           return AlertDialog(
    //             title: Text(notification.title!),
    //             content: SingleChildScrollView(
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [Text(notification.body!)],
    //               ),
    //             ),
    //           );
    //         });
    //   }
    // });
    //  FirebaseMessaging.onBackgroundMessage((message) => )

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xffF7F6F2),

          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      backgroundColor: const Color(0xffF7F6F2),
      body: Column(
        children: [
          SizedBox(
            height: 10.h,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.only(left: 30.w),
              child: Text(
                'notifications',
                style: TextStyle(
                    fontSize: AddHabitScreenTextStyle.headingSize,
                    fontWeight: AddHabitScreenTextStyle.headingWeight,
                    color: AppColors.startScreenBackgroundColor),
              ),
            ),
          ),
          SizedBox(
            height: 5.0.h,
          ),
          ValueListenableBuilder(
              valueListenable: updatePage,
              builder: (context, val, _) {
                return Expanded(
                  child: FutureBuilder<List<GetSocialNotification>>(
                      future: getFutureNotification(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data == null) {
                            return const Center(
                                child: Text("Something Went Wrong"));
                          }

                          if (snapshot.data!.isEmpty) {
                            return const Center(
                                child: Text("No Notification Yet"));
                          }

                          // return Column(
                          //   children: List.generate(
                          //       notificationProvider.notifications.length,
                          //       (index) {
                          //     var notification =
                          //         notificationProvider.notifications[index];
                          //     print(notification.createdAt);
                          //     print(notification.message);
                          //     return
                          //   }),
                          // );
                          return RefreshIndicator(
                            onRefresh: refreshNotificationList,
                            child: ListView.builder(
                                physics: const ClampingScrollPhysics(
                                    parent: AlwaysScrollableScrollPhysics()),
                                itemCount: snapshot.data!.length,
                                // notificationProvider.notifications.length,
                                padding: EdgeInsets.zero,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: EdgeInsets.only(
                                          left: 11.w, right: 11.w),
                                      child: _BuildNotificationContainer(
                                        userName: '',
                                        notificationMessage:
                                            snapshot.data![index].text!,
                                        time: timeago.format(
                                            DateTime.fromMillisecondsSinceEpoch(
                                                snapshot.data![index]
                                                        .createdAt *
                                                    1000)),
                                        imgUrl: snapshot
                                            .data![index].sender!.avatarUrl!,
                                        isEarlier:
                                            snapshot.data![index].status ==
                                                    "read"
                                                ? true
                                                : false,
                                        notificationId:
                                            snapshot.data![index].id,
                                        notificationType:
                                            snapshot.data![index].type,
                                        postId: snapshot
                                            .data![index]
                                            .notificationAction!
                                            .data['\$activity_id']!,
                                        postImageUrl: listoFNotificationActivity
                                                .isNotEmpty
                                            ? listoFNotificationActivity[index]
                                                .postImageUrl
                                            : null,
                                        postText: listoFNotificationActivity
                                                .isNotEmpty
                                            ? listoFNotificationActivity[index]
                                                .postText
                                            : null,
                                        postAuthorname:
                                            listoFNotificationActivity
                                                    .isNotEmpty
                                                ? listoFNotificationActivity[
                                                        index]
                                                    .authorName
                                                : null,
                                      ));
                                }),
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                );
              }),
        ],
      ),
    );
  }
}

class _BuildNotificationContainer extends StatefulWidget {
  final String userName, notificationMessage, imgUrl;
  final String time;
  final bool isEarlier;
  final String notificationId;
  final String notificationType, postId;
  final String? postImageUrl, postText, postAuthorname;
  const _BuildNotificationContainer({
    Key? key,
    required this.userName,
    required this.notificationMessage,
    required this.time,
    this.isEarlier = false,
    required this.imgUrl,
    required this.notificationId,
    required this.notificationType,
    required this.postId,
    this.postImageUrl,
    this.postText,
    this.postAuthorname,
  }) : super(key: key);

  @override
  State<_BuildNotificationContainer> createState() =>
      _BuildNotificationContainerState();
}

class _BuildNotificationContainerState
    extends State<_BuildNotificationContainer> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () async {
          await Notifications.setStatus(
                  NotificationStatus.read, [widget.notificationId])
              .then((result) {
            // print('Successfully changed notifications status'),
          })
              // ignore: invalid_return_type_for_catch_error
              .catchError((error) => {});

          if (widget.notificationType == 'comment' ||
              widget.notificationType == 'activity_like' ||
              widget.notificationType == 'related_comment') {
            Navigator.push(context, MaterialPageRoute(builder: (_) {
              return PostFullViewPage(
                postId: widget.postId,
                isNotificationPost: true,
                setNotificationReadStatusTrue: () {},
              );
            }));
          }
        },
        child: Padding(
          padding: EdgeInsets.only(bottom: 11.h),
          child: Container(
            padding: EdgeInsets.only(top: 3.0.h, right: 5.0.w),
            width: 336.w,
            decoration: BoxDecoration(
              color: widget.isEarlier ? Colors.transparent : Colors.white,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(12.w, 15.h, 0.w, 5.h),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                  width: 2.r, color: const Color(0xffFA8A3C)),
                              shape: BoxShape.circle,
                            ),
                            child: ClipOval(
                              child: SizedBox(
                                height: 32.0.r,
                                width: 32.0.r,
                                child: CachedNetworkImage(
                                  imageUrl: widget.imgUrl,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20.w,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(0.w, 13.h, 0.w, 5.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: 240.w,
                                child: Text.rich(
                                  TextSpan(
                                    // style: TextStyle(
                                    //   fontSize: 14.sp,
                                    //   fontWeight: FontWeight.w400,
                                    //   fontFamily: 'Poppins',
                                    // ),
                                    children: [
                                      TextSpan(
                                        text: widget.userName,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w900,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                      TextSpan(
                                        text: widget.notificationMessage,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400,
                                          fontFamily: 'Poppins',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 2.0.h,
                              ),
                              Text(
                                widget.time,
                                style: TextStyle(
                                  fontSize: 8.0.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: 49.w, top: 4.h, right: 18.w, bottom: 8.h),
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                            color: const Color(0xffE5E5E5), width: 1)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(17.w, 8.h, 6.w, 8.h),
                      child: (widget.postAuthorname != null)
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                if (widget.postImageUrl != null)
                                  Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: SizedBox(
                                        width: 48.r,
                                        height: 48.r,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          child: CachedNetworkImage(
                                              imageUrl: widget.postImageUrl!),
                                        )),
                                  ),
                                SizedBox(
                                  width: 7.w,
                                ),
                                SizedBox(
                                  width: 185.w,
                                  child: Text(
                                    widget.postText == null
                                        ? "${widget.postAuthorname}'s recent activity"
                                        : widget.postText!,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Poppins',
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            )
                          : Center(
                              child: SizedBox(
                                  width: 15.r,
                                  height: 15.r,
                                  child: const CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ))),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
