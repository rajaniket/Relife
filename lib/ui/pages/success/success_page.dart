import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/model/service%20model/get_user_all_habits_model.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/ui/pages/tabs/bottom_navigation_page.dart.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';

class SuccessPage extends StatefulWidget {
  final Detail detail;
  const SuccessPage({Key? key, required this.detail}) : super(key: key);

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  final userName = '';
  int rank = 0;
  int currentStreak = 0;

  @override
  void initState() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    //  print(profileProvider.rankingList);
    for (var i = 0; i < profileProvider.rankingList.length; i++) {
      if (widget.detail.habitDetails.name ==
          profileProvider.rankingList[i].habitName) {
        rank = profileProvider.rankingList[i].rank;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    currentStreak = widget.detail.currentStreak + 1;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xffF7F6F2),

          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      backgroundColor: const Color(0xffF7F6F2),
      body: Column(
        children: [
          SizedBox(
            height: 30.0.h,
          ),
          // Padding(
          //   padding: EdgeInsets.only(right: 20.w),
          //   child: Align(
          //     alignment: Alignment.topRight,
          //     child: IconButton(
          //         onPressed: () {
          //           Navigator.pushAndRemoveUntil(context,
          //               MaterialPageRoute(builder: (_) {
          //             // final getUserHabits =
          //             //     Provider.of<GetUserAllHabitsProvider>(context,
          //             //         listen: false);
          //             // getUserHabits.getUserAllHabits(context);
          //             return const BottomNavigationPage();
          //           }), (route) => false);
          //         },
          //         constraints: const BoxConstraints(),
          //         splashRadius: 20,
          //         padding: EdgeInsets.zero,
          //         icon: SvgPicture.asset(
          //           AppAssets.crossIcon,
          //           height: 20.sp,
          //           color: Colors.black,
          //         )),
          //   ),
          // ),
          SizedBox(
            height: 20.0.h,
          ),
          Center(
            child: Text(
              'doing great, ${profileProvider.firstName}!',
              style: TextStyle(
                  fontSize: NewHabitAddedTextStyle.headingSize,
                  fontWeight: NewHabitAddedTextStyle.headingWeight,
                  color: const Color(0xff062540)),
            ),
          ),
          SizedBox(
            height: 23.0.h,
          ),
          Text(
            'your current streak in\n${widget.detail.habitDetails.name} is $currentStreak days🔥',
            style: TextStyle(
              fontSize: SuccessScreenTextStyle.subHeadingSize,
              fontWeight: SuccessScreenTextStyle.subHeadingWeight,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 3.0.h,
          ),
          Lottie.asset(AppAssets.fistBumpLottie, height: 350.h),
          SizedBox(
            height: 20.0.h,
          ),
          Text(
            'lets keep it up tomorrow!',
            style: TextStyle(
              fontSize: SuccessScreenTextStyle.subHeadingSize,
              fontWeight: SuccessScreenTextStyle.subHeadingWeight,
            ),
          ),
          SizedBox(
            height: 40.0.h,
          ),
          _buildButton(context),
          // Padding(
          //   padding: EdgeInsets.only(top: 23.h, bottom: 0.h),
          //   child: Text(
          //     'your stats will get updated shortly',
          //     style: TextStyle(
          //       fontSize: 13.sp,
          //       fontWeight: FontWeight.w500,
          //       height: 27 / 13.sp,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Padding _buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 61.0.w),
      child: CustomTextButton(
        message: 'i’m awesome :)',
        fontSize: SuccessScreenTextStyle.buttonTextSize,
        fontWeight: SuccessScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.r,
        elevation: 0,
        onTap: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (_) => const BottomNavigationPage(),
              ),
              (route) => false);
        },
      ),
    );
  }
}
