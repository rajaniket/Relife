import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/providers/add_habits_provider.dart';
import 'package:relife/providers/alarm_provider.dart';
import 'package:relife/providers/get_user_all_habits_provider.dart';
import 'package:relife/ui/pages/new_habit_added/new_habit_added.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/ui/widgets/progress_loader.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';

import '../../../providers/page_provider/habit_tab_provider.dart';

class ViewHabitPage extends StatefulWidget {
  final String habitName;
  const ViewHabitPage({Key? key, required this.habitName}) : super(key: key);

  @override
  State<ViewHabitPage> createState() => _ViewHabitPageState();
}

class _ViewHabitPageState extends State<ViewHabitPage> {
  final String habitType = 'reading';

  final String reminderType = 'i have dinner ⏳';

  final String behaviourType = 'read for 15 mins  😇';

  final String rewardType = 'watch netflix 🙈';

  final String remindTime = '8:30 pm';

  final String duration = '25 days this month 🎯';

  final String punishmentType = 'i’ll treat kaushal for\nsome pizza 🤐';

  final String friendName = 'kaushal';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F2),
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
      body: Consumer<AddHabitsProvider>(
        builder: (context, addHabit, child) => SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 15.0.h,
                ),
                _buildBackButtonAndTitle(context),
                SizedBox(
                  height: 40.0.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.74.w),
                    child: Text(
                      'my plan to make ${widget.habitName} a daily habit',
                      style: TextStyle(
                        fontSize: ViewHabitScreenTextStyle.paragraphSize,
                        fontWeight: ViewHabitScreenTextStyle.paragraphWeight,
                        color: const Color(0xff062540),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 27.0.h,
                ),
                _buildSummaryContainerForGoal(addHabit),
                SizedBox(
                  height: 27.24.h,
                ),
                _buildSummaryContainerForPunishment(addHabit),
                SizedBox(
                  height: 27.0.h,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 21.74.w),
                    child: Text(
                      'time to commit to it',
                      style: TextStyle(
                          fontSize: ViewHabitScreenTextStyle.paragraphSize,
                          fontWeight: ViewHabitScreenTextStyle.paragraphWeight,
                          color: const Color(0xff062540)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 113.0.h,
                ),
                _buildButton(context, addHabit),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryContainerForGoal(AddHabitsProvider addHabit) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 26.23.w, top: 19.0.h),
          height: 95.45.h,
          width: 333.0.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    'after i ',
                    style: TextStyle(fontSize: 14.0.sp),
                  ),
                  Text(
                    addHabit.reminderHabit + ' ⏳',
                    style: TextStyle(
                        fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'i will ',
                    style: TextStyle(fontSize: 14.0.sp),
                  ),
                  Text(
                    addHabit.exactBehaviour + ' 😇',
                    style: TextStyle(
                        fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    'so that i can ',
                    style: TextStyle(fontSize: 14.0.sp),
                  ),
                  Text(
                    addHabit.reward + ' 🙈',
                    style: TextStyle(
                        fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            left: 26.23.w,
            bottom: 5.0.w,
          ),
          height: 54.55.h,
          width: 333.0.w,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(20.0.r)),
            color: const Color(0xffFA8A3C),
          ),
          child: Text(
            'remind me at ${DateFormat('hh:mm a').format(DateTime.fromMillisecondsSinceEpoch(int.parse(addHabit.reminderTime)))}',
            style: TextStyle(
                fontSize: ViewHabitScreenTextStyle.paragraphSize,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget _buildSummaryContainerForPunishment(AddHabitsProvider addHabit) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.only(left: 26.23.w, top: 19.0.h),
          height: 95.45.h,
          width: 333.0.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'i\'ll do this for ',
                    style: TextStyle(fontSize: 14.0.sp),
                  ),
                  Text(
                    addHabit.daysPerMonth + ' 🎯',
                    style: TextStyle(
                        fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                      fontSize: 14.0.sp,
                      color: Colors.black,
                      fontFamily: 'Poppins'),
                  children: [
                    TextSpan(
                      text: 'if i don\'t, i will ',
                      style: TextStyle(fontSize: 14.0.sp),
                    ),
                    TextSpan(
                      text: addHabit.punishment + ' 🤐',
                      style: TextStyle(
                          fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.only(
            left: 26.23.w,
            bottom: 5.0.w,
          ),
          height: 54.55.h,
          width: 333.0.w,
          decoration: BoxDecoration(
            borderRadius:
                BorderRadius.vertical(bottom: Radius.circular(20.0.r)),
            color: const Color(0xffFA8A3C),
          ),
          child: Text(
            '${addHabit.friend} will check this',
            style: TextStyle(
                fontSize: ViewHabitScreenTextStyle.paragraphSize,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget _buildBackButtonAndTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RoundBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColour: Colors.white,
        ),
        Text(
          widget.habitName,
          style: TextStyle(
              fontSize: ViewHabitScreenTextStyle.headingSize,
              fontWeight: ViewHabitScreenTextStyle.headingWeight,
              color: const Color(0xff062540)),
        ),
      ],
    );
  }

  Padding _buildButton(BuildContext context, AddHabitsProvider addHabit) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 61.0.w),
      child: CustomTextButton(
        message: 'commit to plan',
        fontSize: ViewHabitScreenTextStyle.buttonTextSize,
        fontWeight: ViewHabitScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.r,
        elevation: 0,
        onTap: () async {
          //  print(addHabit.createHabitRequestModel.toJson());
          CustomProgressIndicator().buildShowDialog(context);

          if (await addHabit.createUserHabit() == 200) {
            var alarmProvider =
                Provider.of<AlarmProvider>(context, listen: false);
            alarmProvider.authToken = await addHabit.getsharedToken();
            alarmProvider.habitId = addHabit.habitDetails;
            String alarmName = "";
            // production
            switch (addHabit.habitDetails) {
              case '620d605f39e03e00128b6f43': //reading
                alarmProvider.alarmId = "123";
                alarmName = 'read';
                break;
              case '620d60f539e03e00128b6f48': //running
                alarmProvider.alarmId = "234";
                alarmName = 'run';
                break;
              case '620d5fbc39e03e00128b6f3d': //exercise
                alarmProvider.alarmId = "345";
                alarmName = 'exercise';
                break;
            }

            // test
            // switch (addHabit.habitDetails) {
            //   case '61c9ad33e5d53c0011dab03e': //reading
            //     alarmProvider.alarmId = "123";
            //     alarmName = 'read';
            //     break;
            //   case '61c9ae14e5d53c0011dab062': //running
            //     alarmProvider.alarmId = "234";
            //     alarmName = 'run';
            //     break;
            //   case '61c9cd8495adfb001202e196': //exercise
            //     alarmProvider.alarmId = "345";
            //     alarmName = 'exercise';
            //     break;
            // }
            alarmProvider.fullPlanText = 'after i ' +
                addHabit.reminderHabit +
                ' ⏳' +
                '\ni will ' +
                addHabit.exactBehaviour +
                ' 😇' +
                '\nso that i can ' +
                addHabit.reward +
                ' 🙈';
            // alarmProvider.hour = addHabit.reminderTime.contains('PM')
            //     ? (int.parse(
            //                 addHabit.reminderTime.split(" ")[0].split(":")[0]) +
            //             12)
            //         .toString()
            //     : addHabit.reminderTime.split(" ")[0].split(":")[0];
            // alarmProvider.min =
            //     addHabit.reminderTime.split(":")[1].split(" ")[0];
            alarmProvider.habitPlanRemainderText = "it’s time to " + alarmName;
            alarmProvider.notificationTitle = "it’s time to " + alarmName;
            alarmProvider.notificationDescription =
                "don't break your streak 🔥";

            if (alarmProvider.cancelAlarmFlag) {
              // print("cancel Alarm called");
              await alarmProvider.cancelAlarm(
                  passAlarmId: int.parse(alarmProvider.alarmId!));

              alarmProvider.cancelAlarmFlag = false;
            } else {
              await alarmProvider.setAlaramDataLocally(alarmProvider.alarmId!);
              await alarmProvider.setAlarm();
              // print("set alarm called");
            }

            Provider.of<HabitTabProvider>(context, listen: false)
                .getHabitTabData(context: context); // update habits

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('habit created successfully!'),
                backgroundColor: Color(0xffDF532B),
                duration: Duration(milliseconds: 3000),
              ),
            );

            navigatorPush(
              context,
              const NewHabitAddedPage(),
            );
          } else {
            Navigator.pop(context);
            Fluttertoast.showToast(
              msg: "something went Wrong!",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0,
            );
          }
        },
      ),
    );
  }
}
