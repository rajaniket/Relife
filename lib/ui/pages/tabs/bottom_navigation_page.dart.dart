import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:getsocial_flutter_sdk/getsocial_flutter_sdk.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/main.dart';
import 'package:relife/providers/alarm_provider.dart';
import 'package:relife/providers/connectivity_provider.dart';
import 'package:relife/providers/get_user_all_habits_provider.dart';
import 'package:relife/providers/page_provider/habit_tab_provider.dart';
import 'package:relife/ui/pages/community_ritual/community_ritual_page.dart';
import 'package:relife/ui/pages/post_full_view__page/post_page.dart';
import 'package:relife/ui/pages/tabs/explore_screen/explore_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../email_verify/email_verify_page.dart';
import '../test_page.dart';
import 'habits_screen/habits_tab.dart';
import 'home_screen/home_tab.dart';
import 'notification_screen/notification_tab.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage> {
  var currentIndex = 0;
  bool refreshUserAllHabitApiForHabitTab = false;
  // ScrollController homeScrollController = ScrollController();
  List<Widget> screens = [];
  // Future<void> updateUser(BuildContext context) async {
  //   final profileProvider =
  //       Provider.of<ProfileProvider>(context, listen: false);
  //   var user = await GetSocial.currentUser;

  //   // if (user!.displayName.startsWith('User')) {
  //   if (!user!.isAnonymous) {
  //     var batchUpdate = UserUpdate();
  //     batchUpdate.updateDisplayName(
  //         profileProvider.firstName + ' ' + profileProvider.lastName);
  //     batchUpdate.updateAvatarUrl(
  //         'https://relife.co.in/api/${profileProvider.profilePicture}');
  //     user.updateDetails(batchUpdate);
  //     debugPrint(user.displayName);
  //     debugPrint(user.avatarUrl);
  //   } else{

  //   }
  //   // }
  // }

  // void getFutureNotification() async {
  //   final notificationProvider =
  //       Provider.of<NotificationProvider>(context, listen: false);

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
  // }
  getAllLocallyStoreddata() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys();

    final prefsMap = Map<String, dynamic>();
    for (String key in keys) {
      prefsMap[key] = prefs.get(key);
    }

    print("cached data : $prefsMap");
  }

  recallAlarm() async {
    GetUserAllHabitsProvider? getUserHabitsProvider =
        Provider.of<GetUserAllHabitsProvider>(context, listen: false);
    var alarmProvider = Provider.of<AlarmProvider>(context, listen: false);
    int length = getUserHabitsProvider.listOfHabitDetails.length;
    for (int i = 0; i < length; i++) {
      //testing
      // switch (getUserHabitsProvider.habitDetails[i].habitDetails.id) {
      //   case '61c9ad33e5d53c0011dab03e': //reading
      //     await alarmProvider.fetchAlarmDataFromSharedPrefrence("123");
      //     await alarmProvider.setAlarm();
      //     break;
      //   case '61c9ae14e5d53c0011dab062': //running
      //     await alarmProvider.fetchAlarmDataFromSharedPrefrence("234");
      //     await alarmProvider.setAlarm();
      //     break;
      //   case '61c9cd8495adfb001202e196': //exercise
      //     await alarmProvider.fetchAlarmDataFromSharedPrefrence("345");
      //     await alarmProvider.setAlarm();
      //     break;
      // }

      //production

      switch (getUserHabitsProvider.listOfHabitDetails[i].habitDetails.id) {
        case '620d605f39e03e00128b6f43': //reading
          await alarmProvider.fetchAlarmDataFromSharedPrefrence("123");
          await alarmProvider.setAlarm();
          break;
        case '620d60f539e03e00128b6f48': //running
          await alarmProvider.fetchAlarmDataFromSharedPrefrence("234");
          await alarmProvider.setAlarm();
          break;
        case '620d5fbc39e03e00128b6f3d': //exercise
          await alarmProvider.fetchAlarmDataFromSharedPrefrence("345");
          await alarmProvider.setAlarm();
          break;
      }
    }
  }

  @override
  void initState() {
    super.initState();
    screens = [
      HomeTabScreen(
          //homeScrollController: homeScrollController,
          ),
      const ExploreTabScreen(),
      const HabitScreenTab(),
      const NotificationTabScreen()
    ];
    getAllLocallyStoreddata();
    recallAlarm();
    // updateUser(context);

    //_____________  Already fetched in welcome
    // final getUserHabit =
    //     Provider.of<GetUserHabitsProvider>(context, listen: false);
    //getUserHabit.getUserHabits(context);
    //_____________________

    //  getFutureNotification();

    Notifications.setOnNotificationClickedListener((notification, contxt) {
      Notifications.setStatus(NotificationStatus.read, [notification.id])
          .then((result) {
        // print('Successfully changed notifications status');
      }).catchError((error) => {
                // print('Failed to change notifications status, error: $error'),
              });

      var postId = notification.notificationAction!.data['\$activity_id'];

      if (notification.type == 'comment' ||
          notification.type == 'activity_like' ||
          notification.type == 'related_comment') {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PostFullViewPage(
              postId: postId!,
              isNotificationPost: true,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (context, connectivity, child) {
      // if (connectivity.isOnline != null) {
      return
          //connectivity.isOnline! =
          Scaffold(
        backgroundColor: const Color(0xffF7F6F2),
        bottomNavigationBar: _buildBottomNavigationBar(),
        body: IndexedStack(
          index: currentIndex,
          children: screens,
        ),
        // floatingActionButton: FloatingActionButton(onPressed: () async {
        //   Navigator.push(context,
        //       MaterialPageRoute(builder: (context) => const EmailVerifyPage()));
        // }),
      );
      //  : const NoInternetPage();
      //  }
      // return const Center(
      //   child: CircularProgressIndicator(),
      // );
    });
  }

  _buildBottomNavigationBar() {
    // var count = 0;
    bool showDot = false;
    // final notificationProvider =
    //     Provider.of<NotificationProvider>(context, listen: false);
    // notificationProvider.getSharedNotificationCount().then((value) {
    //   value = count;
    //   showDot =
    //       notificationProvider.notifications.length > value ? true : false;
    // });
    return ClipRRect(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
          // border: Border.all(color: const Color(0xffDEDDDB), width: 0.5),
          boxShadow: const [
            BoxShadow(
              color: Colors.black38, //Color(0xffDEDDDB),
              spreadRadius: 3,
            )
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index) => setState(() {
            if (index == 0) {
              // homeScrollController.animateTo(0,
              //     duration: const Duration(
              //       milliseconds: 500,
              //     ),
              //     curve: Curves.easeInOut);
            }
            if (index == 2) {
              if (refreshUserAllHabitApiForHabitTab) {
                Provider.of<HabitTabProvider>(context, listen: false)
                    .getHabitTabData(context: context); // update habits
              }
              refreshUserAllHabitApiForHabitTab = false;
            }
            // if (index == 3) {
            //   print(
            //       '-------------length of notification count-------${notificationProvider.notifications.length}--------------------');
            //   notificationProvider.setSharedNotificationCount(
            //       notificationProvider.notifications.length);
            // }
            refreshUserAllHabitApiForHabitTab = true;
            currentIndex = index;
          }),
          backgroundColor: const Color(0xffFFFFFF),
          unselectedItemColor: AppColors.bottomNavigatorBarIconColour,
          selectedItemColor: AppColors.bottomNavigatorBarIconColour,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          iconSize: 27.r,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(AppAssets.homeFilledIcon),
              icon: SvgPicture.asset(AppAssets.homeIcon),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(AppAssets.exploreFilledIcon),
              icon: SvgPicture.asset(AppAssets.exploreIcon),
              label: 'Explore',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(AppAssets.habitFilledIcon),
              icon: SvgPicture.asset(AppAssets.habitIcon),
              label: 'Habits',
            ),
            BottomNavigationBarItem(
              activeIcon: SvgPicture.asset(AppAssets.notificationFieldIcon),
              icon: showDot == true
                  ? SvgPicture.asset(AppAssets.notificationIcon)
                  : SvgPicture.asset(
                      AppAssets.plainNotificationIcon,
                      color: const Color(0xff062540),
                    ),
              label: 'Notification',
            ),
          ],
        ),
      ),
    );
  }
}
