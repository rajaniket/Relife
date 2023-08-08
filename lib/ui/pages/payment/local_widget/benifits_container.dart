import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BenifitsContainer extends StatelessWidget {
  final String imgPath;
  final String heading;
  final String body;
  const BenifitsContainer({
    Key? key,
    required this.imgPath,
    required this.heading,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150.h,
          width: 150.w,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(imgPath),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 10.h),
          child: Text(
            heading,
            style: TextStyle(
              fontSize: 18.sp,
              color: Colors.white,
              letterSpacing: 0.06.sp,
              fontWeight: FontWeight.w600,
              fontFamily: 'Poppins',
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 13.h),
          child: Text(
            body,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.06.sp,
              fontFamily: 'Poppins',
            ),
          ),
        ),
      ],
    );
  }
}
