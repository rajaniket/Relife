import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/ui/pages/plan_routine/update_plan_routine.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/ui/widgets/linear_page_progress_indicator.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';
import 'package:relife/model/service%20model/get_user_all_habits_model.dart';

class UpdateHabitStackingPage extends StatelessWidget {
  final Detail detail;
  const UpdateHabitStackingPage({Key? key, required this.detail})
      : super(key: key);
  final message1 = "reminder habits & rewards\nare super effective";
  final message2 =
      "after i have dinner\ni will read for 15 mins\nso that i can watch netflix";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xff062540),

          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      backgroundColor: AppColors.habitStackingScreenBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPageProgressIndicator(),
            SizedBox(
              height: 7.0.h,
            ),
            _buildBackButton(context),
            SizedBox(
              height: 29.0.h,
            ),
            _buildHeadingText(),
            SizedBox(
              height: 122.5.h,
            ),
            _buildReminderReadingReward(),
            SizedBox(
              height: 84.0.h,
            ),
            _buildParagraphText(),
            SizedBox(
              height: 63.0.h,
            ),
            _buildButton(context)
          ],
        ),
      ),
    );
  }

  Padding _buildReminderReadingReward() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.0.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildReminderHabit(),
          SizedBox(
            width: 6.0.w,
          ),
          _buildArrowSign(),
          SizedBox(
            width: 6.0.w,
          ),
          _buildReading(),
          SizedBox(
            width: 6.0.w,
          ),
          _buildArrowSign(),
          SizedBox(
            width: 6.0.w,
          ),
          _buildReward(),
        ],
      ),
    );
  }

  Expanded _buildReward() {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(0.0),
            height: 87.0.r,
            width: 87.0.r,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppAssets.reward,
            ),
          ),
          SizedBox(
            height: 15.5.h,
          ),
          FittedBox(
            child: Text(
              'reward',
              style: TextStyle(
                  fontSize: HabitStackingScreenTextStyle.paragraphSize,
                  fontWeight: HabitStackingScreenTextStyle.paragraphWeight,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildReading() {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            height: 87.0.r,
            width: 87.0.r,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppAssets.readingStacking,
            ),
          ),
          SizedBox(
            height: 15.5.h,
          ),
          FittedBox(
            child: Text(
              'reading',
              style: TextStyle(
                  fontSize: HabitStackingScreenTextStyle.paragraphSize,
                  fontWeight: HabitStackingScreenTextStyle.paragraphWeight,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildArrowSign() {
    return Padding(
      padding: EdgeInsets.only(top: 30.h),
      child: Icon(
        Icons.arrow_right_alt_sharp,
        size: 24.0.w,
        color: Colors.white,
      ),
    );
  }

  Widget _buildReminderHabit() {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            height: 87.0.r,
            width: 87.0.r,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: SvgPicture.asset(
              AppAssets.reminderHabit,
            ),
          ),
          SizedBox(
            height: 15.5.h,
          ),
          FittedBox(
            child: Text(
              'reminder\nhabit',
              style: TextStyle(
                  fontSize: HabitStackingScreenTextStyle.paragraphSize,
                  fontWeight: HabitStackingScreenTextStyle.paragraphWeight,
                  color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: RoundBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );

  Padding _buildPageProgressIndicator() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0.h, left: 30.0.w, right: 30.0.w),
      child: const LinearPageProgressIndicator(
        percentageProgress: 0.36,
      ),
    );
  }

  Text _buildHeadingText() {
    return Text(
      message1,
      style: TextStyle(
          fontSize: HabitStackingScreenTextStyle.headingSize,
          fontWeight: HabitStackingScreenTextStyle.headingWeight,
          color: Colors.white),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildParagraphText() {
    return Text(
      message2,
      style: TextStyle(
          fontSize: SecretScreenTextStyle.paragraphSize,
          fontWeight: SecretScreenTextStyle.paragraphWeight,
          color: Colors.white),
      textAlign: TextAlign.center,
    );
  }

  Padding _buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 53.0.w),
      child: CustomTextButton(
        message: 'plan my routine',
        fontSize: SecretScreenTextStyle.buttonTextSize,
        fontWeight: SecretScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.0.r,
        elevation: 0,
        onTap: () {
          navigatorPush(
              context,
              UpdatePlanRoutinePage(
                detail: detail,
              ));
        },
      ),
    );
  }
}
