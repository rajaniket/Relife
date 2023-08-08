import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PlanContainer extends StatelessWidget {
  final String heading1;
  final String heading2;
  final String heading3;
  final String heading4;
  final String point1;
  final String point2;
  final String point3;
  final String buttonText;
  final VoidCallback onPressed;
  final Color color;
  final String? stackText;
  const PlanContainer({
    Key? key,
    required this.heading1,
    required this.heading2,
    required this.heading3,
    required this.heading4,
    required this.point1,
    required this.point2,
    required this.point3,
    required this.buttonText,
    required this.onPressed,
    required this.color,
    this.stackText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 354.h,
      width: 292.w,
      child: Stack(
        children: [
          Container(
            height: 354.h,
            width: 292.w,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
                border: heading1 == 'believer'
                    ? Border.all(color: const Color(0xffFA8A3C), width: 3.r)
                    : null),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 6.h, left: 19.w),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    height: 37.h,
                    child: Text(
                      heading1,
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        height: 27 / 18.sp,
                        letterSpacing: 0.06,
                        color: const Color(0xffDF532B),
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 16.h, left: 10.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    alignment: Alignment.centerLeft,
                    height: 37.h,
                    child: Text(
                      heading2,
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xffDF532B),
                          fontFamily: 'Poppins',
                          letterSpacing: 0.06,
                          height: 36 / 24.sp),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.h, left: 17.w),
                  child: Container(
                    height: 21.h,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      heading3,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff000000).withOpacity(0.5),
                          fontFamily: 'Poppins',
                          letterSpacing: 0.06,
                          height: 21 / 24.sp),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 33.h, left: 17.w),
                  child: Container(
                    //height: 21.h,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      heading4,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff000000),
                        fontFamily: 'Poppins',
                        //letterSpacing: 0.6.sp,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 4.h, left: 17.w),
                  child: Column(
                    children: [
                      _buildBullets(point1),
                      _buildBullets(point2),
                      _buildBullets(point3),
                    ],
                  ),
                ),
                const Spacer(),
                Padding(
                    padding:
                        EdgeInsets.only(bottom: 14.h, left: 60.w, right: 60.w),
                    child: _button(
                      color: color,
                      onPressed: onPressed,
                      text: buttonText,
                    ))
              ],
            ),
          ),
          if (heading1 == 'believer')
            Align(
              alignment: Alignment.topRight,
              child: Container(
                width: 119.w,
                height: 25.h,
                decoration: BoxDecoration(
                  color: const Color(0xffFA8A3C),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.r),
                      topRight: Radius.circular(10.r)),
                ),
                child: Center(
                    child: Text(
                  stackText!,
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                )),
              ),
            )
        ],
      ),
    );
  }

  Widget _buildBullets(String point) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          alignment: Alignment.centerLeft,
          height: 25.h,
          child: CircleAvatar(
            backgroundColor: const Color(0xffDF532B),
            radius: 4.r,
          ),
        ),
        SizedBox(
          width: 6.w,
        ),
        Text(
          point,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 21.h / 14,
            fontFamily: 'Poppins',
          ),
        )
      ],
    );
  }

  Widget _button(
      {required VoidCallback onPressed,
      required String text,
      required Color color}) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 41.h,
        width: 171.w,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(30.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Poppins',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
