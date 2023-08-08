import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> buildBottomSheetRecommendation(
    {required BuildContext context,
    required String heading,
    required String subHeading,
    required List<String> recommended}) {
  return showModalBottomSheet(
      isScrollControlled:
          true, // it'll allow the bottom sheet to take the required height which gives more insurance that TextField is not covered by the keyboard.
      backgroundColor: Colors.white,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0.r),
        ),
      ),
      builder: (context) => SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context)
                      .viewInsets
                      .bottom), // for lifiting the widget upward when textfield is in use
              child: Padding(
                padding: EdgeInsets.only(
                    top: 18.0.h, left: 12.0.w, right: 12.0.w, bottom: 5.0.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [Text('hello')],
                ),
              ),
            ),
          ));
}
