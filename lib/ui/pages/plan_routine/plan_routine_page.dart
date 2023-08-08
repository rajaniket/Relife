import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/providers/add_habits_provider.dart';
import 'package:relife/providers/alarm_provider.dart';
import 'package:relife/providers/system_habits_provider.dart';
import 'package:relife/ui/pages/accountability/accountability.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:relife/ui/widgets/bottom_sheet_for_recommendation.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/ui/widgets/day_picker.dart';
import 'package:relife/ui/widgets/linear_page_progress_indicator.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';

class PlanRoutinePage extends StatefulWidget {
  final String habitName;
  const PlanRoutinePage({Key? key, required this.habitName}) : super(key: key);

  @override
  State<PlanRoutinePage> createState() => _PlanRoutinePageState();
}

class _PlanRoutinePageState extends State<PlanRoutinePage> {
  final String selectReminderHabit = "select reminder habit";

  final String selectExactBehaviour = "select exact behaviour";

  final String selectReward = "select reward";

  final String selectTime = "select time";

  final List<String> selectRewardRecommendList = [
    "enjoy my coffee",
    "eat a cookie",
    "take a shower",
    "call mom",
    "watch netflix",
    "watch youtube",
    "lie down on bed"
  ];

  final List<DayInWeek> _days = [
    DayInWeek(
      "SUN",
    ),
    DayInWeek(
      "MON",
    ),
    DayInWeek(
      "TUE",
    ),
    DayInWeek(
      "WED",
    ),
    DayInWeek(
      "THR",
    ),
    DayInWeek(
      "FRI",
    ),
    DayInWeek(
      "SAT",
    ),
  ];

  @override
  void initState() {
    final addHabitProvider =
        Provider.of<AddHabitsProvider>(context, listen: false);
    addHabitProvider.resetHabitData();
  }

  @override
  Widget build(BuildContext context) {
    final systemHabits =
        Provider.of<SystemHabitsProvider>(context, listen: false);
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
      body: Consumer<AddHabitsProvider>(
        builder: (context, addHabit, child) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildPageProgressIndicator(),
              SizedBox(
                height: 7.0.h,
              ),
              _buildBackButton(),
              SizedBox(
                height: 40.0.h,
              ),
              _buildSubHeading(message: 'after i'),
              SizedBox(
                height: 14.0.h,
              ),
              _buildParagraph(
                message: addHabit.reminderHabit,
                onTap: () => buildBottomSheetRecommendation(
                  context: context,
                  heading: "select reminder habit",
                  subHeading:
                      "something that you do everyday, around the same time",
                  recommended: systemHabits.remainderHabits,
                  //index: systemHabits.remainderHabits.
                ),
              ),
              SizedBox(
                height: 22.0.h,
              ),
              _buildSubHeading(message: 'i will'),
              SizedBox(
                height: 14.0.h,
              ),
              _buildParagraph(
                message: addHabit.exactBehaviour,
                onTap: () => buildBottomSheetRecommendationExactBehaviour(
                  context: context,
                  heading: "select exact behaviour",
                  subHeading:
                      "being specific increases chances of building a habit",
                  recommended: systemHabits.exactBehaviour,
                ),
              ),
              SizedBox(
                height: 22.0.h,
              ),
              _buildSubHeading(message: 'so that i can'),
              SizedBox(
                height: 14.0.h,
              ),
              _buildParagraph(
                message: addHabit.reward,
                onTap: () => buildBottomSheetRecommendationReward(
                    context: context,
                    heading: "select reward",
                    subHeading: "something that you do often and enjoy a lot",
                    recommended: selectRewardRecommendList),
              ),
              SizedBox(
                height: 22.0.h,
              ),
              _buildSubHeading(
                message: 'select Time',
              ),
              SizedBox(
                height: 14.0.h,
              ),
              _buildParagraph(
                  // message: DateFormat('hh:mm a').format(
                  //     DateTime.fromMillisecondsSinceEpoch(
                  //         int.parse(addHabit.reminderTime))),
                  message: addHabit.reminderTime == "select time"
                      ? addHabit.reminderTime
                      : DateFormat('hh:mm a').format(
                          DateTime.fromMillisecondsSinceEpoch(
                              int.parse(addHabit.reminderTime))),
                  onTap: () async {
                    // print(addHabit.createHabitRequestModel.toJson().toString());
                    DateTime? newTime;
                    if (addHabit.reminderTime != "select time") {
                      newTime = DateTime.fromMillisecondsSinceEpoch(
                          int.parse(addHabit.reminderTime));
                    }
                    List<String> days = [];

                    await showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.white,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(25.0.r),
                        ),
                      ),
                      builder: (context) => Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 31.h,
                          ),
                          Text(
                            'select time',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w400),
                          ),
                          SizedBox(
                            height: 25.h,
                          ),
                          SizedBox(
                            height: 100.h,
                            width: 250.w,
                            child: CupertinoDatePicker(
                              mode: CupertinoDatePickerMode.time,
                              onDateTimeChanged: (time) {
                                newTime = time;
                              },
                              initialDateTime: DateTime.now(),
                              minuteInterval: 1,
                            ),
                          ),
                          // TimePickerSpinner(
                          //   is24HourMode: false,
                          //   normalTextStyle: TextStyle(
                          //       fontSize: 18.sp, color: Colors.grey[400]),
                          //   highlightedTextStyle:
                          //       TextStyle(fontSize: 18.sp, color: Colors.black),
                          //   spacing: 40,
                          //   itemHeight: 60,
                          //   isForce2Digits: true,
                          //   onTimeChange: (time) {
                          //     newTime = TimeOfDay.fromDateTime(time);
                          //   },
                          // ),
                          SizedBox(height: 31.h),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22.w),
                            child: SelectWeekDays(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              days: _days,
                              border: false,
                              boxDecoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              // daysBorderColor: Colors.green,
                              daysFillColor: Colors.white, // Color(0xffFA8A3C),

                              unSelectedDayTextColor: Colors.black,
                              onSelect: (values) {
                                // List of string
                                // <== Callback to handle the selected days
                                // print(values);
                                days = values;
                              },
                            ),
                          ),
                          SizedBox(height: 31.h),
                          SizedBox(
                            width: 239.w,
                            child: CustomTextButton(
                              message: 'select time',
                              fontSize: SecretScreenTextStyle.buttonTextSize,
                              fontWeight:
                                  SecretScreenTextStyle.buttonTextWeight,
                              buttonColor: AppColors.buttonColor,
                              buttonSize: Size(double.infinity, 47.0.h),
                              borderRadius: 30.r,
                              elevation: 0,
                              onTap: () {
                                // print("new time ________ :$newTime");

                                addHabit.setReminderTime(
                                    newTime!.millisecondsSinceEpoch.toString());
                                addHabit.createHabitRequestModel.reminderTime =
                                    newTime!.millisecondsSinceEpoch.toString();

                                var alarmProvider = Provider.of<AlarmProvider>(
                                    context,
                                    listen: false);
                                alarmProvider.hour = newTime!.hour.toString();
                                alarmProvider.min = newTime!.minute.toString();

                                int currentHour = DateTime.now().hour;
                                int currentMin = DateTime.now().minute;

                                alarmProvider.mon =
                                    days.contains("MON") ? "1" : "0";
                                alarmProvider.tue =
                                    days.contains("TUE") ? "1" : "0";
                                alarmProvider.wed =
                                    days.contains("WED") ? "1" : "0";
                                alarmProvider.thr =
                                    days.contains("THR") ? "1" : "0";
                                alarmProvider.fri =
                                    days.contains("FRI") ? "1" : "0";
                                alarmProvider.sat =
                                    days.contains("SAT") ? "1" : "0";
                                alarmProvider.sun =
                                    days.contains("SUN") ? "1" : "0";
                                List<int> daysList =
                                    alarmProvider.getListOfweekDaysAlarm();
                                // print(daysList);

                                if (daysList.every(
                                    (element) => element == 0 ? true : false)) {
                                  //print("cancel alarm");

                                  alarmProvider.cancelAlarmFlag = true;
                                  // cancel alarm
                                } else {
                                  if (newTime!.hour > currentHour) {
                                    DateTime date = DateTime.now();

                                    bool condition = true;
                                    if (daysList[date.weekday - 1] == 1) {
                                      alarmProvider.startDays = null;
                                    } else {
                                      while (condition) {
                                        if (daysList[date.weekday - 1] == 1) {
                                          alarmProvider.startDays =
                                              DateFormat('yyyy-MM-dd hh:mm:ss')
                                                  .format(date);
                                          condition = false;
                                        } else {
                                          date =
                                              date.add(const Duration(days: 1));
                                        }
                                      }
                                    }
                                  } else if (newTime!.hour == currentHour) {
                                    if (newTime!.minute > currentMin) {
                                      DateTime date = DateTime.now();

                                      bool condition = true;
                                      if (daysList[date.weekday - 1] == 1) {
                                        alarmProvider.startDays = null;
                                      } else {
                                        while (condition) {
                                          if (daysList[date.weekday - 1] == 1) {
                                            alarmProvider.startDays =
                                                DateFormat(
                                                        'yyyy-MM-dd hh:mm:ss')
                                                    .format(date);
                                            condition = false;
                                          } else {
                                            date = date
                                                .add(const Duration(days: 1));
                                          }
                                        }
                                      }
                                    } else {
                                      DateTime date = DateTime.now()
                                          .add(const Duration(days: 1));
                                      bool condition = true;

                                      while (condition) {
                                        if (daysList[date.weekday - 1] == 1) {
                                          alarmProvider.startDays =
                                              DateFormat('yyyy-MM-dd hh:mm:ss')
                                                  .format(date);
                                          condition = false;
                                        } else {
                                          date =
                                              date.add(const Duration(days: 1));
                                        }
                                      }
                                    }
                                  } else {
                                    DateTime date = DateTime.now()
                                        .add(const Duration(days: 1));
                                    bool condition = true;

                                    while (condition) {
                                      if (daysList[date.weekday - 1] == 1) {
                                        alarmProvider.startDays =
                                            DateFormat('yyyy-MM-dd hh:mm:ss')
                                                .format(date);
                                        condition = false;
                                      } else {
                                        date =
                                            date.add(const Duration(days: 1));
                                      }
                                    }
                                  }
                                }
                                // print(
                                //     "________________ ${alarmProvider.startDays}");

                                // addHabit.setReminderDays(daysList);

                                Navigator.pop(context);
                              },
                            ),
                          ),
                          SizedBox(height: 52.h),
                        ],
                      ),
                    );
                  }),
              SizedBox(
                height: 73.0.h,
              ),
              _buildButton(context, systemHabits),
            ],
          ),
        ),
      ),
    );
  }

  // Widget buildRecommendedWidgets(){

  // }

  Padding _buildButton(
      BuildContext context, SystemHabitsProvider systemHabits) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 61.0.w),
      child: CustomTextButton(
        message: 'proceed',
        fontSize: SecretScreenTextStyle.buttonTextSize,
        fontWeight: SecretScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.0.r,
        elevation: 0,
        onTap: () {
          final addHabit =
              Provider.of<AddHabitsProvider>(context, listen: false);
          //print(addHabit.createHabitRequestModel.toJson());
          addHabit.setHabitDetails(systemHabits.habitDetails);
          navigatorPush(
            context,
            AccountabilityPage(
              habitName: widget.habitName,
            ),
          );
        },
      ),
    );
  }

  Widget _buildParagraph(
      {required String message, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 336.0.w,
        height: 60.0.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0.r),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            message,
            style: TextStyle(
                fontSize: PlanRoutineScreenTextStyle.paragraphSize,
                fontWeight: PlanRoutineScreenTextStyle.paragraphWeight,
                color: const Color(0xff000000).withOpacity(0.5)),
          ),
        ),
      ),
    );
  }

  Align _buildSubHeading({
    required String message,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 29.0.w),
        child: Text(
          message,
          style: TextStyle(
              fontSize: PlanRoutineScreenTextStyle.subHeadingSize,
              fontWeight: PlanRoutineScreenTextStyle.subHeadingWeight500,
              color: Colors.black),
        ),
      ),
    );
  }

  Padding _buildPageProgressIndicator() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0.h, left: 30.0.w, right: 30.0.w),
      child: const LinearPageProgressIndicator(
        percentageProgress: 0.54,
      ),
    );
  }

  Widget _buildBackButton() {
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
          'plan my routine',
          style: TextStyle(
              fontSize: PlanRoutineScreenTextStyle.headingSize,
              fontWeight: PlanRoutineScreenTextStyle.headingWeight,
              color: const Color(0xff062540)),
        ),
      ],
    );
  }
}
