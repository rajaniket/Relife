import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/providers/page_provider/habit_tab_provider.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/ui/pages/add_new_habit/add_habit.dart';
import 'package:relife/ui/pages/habits_full_view/habits_full_view_page.dart';
import 'package:relife/ui/pages/journal/journal_page.dart';
import 'package:relife/ui/pages/post_create/post_create.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';
import 'package:relife/model/service%20model/get_user_all_habits_model.dart';

import '../../../../model/service model/get_system_habits_model.dart';
import 'local_widget/short_calendar.dart';

class HabitScreenTab extends StatefulWidget {
  const HabitScreenTab({Key? key}) : super(key: key);

  @override
  State<HabitScreenTab> createState() => _HabitScreenTabState();
}

class _HabitScreenTabState extends State<HabitScreenTab> {
  //ParticularHabitDetail(habitName: "", habitid: "",index: 0,noOfUserContinuedTheirStreak: 0);
  List<Widget> habitCard = [];

  @override
  void initState() {
    // WidgetsBinding.instance!.addPostFrameCallback((_) async {
    //   final profile = Provider.of<ProfileProvider>(context, listen: false);
    //   final payment =
    //       Provider.of<PaymentDetailProvider>(context, listen: false);
    //   var listDetail = await profile.getIsPostedToday();
    //   if (listDetail != null) {
    //     for (int i = 0; i < listDetail.length; i++) {
    //       if (i % 2 == 0) {
    //         isPostedCheck[listDetail[i]] =
    //             DateTime.tryParse(listDetail[i + 1])!.day < DateTime.now().day;
    //       }
    //     }
    //   }
    // });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffF7F6F2),
        automaticallyImplyLeading: false,
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xffF7F6F2),

          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      backgroundColor: const Color(0xffF7F6F2),
      body: NestedScrollView(
        physics: const ClampingScrollPhysics(),
        floatHeaderSlivers: true,
        headerSliverBuilder: (BuildContext context, _) {
          return [
            SliverAppBar(
                floating: true,
                pinned: false,
                snap: true,
                backgroundColor: const Color(0xffF7F6F2),
                elevation: 0,
                toolbarHeight: 60.h,
                titleSpacing: 0,
                title: Row(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.w),
                        child: Text(
                          'habits',
                          style: TextStyle(
                            fontSize: AddHabitScreenTextStyle.headingSize,
                            fontWeight: AddHabitScreenTextStyle.headingWeight,
                            color: AppColors.startScreenBackgroundColor,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Align(
                      //alignment: Alignment.centerRight,
                      child: Row(
                        //mainAxisSize: MainAxisSize.min,
                        children: [
                          InkWell(
                            onTap: () {
                              navigatorPush(context, const AddNewHabitPage());
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 16.0.w),
                              child: Image.asset(
                                AppAssets.add,
                                height: 24.sp,
                                //width: 28.w,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              navigatorPush(context, const JournalPage());
                            },
                            child: Padding(
                              padding: EdgeInsets.only(right: 20.w),
                              child: Image.asset(
                                AppAssets.calender,
                                height: 26.67.sp,
                                //width: 34.w,
                                //fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                )),
          ];
        },
        body: Consumer<HabitTabProvider>(
            builder: (context, habitTabProvider, child) {
          return habitTabProvider.loading
              ? const Center(child: CircularProgressIndicator())
              : NotificationListener<OverscrollIndicatorNotification>(
                  onNotification: (OverscrollIndicatorNotification overscroll) {
                    overscroll.disallowIndicator();
                    return false;
                  },
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    itemCount: habitTabProvider.listOfUserHabitdetails.length,
                    itemBuilder: (context, index) {
                      // voidParticukarSystemHabits(index);
                      return Padding(
                          padding: index == 0
                              ? EdgeInsets.only(
                                  left: 12.0.w, right: 12.0.w, bottom: 6.h)
                              : EdgeInsets.symmetric(
                                  horizontal: 12.0.w, vertical: 6.h),
                          child: _BuildShortCalendarContainer(
                            buttonText: habitTabProvider
                                        .listOfUserHabitdetails[index]
                                        .currentStreak ==
                                    0
                                ? 'start a new streak'
                                : 'continue my ${habitTabProvider.listOfUserHabitdetails[index].currentStreak} day streak',
                            habit: habitTabProvider
                                .listOfUserHabitdetails[index]
                                .habitDetails
                                .name,
                            longestStreak: habitTabProvider
                                .listOfUserHabitdetails[index].longestStreak
                                .toString(),
                            noOfPeople: habitTabProvider
                                .listParticularSystemHabitDetailAsPerUserHabit[
                                    index]
                                .noOfUserContinuedTheirStreak
                                .toString(),
                            onTapForButton: () {},
                            detail:
                                habitTabProvider.listOfUserHabitdetails[index],
                            isDoneForToday: habitTabProvider
                                .listParticularSystemHabitDetailAsPerUserHabit[
                                    index]
                                .isDoneForToday,
                            habitIndex: index,
                            leaderboard: habitTabProvider
                                .listParticularSystemHabitDetailAsPerUserHabit[
                                    index]
                                .leaderboard,
                          ));
                    },
                  ),
                );
        }),
      ),
    );
  }
}

class _BuildShortCalendarContainer extends StatelessWidget {
  final String habit, buttonText, noOfPeople, longestStreak;
  final VoidCallback onTapForButton;
  final Detail detail;
  final int habitIndex;
  bool isDoneForToday;
  List<Leaderboard> leaderboard;

  _BuildShortCalendarContainer({
    Key? key,
    required this.habit,
    required this.buttonText,
    required this.noOfPeople,
    required this.longestStreak,
    required this.onTapForButton,
    required this.detail,
    required this.isDoneForToday,
    required this.habitIndex,
    required this.leaderboard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HabitFullViewPage(
              habit: habit,
              buttonText: buttonText,
              currentStreak: detail.currentStreak.toString(),
              daysToReachGoal: detail.toReachYourGoal.toString(),
              longestStreak: longestStreak,
              thisMonth: detail.thisMonth.toString(),
              tillDate: detail.tillDate.toString(),
              detail: detail,
              habitIndex: habitIndex,
              isDoneForToday: isDoneForToday,
              leaderboard: leaderboard,
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(15.0.r),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0.r),
          color: Colors.white,
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    habit,
                    style: TextStyle(
                        fontSize: 18.0.sp, fontWeight: FontWeight.w400),
                  ),
                  IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HabitFullViewPage(
                              habit: habit,
                              buttonText: buttonText,
                              currentStreak: detail.currentStreak.toString(),
                              daysToReachGoal:
                                  detail.toReachYourGoal.toString(),
                              longestStreak: longestStreak,
                              thisMonth: detail.thisMonth.toString(),
                              tillDate: detail.tillDate.toString(),
                              detail: detail,
                              habitIndex: habitIndex,
                              isDoneForToday: isDoneForToday,
                              leaderboard: leaderboard,
                            ),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.chevron_right,
                        size: 30.sp,
                      ))
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),
            ShortCalendar(
              habitIndex: habitIndex,
            ),
            SizedBox(
              height: 25.h,
            ),
            Text(
              '$noOfPeople others continued their streak today 💪',
              style: TextStyle(fontSize: 14.0.sp, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 16.h,
            ),
            _buildButton(context, isDoneForToday, detail.id),
            SizedBox(
              height: 14.h,
            ),
            Text(
              'longest streak is $longestStreak days 🙌',
              style: TextStyle(fontSize: 12.0.sp, fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

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
                    topic: habit,
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
