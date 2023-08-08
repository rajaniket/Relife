import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:relife/constants/text_data.dart';

class WhatsNewContainerWidget extends StatelessWidget {
  final String message, imgPath;
  const WhatsNewContainerWidget({
    Key? key,
    required this.message,
    required this.imgPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 12.5.w),
      child: Container(
        padding: EdgeInsets.only(top: 5, bottom: 12.r),
        width: 140.w,
        height: 165.0.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0.r), color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: SizedBox(
                width: 125,
                child: SvgPicture.asset(
                  imgPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 12.r, right: 12.r, top: 7.r),
              child: Text(message,
                  style: TextStyle(
                    fontSize: ExploreTabScreenTextStyle.paragraphSize,
                    fontWeight: ExploreTabScreenTextStyle.paragraphWeight400,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
