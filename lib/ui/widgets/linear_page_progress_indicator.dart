import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:relife/constants/colors.dart';

class LinearPageProgressIndicator extends StatelessWidget {
  final double percentageProgress;
  final Color unfilledColour;
  const LinearPageProgressIndicator({
    Key? key,
    this.percentageProgress = 0.25,
    this.unfilledColour = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.0.h,
      decoration: BoxDecoration(
        color: unfilledColour,
        border: Border.all(color: Colors.black, width: 0),
        borderRadius: BorderRadius.horizontal(
          right: Radius.circular(5.0.r),
          left: Radius.circular(5.0.r),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: FractionallySizedBox(
              widthFactor: percentageProgress,
              alignment: Alignment.centerLeft,
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.progressIndicatorColor,
                  borderRadius: BorderRadius.circular(5.0.r),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
