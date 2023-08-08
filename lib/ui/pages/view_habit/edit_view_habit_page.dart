// ignore_for_file: unnecessary_brace_in_string_interps

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/ui/pages/habit_stacking/update_habit_stacking.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';
import 'package:relife/model/service%20model/get_user_all_habits_model.dart';

class EditViewHabitPage extends StatelessWidget {
  final Detail detail;
  const EditViewHabitPage({
    Key? key,
    required this.detail,
  }) : super(key: key);

  final String habitType = 'reading';
  final String reminderType = 'i have dinner ⏳';
  final String behaviourType = 'read for 15 mins  😇';
  final String rewardType = 'watch netflix 🙈';
  final String remindTime = '8:30 pm';
  final String duration = '25 days this month 🎯';
  final String punishmentType = 'i’ll treat kaushal for\nsome pizza 🤐';
  final String friendName = 'kaushal';

  // String remainderTime() {
  //   int hour = 0;
  //   int min = 0;
  //   String amPm = 'AM';
  //   if (detail.reminderTime / 100 > 12) {
  //     hour = (detail.reminderTime ~/ 100) - 12;
  //     min = (detail.reminderTime) % 100;
  //     amPm = 'PM';
  //   } else {
  //     hour = detail.reminderTime ~/ 100;
  //     min = (detail.reminderTime) % 100;
  //   }
  //   return '$hour:$min $amPm';
  // }

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
                'my plan to make ${detail.habitDetails.name} a daily habit',
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
          _buildSummaryContainerForGoal(
              detail,
              DateFormat('hh:mm a').format(
                  DateTime.fromMillisecondsSinceEpoch(detail.reminderTime))),
          SizedBox(
            height: 27.24.h,
          ),
          _buildSummaryContainerForPunishment(detail),
          SizedBox(
            height: 27.0.h,
          ),
          // Align(
          //   alignment: Alignment.centerLeft,
          //   child: Padding(
          //     padding: EdgeInsets.symmetric(horizontal: 21.74.w),
          //     child: Text(
          //       'time to commit to it',
          //       style: TextStyle(
          //           fontSize: ViewHabitScreenTextStyle.paragraphSize,
          //           fontWeight: ViewHabitScreenTextStyle.paragraphWeight,
          //           color: const Color(0xff062540)),
          //     ),
          //   ),
          // ),
          // SizedBox(
          //   height: 113.0.h,
          // ),
          // _buildButton(context),
        ],
      ),
    );
  }

  Widget _buildSummaryContainerForGoal(Detail detail, String time) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.only(left: 26.23.w, top: 19.0.h),
          // height: 95.45.h,
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
                    detail.reminderHabit + ' ⏳',
                    maxLines: 4,
                    style: TextStyle(
                        fontSize: 14.0.sp, fontWeight: FontWeight.w600),
                    //overflow: TextOverflow.ellipsis,
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
                    detail.exactBehaviour + ' 😇',
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
                    detail.reward + ' 🙈',
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
            'remind me at ' + time,
            style: TextStyle(
                fontSize: ViewHabitScreenTextStyle.paragraphSize,
                fontWeight: FontWeight.w600,
                color: Colors.white),
          ),
        )
      ],
    );
  }

  Widget _buildSummaryContainerForPunishment(Detail detail) {
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
                    '${detail.daysPerMonth} days this month 🎯',
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
                      text: detail.punishment + ' 🤐',
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
            '${detail.accountabilityPartnerName} will check this',
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
        // SizedBox(
        //   width: 18.46.w,
        // ),
        Text(
          detail.habitDetails.name,
          style: TextStyle(
              fontSize: ViewHabitScreenTextStyle.headingSize,
              fontWeight: ViewHabitScreenTextStyle.headingWeight,
              color: const Color(0xff062540)),
        ),
        SizedBox(
          width: 90.w,
        ),
        RoundEditButton(
          onPressed: () {
            navigatorPush(
              context,
              UpdateHabitStackingPage(
                detail: detail,
              ),
            );
          },
          backgroundColour: Colors.white,
        ),
      ],
    );
  }
}
