import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/model/service%20model/get_user_all_habits_model.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/ui/pages/tabs/bottom_navigation_page.dart.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';

class AchievementPage extends StatefulWidget {
  final Detail detail;
  const AchievementPage({Key? key, required this.detail}) : super(key: key);

  @override
  State<AchievementPage> createState() => _AchievementPageState();
}

class _AchievementPageState extends State<AchievementPage> {
  String habitName = '';
  int rank = 0;

  @override
  void initState() {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);

    for (var i = 0; i < profileProvider.rankingList.length; i++) {
      if (widget.detail.habitDetails.name ==
          profileProvider.rankingList[i].habitName) {
        habitName = widget.detail.habitDetails.name;
        rank = profileProvider.rankingList[i].rank;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color(0xffFF878B),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 50.0.h,
            ),
            Padding(
              padding: EdgeInsets.only(right: 20.w),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const BottomNavigationPage(),
                          ),
                          (route) => false);
                    },
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                    padding: EdgeInsets.zero,
                    icon: SvgPicture.asset(
                      AppAssets.crossIcon,
                      height: 20.sp,
                      color: Colors.white,
                    )),
              ),
            ),
            SizedBox(
              height: 50.0.h,
            ),
            Center(
              child: Text(
                'congrats, ${profileProvider.firstName}',
                style: TextStyle(
                    fontSize: AchievementsScreenTextStyle.headingSize,
                    fontWeight: AchievementsScreenTextStyle.headingWeight,
                    color: const Color(0xff062540)),
              ),
            ),
            SizedBox(
              height: 23.0.h,
            ),
            Text(
              'you’re reaching new heights',
              style: TextStyle(
                fontSize: AchievementsScreenTextStyle.subHeadingSize,
                fontWeight: AchievementsScreenTextStyle.subHeadingWeight600,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 23.0.h,
            ),
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SvgPicture.asset(AppAssets.achievementCard, height: 270.h),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 10.0.h,
                        ),
                        Image.asset(
                          AppAssets.cupWinner,
                          height: 126.h,
                        ),
                        SizedBox(
                          height: 10.0.h,
                        ),
                        Text('rank #$rank',
                            style: TextStyle(
                                color: const Color(0xffDF532B),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w700)),
                        SizedBox(
                          height: 5.0.h,
                        ),
                        Text('in $habitName this month',
                            style: TextStyle(
                                fontSize: 12.sp, fontWeight: FontWeight.w400)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20.0.h,
            ),
            _buildButton(context, 'share achievement'),
            SizedBox(
              height: 49.0.h,
            ),
            widget.detail.currentStreak >= widget.detail.longestStreak
                ? Column(
                    children: [
                      SizedBox(
                        width: 273.w,
                        child: Divider(
                          color: Colors.white,
                          thickness: 1.h,
                        ),
                      ),
                      SizedBox(
                        height: 35.0.h,
                      ),
                      Text(
                        'this is your best, ever',
                        style: TextStyle(
                          fontSize: AchievementsScreenTextStyle.subHeadingSize,
                          fontWeight:
                              AchievementsScreenTextStyle.subHeadingWeight600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 23.0.h,
                      ),
                      Center(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            SvgPicture.asset(AppAssets.achievementCard,
                                height: 270.h),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 10.0.h,
                                  ),
                                  Image.asset(
                                    AppAssets.medal,
                                    height: 126.h,
                                  ),
                                  SizedBox(
                                    height: 10.0.h,
                                  ),
                                  Text(
                                      '${widget.detail.currentStreak} day streak',
                                      style: TextStyle(
                                          color: const Color(0xffDF532B),
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w700)),
                                  SizedBox(
                                    height: 5.0.h,
                                  ),
                                  Text(
                                      'in ${widget.detail.habitDetails.name} this month',
                                      style: TextStyle(
                                          fontSize: 12.sp,
                                          fontWeight: FontWeight.w400)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.0.h,
                      ),
                      _buildButton(context, 'share streak'),
                      SizedBox(
                        height: 49.0.h,
                      ),
                      Text(
                        'lets keep it up tomorrow!',
                        style: TextStyle(
                          fontSize: AchievementsScreenTextStyle.subHeadingSize,
                          fontWeight:
                              AchievementsScreenTextStyle.subHeadingWeight500,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 38.h,
                      ),
                      Text(
                        'see what others are doing',
                        style: TextStyle(
                            fontSize: 14.0.sp,
                            fontWeight:
                                AchievementsScreenTextStyle.subHeadingWeight600,
                            color: const Color(0xff062540),
                            decoration: TextDecoration.underline),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 51.h,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Padding _buildButton(BuildContext context, String message) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 80.0.w),
      child: CustomTextButton(
        message: message,
        fontSize: SuccessScreenTextStyle.buttonTextSize,
        fontWeight: SuccessScreenTextStyle.buttonTextWeight,
        buttonColor: const Color(0xff062540),
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 12.0.sp,
        elevation: 0,
        onTap: () {},
      ),
    );
  }
}
