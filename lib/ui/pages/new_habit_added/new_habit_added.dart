import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/ui/pages/tabs/bottom_navigation_page.dart.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';

class NewHabitAddedPage extends StatelessWidget {
  const NewHabitAddedPage({Key? key}) : super(key: key);
  final userName = '';
  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F2),
      body: Column(
        children: [
          SizedBox(
            height: 94.0.h,
          ),
          Center(
            child: Text(
              'congrats ${profileProvider.firstName}!',
              style: TextStyle(
                  fontSize: NewHabitAddedTextStyle.headingSize,
                  fontWeight: NewHabitAddedTextStyle.headingWeight,
                  color: const Color(0xff062540)),
            ),
          ),
          SizedBox(
            height: 23.0.h,
          ),
          Text(
            'you\'ve added a new habit',
            style: TextStyle(
              fontSize: NewHabitAddedTextStyle.subHeadingSize,
              fontWeight: NewHabitAddedTextStyle.subHeadingWeight500,
            ),
          ),
          SizedBox(
            height: 60.0.h,
          ),
          Image.asset(
            AppAssets.habitAddedGif,
            height: 280.0.h,
          ),
          SizedBox(
            height: 123.0.h,
          ),
          _buildButton(context),
          SizedBox(
            height: 20.0.h,
          ),
          Text(
            'get ready for your relife 😎',
            style: TextStyle(
              fontSize: NewHabitAddedTextStyle.paragraphSize,
              fontWeight: NewHabitAddedTextStyle.paragraphWeight,
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 61.0.w),
      child: CustomTextButton(
        message: 'let\'s go',
        fontSize: ViewHabitScreenTextStyle.buttonTextSize,
        fontWeight: ViewHabitScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.0.sp,
        elevation: 0,
        onTap: () {
          // final getUserHabit =
          //     Provider.of<GetUserHabitsProvider>(context, listen: false);
          navigatorPush(
            context,
            const BottomNavigationPage(),
          );
          // getUserHabit.getUserHabits();
        },
      ),
    );
  }
}
