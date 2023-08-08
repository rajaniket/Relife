import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/providers/others_profile_provider.dart';

import 'package:relife/providers/profile_provider.dart';
import 'package:relife/ui/pages/profile/other_user_profile.dart';
import 'package:relife/ui/pages/profile/profile_page.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/ui/widgets/progress_loader.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import '../../../model/service model/get_system_habits_model.dart';

class LeaderboardPage extends StatefulWidget {
  final List<Leaderboard> leaderBoard;
  const LeaderboardPage({Key? key, required this.leaderBoard})
      : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  ScreenshotController screenshotController = ScreenshotController();

  void _takeScreenshot() async {
    String UserName =
        Provider.of<ProfileProvider>(context, listen: false).firstName;
    final imageFile = await screenshotController.capture(
        delay: const Duration(milliseconds: 5));
    if (imageFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(imageFile);
      Share.shareFiles([imagePath.path], subject: "${widget}");
    }
  }

  @override
  Widget build(BuildContext context) {
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Screenshot(
              controller: screenshotController,
              child: Container(
                color: const Color(
                    0xffF7F6F2), // color is provided due to screenshot background
                child: Column(
                  children: [
                    SizedBox(
                      height: 10.0.h,
                    ),
                    Stack(
                      children: [
                        _buildBackButtonAndTitle(context),
                        Positioned(
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 28.w, right: 21.w, top: 25.h),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 10.h),
                                  child: Column(
                                    children: [
                                      Text(
                                        'this month',
                                        style: TextStyle(
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      SizedBox(
                                          width: 100.r,
                                          child: Divider(
                                            height: 0,
                                            thickness: 1.5.r,
                                            color: const Color(0xffFA8A3C)
                                                .withOpacity(0.6),
                                          )),
                                    ],
                                  ),
                                ),
                                SvgPicture.asset(
                                  AppAssets.leaderboardCup,
                                  height: 75.r,
                                  width: 75.r,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 5.0.h,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 15.h),
                        child: NotificationListener<
                            OverscrollIndicatorNotification>(
                          onNotification:
                              (OverscrollIndicatorNotification overscroll) {
                            overscroll.disallowIndicator();
                            return false;
                          },
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(widget.leaderBoard.length,
                                  (index) {
                                // print(leader);
                                final leaderboardData =
                                    widget.leaderBoard[index]; //leader[index];
                                final currentUserId =
                                    Provider.of<ProfileProvider>(context,
                                            listen: false)
                                        .userId;

                                return Padding(
                                  padding:
                                      EdgeInsets.only(left: 10.w, right: 14.w),
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      borderRadius: BorderRadius.circular(10.r),
                                      onTap: () async {
                                        final personalProfile =
                                            Provider.of<ProfileProvider>(
                                                context,
                                                listen: false);
                                        if (widget.leaderBoard[index].id ==
                                            personalProfile.userId) {
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return const ProfilePage();
                                          }));
                                        } else {
                                          final otherProfile = Provider.of<
                                                  OthersProfileProvider>(
                                              context,
                                              listen: false);
                                          CustomProgressIndicator()
                                              .buildShowDialog(context);
                                          await otherProfile.getProfile(
                                              widget.leaderBoard[index].id);
                                          Navigator.pop(context);
                                          Navigator.push(context,
                                              MaterialPageRoute(builder: (_) {
                                            return OtherProfilePage(
                                                id: widget
                                                    .leaderBoard[index].id);
                                          }));
                                        }
                                      },
                                      child: Container(
                                        // padding: EdgeInsets.only(
                                        //   top: 7.h,
                                        // ),

                                        decoration: BoxDecoration(
                                            color: leaderboardData.id ==
                                                    currentUserId
                                                ? const Color(0xffF08A5D)
                                                    .withOpacity(0.3)
                                                : Colors.transparent,
                                            borderRadius:
                                                BorderRadius.circular(10.r)),
                                        child: _BuildUserDetail(
                                          userName: leaderboardData.firstName +
                                              ' ' +
                                              leaderboardData.lastName,
                                          ranking: index + 1,
                                          time: leaderboardData
                                              .postsCountInCurrentMonth
                                              .toString(),
                                          imgUrl: leaderboardData
                                                      .profilePicture !=
                                                  ''
                                              ? 'https://relife.co.in/api/${leaderboardData.profilePicture}'
                                              : "https://www.bsn.eu/wp-content/uploads/2016/12/user-icon-image-placeholder.jpg",
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10.0.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 21.0.w),
            child: Text(
              'who knew, building healthy habits could be this fun 😉',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            height: 20.0.h,
          ),
          _buildButton(context),
          SizedBox(
            height: 15.0.h,
          ),
        ],
      ),
    );
  }

  Padding _buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 61.0.w),
      child: CustomTextButton(
        message: 'share with friends',
        fontSize: ViewHabitScreenTextStyle.buttonTextSize,
        fontWeight: ViewHabitScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.0.sp,
        elevation: 0,
        onTap: () {
          _takeScreenshot();
        },
      ),
    );
  }

  Widget _buildBackButtonAndTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        RoundBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
          backgroundColour: Colors.white,
        ),
        Text(
          'leaderboard',
          style: TextStyle(
              fontSize: ViewHabitScreenTextStyle.headingSize,
              fontWeight: ViewHabitScreenTextStyle.headingWeight,
              color: const Color(0xff062540)),
        ),
      ],
    );
  }
}

class _BuildUserDetail extends StatelessWidget {
  final String userName, time, imgUrl;
  final int ranking;
  const _BuildUserDetail({
    Key? key,
    required this.userName,
    required this.ranking,
    required this.time,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
      child: Padding(
        padding: EdgeInsets.only(left: 2.0.w, right: 18.0.w),
        child: Container(
          padding: EdgeInsets.only(top: 3.0.h, right: 5.0.w),
          //width: 336.w,
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    width: 40.w,
                    child: FittedBox(
                      child: Text(
                        '# $ranking',
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          width: 2.r, color: const Color(0xffFA8A3C)),
                      shape: BoxShape.circle,
                    ),
                    child: ClipOval(
                      child: SizedBox(
                        height: 31.0.r,
                        width: 31.0.r,
                        child: CachedNetworkImage(
                          imageUrl: imgUrl,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  SizedBox(
                    width: 160.w,
                    child: Text(
                      userName,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
              Text(
                '$time days',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
