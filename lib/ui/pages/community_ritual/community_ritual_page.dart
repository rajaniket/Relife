import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/text_data.dart';

import '../../../constants/colors.dart';
import '../../../utils/page_transition_navigator/custom_navigator_push.dart';
import '../../widgets/custom_text_button.dart';

class CommunityRitualPage extends StatelessWidget {
  const CommunityRitualPage({Key? key}) : super(key: key);
  final userName = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F2),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50.0.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25),
              child: Text(
                'community rituals 🙌🏻',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff062540)),
              ),
            ),
            SizedBox(
              height: 43.h,
            ),
            ritualWidget(
              heading: "open up",
              text:
                  "during introduction, share your biggest challenge with building habits",
              assetLocation: AppAssets.openUpIcon,
            ),
            ritualWidget(
              heading: "always motivate others",
              text: "likes and encouraging comments go a long way!",
              assetLocation: AppAssets.thumbLike,
            ),
            ritualWidget(
              heading: "never miss twice",
              text:
                  "if you miss a habit once, make it a priority to do it on the next day. and add #nevermisstwice to your post",
              assetLocation: AppAssets.crossCalendar,
            ),
            ritualWidget(
              heading: "lookout for others",
              text:
                  "if you see #nevermisstwice, motivate them extra! if you don’t see someone post in a while, tag them",
              assetLocation: AppAssets.lookOut,
            ),
            SizedBox(
              height: 93.h,
            ),
            _buildButton(context),
            SizedBox(
              height: 23.0.h,
            ),
            Center(
              child: Text(
                'let’s go get that healthy lifestyle 💪🏻',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ritualWidget({
    required String heading,
    required String text,
    required String assetLocation,
  }) {
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 18, bottom: 28.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 7.0.h),
            child: CircleAvatar(
              child: SvgPicture.asset(
                assetLocation,
                color: const Color(0xff062540),
              ),
              radius: 18,
              backgroundColor: const Color(0xffF4CBB6),
            ),
          ),
          SizedBox(
            width: 17.w,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  heading, // "open up",
                  style: TextStyle(
                      color: const Color(0xff062540),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  text, //"during introduction, share your biggest challenge with building habits",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
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
        message: 'sounds great :)',
        fontSize: ViewHabitScreenTextStyle.buttonTextSize,
        fontWeight: ViewHabitScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.0.sp,
        elevation: 0,
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
