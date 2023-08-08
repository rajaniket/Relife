import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:relife/constants/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F2),
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 21.w, top: 41.h),
                child: SvgPicture.asset(AppAssets.relifeLogo),
              ),
            ),
            SizedBox(
              height: 178.h,
            ),
            SvgPicture.asset(AppAssets.notFound),
          ],
        ),
      ),
    );
  }
}
