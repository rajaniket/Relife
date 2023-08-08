import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';

Widget habitComponent(
    {required String habit,
    required int numOfUsers,
    required String image,
    required VoidCallback onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      width: 332.17.w,
      height: 80.0.h,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25.0.r), color: Colors.white),
      child: Padding(
        padding: EdgeInsets.fromLTRB(28.0.w, 6.0.h, 12.0.w, 6.0.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(habit,
                    style: TextStyle(
                        fontSize: AddHabitScreenTextStyle.subHeadingSize,
                        fontWeight: AddHabitScreenTextStyle.subHeadingWeight,
                        color: AppColors.defaultTextColor)),
                Text('$numOfUsers others are working on it',
                    style: TextStyle(
                        fontSize: AddHabitScreenTextStyle.paragraphSize,
                        fontWeight: AddHabitScreenTextStyle.paragraphWeight,
                        color: Colors.black))
              ],
            ),
            SvgPicture.asset(
              image,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    ),
  );
}
