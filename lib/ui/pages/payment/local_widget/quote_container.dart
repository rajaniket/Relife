import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:relife/providers/login_provider.dart';
import 'package:relife/providers/profile_provider.dart';

class QuoteContainer extends StatelessWidget {
  QuoteContainer({Key? key, this.isPaymentPageLogin = false}) : super(key: key);
  bool isPaymentPageLogin;

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    final loginProvider = Provider.of<LoginProvider>(context, listen: false);
    return SizedBox(
      height: 411.h,
      child: Stack(
        children: [
          Container(
            height: 380.h,
            width: 340.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.r),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  top: 20.h, left: 15.w, right: 18.w, bottom: 12.h),
              child: Text(
                """hey ${isPaymentPageLogin ? loginProvider.firstName.split(" ")[0] : profileProvider.firstName},

we know that a motivated peer group significantly increases your chances of building habits. so we make sure only committed people get in through the waitlist

at the same time, we trust you to bring in only committed individuals. so any friends you invite using your invite link can skip the waitlist and directly join relife

go on then, use your superpower. because building habits with friends is more fun!
  """,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xff062540),
                  letterSpacing: 0.6.sp,
                  height: 20 / 14.sp,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 30.w,
            child: RotatedBox(
              quarterTurns: 1,
              child: SizedBox(
                height: 50.h,
                child: const FittedBox(
                  child: Icon(
                    Icons.play_arrow_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
