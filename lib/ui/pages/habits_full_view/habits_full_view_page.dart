import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/model/service%20model/get_user_all_habits_model.dart';
import 'package:relife/providers/others_profile_provider.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/ui/pages/habits_full_view/local_widgets/full_calendar_widget.dart';
import 'package:relife/ui/pages/leaderboard/leaderboard_page.dart';
import 'package:relife/ui/pages/post_create/post_create.dart';
import 'package:relife/ui/pages/profile/other_user_profile.dart';
import 'package:relife/ui/pages/profile/profile_page.dart';
import 'package:relife/ui/pages/view_habit/edit_view_habit_page.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/ui/widgets/progress_loader.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';

import '../../../model/service model/get_system_habits_model.dart';

class HabitFullViewPage extends StatefulWidget {
  final String habit,
      currentStreak,
      tillDate,
      thisMonth,
      buttonText,
      longestStreak,
      daysToReachGoal;

  final Detail detail;
  final int habitIndex;
  final bool isDoneForToday;
  List<Leaderboard> leaderboard;

  HabitFullViewPage(
      {Key? key,
      required this.habit,
      required this.currentStreak,
      required this.tillDate,
      required this.thisMonth,
      required this.buttonText,
      required this.longestStreak,
      required this.daysToReachGoal,
      required this.detail,
      required this.habitIndex,
      required this.isDoneForToday,
      required this.leaderboard})
      : super(key: key);

  @override
  State<HabitFullViewPage> createState() => _HabitFullViewPageState();
}

class _HabitFullViewPageState extends State<HabitFullViewPage> {
  String currentUserId = "";
  @override
  void initState() {
    currentUserId = Provider.of<ProfileProvider>(context, listen: false).userId;
    super.initState();
  }

  // Future<GetParticularSysytemHabitModel> getLeaderboardData() async {
  //   GetParticularSysytemHabitModel data =
  //       await Provider.of<ParticuarSystemHabitProvider>(context, listen: false)
  //           .getParticularSystemHabit(
  //               widget.detail.habitDetails.habitDetailsId);

  //   return data;
  // }

  @override
  Widget build(BuildContext context) {
    List<Leaderboard> viewLeaderBoard = [];
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
      body: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowIndicator();
          return false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 5.0.h,
              ),
              _buildBackButtonAndTitle(context, widget.habit),
              SizedBox(
                height: 12.0.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0.w),
                child: _BuildFullCalendarContainer(
                  buttonText: widget.buttonText,
                  currentStreak: widget.currentStreak,
                  daysToReachGoal: widget.daysToReachGoal,
                  longestStreak: widget.longestStreak,
                  tillDate: widget.tillDate,
                  thisMonth: widget.thisMonth,
                  habitName: widget.detail.habitDetails.name,
                  detail: widget.detail,
                  habitIndex: widget.habitIndex,
                  isDoneForToday: widget.isDoneForToday,
                ),
              ),
              SizedBox(
                height: 20.0.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 21.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(children: [
                      Padding(
                        padding: EdgeInsets.only(bottom: 10.h),
                        child: Text(
                          'leaderboard',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      // const Spacer(),
                    ]),
                    SvgPicture.asset(
                      AppAssets.leaderboardCup,
                      height: 60.r,
                      width: 60.r,
                    ),
                    // SvgPicture.asset(AppAssets.shareIcon),
                  ],
                ),
              ),
              SizedBox(
                height: 10.0.h,
              ),
              Column(
                children: List.generate(
                    widget.leaderboard.length >= 6
                        ? 5
                        : widget.leaderboard.length, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      left: 10.w,
                      right: 10.w,
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10.r),
                        onTap: () async {
                          final personalProfile = Provider.of<ProfileProvider>(
                              context,
                              listen: false);
                          if (widget.leaderboard[index].id ==
                              personalProfile.userId) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return const ProfilePage();
                            }));
                          } else {
                            final otherProfile =
                                Provider.of<OthersProfileProvider>(context,
                                    listen: false);
                            CustomProgressIndicator().buildShowDialog(context);
                            await otherProfile
                                .getProfile(widget.leaderboard[index].id);
                            Navigator.pop(context);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (_) {
                              return OtherProfilePage(
                                  id: widget.leaderboard[index].id);
                            }));
                          }
                        },
                        child: Container(
                          // padding: EdgeInsets.only(top: 6.h, bottom: 6.h),
                          decoration: BoxDecoration(
                              color:
                                  currentUserId == widget.leaderboard[index].id
                                      ? const Color(0xffF08A5D).withOpacity(0.3)
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(10.r)),
                          child: Center(
                            child: _BuildUserDetail(
                                userName: widget.leaderboard[index].firstName +
                                    " " +
                                    widget.leaderboard[index].lastName,
                                ranking: index + 1,
                                time: widget
                                    .leaderboard[index].postsCountInCurrentMonth
                                    .toString(),
                                imgUrl:
                                    'https://relife.co.in/api/${widget.leaderboard[index].profilePicture}'),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(
                height: 32.h,
              ),
              _buildButton(context, widget.leaderboard),
              // FutureBuilder<GetParticularSysytemHabitModel>(
              //     future: getLeaderboardData(),
              //     builder: (context, snapshot) {
              //       if (snapshot.hasError) {
              //         return const Center(
              //           child: Text("something went wrong"),
              //         );
              //       } else if (snapshot.hasData) {
              //         int leaderBoardLength =
              //             (snapshot.data!.details.leaderboard.length) >= 6
              //                 ? 5
              //                 : (snapshot.data!.details.leaderboard.length);
              //

              //         print(
              //             "${currentUserId}____ $leaderBoardLength ______${snapshot.data!.details.leaderboard.length}_______");

              //         return Column(
              //           children: [

              //           ],
              //         );
              //       } else {
              //         return const Center(
              //           child: CircularProgressIndicator(
              //             color: Color(0xffDF532B),
              //           ),
              //         );
              //       }
              //     }),
              SizedBox(
                height: 22.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildButton(BuildContext context, List<Leaderboard> _leaderBoard) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 56.0.w),
      child: CustomTextButton(
        message: 'view leaderboard',
        fontSize: ViewHabitScreenTextStyle.buttonTextSize,
        fontWeight: ViewHabitScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.0.sp,
        elevation: 0,
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LeaderboardPage(
                        leaderBoard: _leaderBoard,
                      )));
        },
      ),
    );
  }

  Widget _buildBackButtonAndTitle(BuildContext context, String habit) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            RoundBackButton(
              onPressed: () {
                Navigator.pop(context);
              },
              backgroundColour: Colors.white,
            ),
            Text(
              habit,
              style: TextStyle(
                  fontSize: ViewHabitScreenTextStyle.headingSize,
                  fontWeight: ViewHabitScreenTextStyle.headingWeight,
                  color: const Color(0xff062540)),
            ),
          ],
        ),
        IconButton(
          onPressed: () {
            navigatorPush(
                context,
                EditViewHabitPage(
                  detail: widget.detail,
                ));
          },
          splashRadius: 20.sp,
          constraints: const BoxConstraints(),
          padding: EdgeInsets.all(15.r),
          icon: RotatedBox(
            quarterTurns: 1,
            child: SvgPicture.asset(
              AppAssets.seeMoreIcon,
              height: 20.sp,
              color: const Color(0xff062540),
            ),
          ),
        ),
      ],
    );
  }
}

class _BuildFullCalendarContainer extends StatelessWidget {
  final String currentStreak,
      habitName,
      tillDate,
      thisMonth,
      buttonText,
      longestStreak,
      daysToReachGoal;

  final Detail detail;
  final int habitIndex;
  final bool isDoneForToday;

  const _BuildFullCalendarContainer({
    Key? key,
    required this.buttonText,
    required this.longestStreak,
    required this.currentStreak,
    required this.tillDate,
    required this.thisMonth,
    required this.daysToReachGoal,
    required this.habitName,
    required this.detail,
    required this.habitIndex,
    required this.isDoneForToday,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(15.0.r),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0.r),
            color: Colors.white,
          ),
          child: Column(
            children: [
              FullCalendar(
                habitIndex: habitIndex,
              ),
              SizedBox(
                height: 25.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          children: [
                            Text(
                              '$currentStreak days 🔥',
                              style: TextStyle(
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'current streak',
                              style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            // Text(
                            //   'current streak : $currentStreak 🔥',
                            //   style: TextStyle(
                            //       fontSize: 12.0.sp, fontWeight: FontWeight.w500),
                            // ),
                            const SizedBox(
                              height: 23,
                            ),
                            Text(
                              '$thisMonth days 🗓',
                              style: TextStyle(
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'this month',
                              style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Column(
                          children: [
                            Text(
                              '$longestStreak days 🙌',
                              style: TextStyle(
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'longest streak',
                              style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              height: 23,
                            ),
                            Text(
                              '$tillDate days 🙏',
                              style: TextStyle(
                                  fontSize: 20.0.sp,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              'till date',
                              style: TextStyle(
                                  fontSize: 12.0.sp,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 21.h,
              ),
              Text(
                '$daysToReachGoal days 🎯',
                style:
                    TextStyle(fontSize: 20.0.sp, fontWeight: FontWeight.w600),
              ),
              Text(
                'to reach your goal',
                style:
                    TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w400),
              ),
              SizedBox(
                height: 22.h,
              ),
              _buildButton(context, isDoneForToday, detail.id),
              SizedBox(
                height: 14.h,
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.only(right: 22.w, top: 20.h),
        //   child: Align(
        //       alignment: Alignment.topRight,
        //       child: SvgPicture.asset(AppAssets.shareIcon)),
        // )
      ],
    );
  }

  // Padding _buildButton(BuildContext context) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(horizontal: 35.0.w),
  //     child: CustomTextButton(
  //       message: buttonText,
  //       fontSize: ViewHabitScreenTextStyle.buttonTextSize,
  //       fontWeight: ViewHabitScreenTextStyle.buttonTextWeight,
  //       buttonColor: AppColors.buttonColor,
  //       buttonSize: Size(double.infinity, 47.0.h),
  //       borderRadius: 30.0.sp,
  //       elevation: 0,
  //       onTap: () {
  //         navigatorPush(
  //             context,
  //             PostCreatePage(
  //               topic: habitName,
  //               detail: detail,
  //             ));
  //       },
  //     ),
  //   );
  // }

  _buildButton(BuildContext context, bool isDoneForToday, String id) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 35.0.w),
      child: CustomTextButton(
        message: isDoneForToday ? 'done for the day!' : buttonText,
        fontSize: ViewHabitScreenTextStyle.buttonTextSize,
        fontWeight: ViewHabitScreenTextStyle.buttonTextWeight,
        buttonColor:
            isDoneForToday ? const Color(0xff979797) : AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.0.sp,
        elevation: 0,
        onTap: () async {
          final profile = Provider.of<ProfileProvider>(context, listen: false);
          if (!isDoneForToday) {
            profile.setIsPostedToday(DateTime.now(), detail.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) {
                  return PostCreatePage(
                    detail: detail,
                    topic: habitName,
                  );
                },
              ),
            );
          } else {
            // debugPrint('done for this day !');
          }
        },
      ),
    );
  }
}

class _BuildUserDetail extends StatelessWidget {
  final String userName, time, imgUrl;
  final int ranking;
  const _BuildUserDetail({
    Key? key,
    required this.userName,
    required this.ranking,
    required this.time,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(left: 2.0.w, right: 18.0.w, bottom: 6.h, top: 6.h),
      child: Container(
        padding: EdgeInsets.only(top: 3.0.h, right: 5.0.w),
        //width: 336.w,
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  width: 40.w,
                  child: FittedBox(
                    child: Text(
                      '# $ranking',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Container(
                  decoration: BoxDecoration(
                    border:
                        Border.all(width: 2.r, color: const Color(0xffFA8A3C)),
                    shape: BoxShape.circle,
                  ),
                  child: ClipOval(
                    child: SizedBox(
                      height: 31.0.r,
                      width: 31.0.r,
                      child: CachedNetworkImage(
                        imageUrl: imgUrl,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                SizedBox(
                  width: 160.w,
                  child: Text(
                    userName,
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
            Text(
              '$time days',
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  overflow: TextOverflow.ellipsis),
            ),
          ],
        ),
      ),
    );
  }
}
