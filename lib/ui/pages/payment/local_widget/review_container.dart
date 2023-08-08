import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ReviewContainer extends StatelessWidget {
  final int noOfStars;
  final double acctualStar;
  final int noOfReviews;
  final String iconPath;
  final String platform;

  const ReviewContainer(
      {Key? key,
      required this.noOfStars,
      required this.acctualStar,
      required this.noOfReviews,
      required this.iconPath,
      required this.platform})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 151.h,
      width: 320.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '⭐️' * noOfStars,
                style: TextStyle(fontSize: 20.sp),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 2.h, left: 7.w),
                child: Text(
                  '$acctualStar stars',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.6.sp,
                    height: 14 / 21.sp,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 15.h),
            child: Text(
              '$noOfReviews reviews',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: const Color(0xff062540),
                fontSize: 30.sp,
                fontWeight: FontWeight.w700,
                height: 45 / 30.sp,
              ),
            ),
          ),
          SizedBox(height: 14.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                height: 28.h,
              ),
              SizedBox(width: 10.w),
              Text(
                platform,
                style: TextStyle(
                  color: const Color(0xffDF532B),
                  fontSize: 14.sp,
                  height: 21 / 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
