import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/providers/add_habits_provider.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/ui/pages/view_habit/view_habit_page.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:relife/ui/widgets/bottom_sheet_for_recommendation.dart';

import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/ui/widgets/linear_page_progress_indicator.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';

class PlanAccountabilityPage extends StatefulWidget {
  final String habitName;
  const PlanAccountabilityPage({Key? key, required this.habitName})
      : super(key: key);

  @override
  State<PlanAccountabilityPage> createState() => _PlanAccountabilityPageState();
}

class _PlanAccountabilityPageState extends State<PlanAccountabilityPage> {
  final String selectDaysPerMonth = "select days per month";

  final String selectPunishment = "select punishment";

  final String selectFriend = "select friend";

  final String endMessage =
      "your friend will get a weekly update of your progress on whatapp";

  final List<String> selectDaysPerMonthRecommendList = [
    "12 days this month",
    "15 days this month",
    "18 days this month",
    "21 days this month",
    "24 days this month",
    "27 days this month",
    "30 days this month"
  ];

  final List<String> selectPunishmentList = [
    "treat a friend",
    "do something i dislike, but friend likes",
    "pay money to friend",
    "go to temple with mom",
    "skip youtube for 3 days",
    "uninstall instagram for 1 day",
    "skip swiggy/zomato for a week"
  ];

  TextEditingController contactSearchController = TextEditingController();
  @override
  void initState() {
    Provider.of<AddHabitsProvider>(context, listen: false).getContacts();
    super.initState();
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

            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {},
        // ),
        backgroundColor: const Color(0xffF7F6F2),
        body: Consumer<AddHabitsProvider>(
          builder: (context, addHabit, child) {
            addHabit.getContacts();
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _buildPageProgressIndicator(),
                  SizedBox(
                    height: 7.0.h,
                  ),
                  _buildBackButtonAndTitle(),
                  SizedBox(
                    height: 40.0.h,
                  ),
                  _buildSubHeading(message: 'i’ll do this for'),
                  SizedBox(
                    height: 14.0.h,
                  ),
                  _buildParagraph(
                    message: addHabit.daysPerMonth,
                    onTap: () => buildBottomSheetRecommendationDaysperMonth(
                        context: context,
                        heading: "select days per month",
                        subHeading:
                            "start small, you can always increase it later",
                        recommended: selectDaysPerMonthRecommendList),
                  ),
                  SizedBox(
                    height: 22.0.h,
                  ),
                  _buildSubHeading(message: 'if i don’t, i will'),
                  SizedBox(
                    height: 14.0.h,
                  ),
                  _buildParagraph(
                    message: addHabit.punishment,
                    onTap: () => buildBottomSheetRecommendationPunishment(
                      context: context,
                      heading: "select punishment",
                      subHeading:
                          "not too hard, nor too easy. involve your friends or family, they make sure you do it",
                      recommended: selectPunishmentList,
                    ),
                  ),
                  SizedBox(
                    height: 22.0.h,
                  ),
                  _buildSubHeading(message: 'my friend will check this'),
                  SizedBox(
                    height: 14.0.h,
                  ),
                  _buildParagraph(
                    message: addHabit.friend,
                    onTap: () async {
                      buildBottomSheetRecommendationFriends(
                        context: context,
                        heading: "select friends",
                        // habitProvider: contactSearchController.text.isEmpty
                        //     ? addHabit.contacts
                        //     : addHabit.contactsFiltered,
                        habitProvider: addHabit,
                        editingController: contactSearchController,
                      );
                    },
                  ),
                  SizedBox(
                    height: 19.0.h,
                  ),
                  Text(
                    'your friend will get a weekly update of your',
                    style: TextStyle(
                        fontWeight: PlanAccountabilityScreenTextStyle
                            .subHeadingWeight500,
                        fontSize:
                            PlanAccountabilityScreenTextStyle.subHeadingSize),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'progress on whatsapp',
                        style: TextStyle(
                            fontWeight: PlanAccountabilityScreenTextStyle
                                .subHeadingWeight500,
                            fontSize: PlanAccountabilityScreenTextStyle
                                .subHeadingSize),
                      ),
                      SizedBox(
                          height: 24.0.r,
                          child: Image.asset('assets/images/whatsapp_icon.png'))
                    ],
                  ),
                  SizedBox(
                    height: 141.0.h,
                  ),
                  _buildButton(context),
                ],
              ),
            );
          },
        ));
  }

  Padding _buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 61.0.w),
      child: CustomTextButton(
        message: 'all done',
        fontSize: SecretScreenTextStyle.buttonTextSize,
        fontWeight: SecretScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.r,
        elevation: 0,
        onTap: () {
          navigatorPush(
              context,
              ViewHabitPage(
                habitName: widget.habitName,
              ));
          Provider.of<ProfileProvider>(context, listen: false)
              .getProfile(context);
        },
      ),
    );
  }

  Widget _buildParagraph(
      {required String message, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 336.0.w,
        height: 60.0.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0.r),
          color: Colors.white,
        ),
        child: Center(
          child: Text(
            message,
            style: TextStyle(
                fontSize: PlanRoutineScreenTextStyle.paragraphSize,
                fontWeight: PlanRoutineScreenTextStyle.paragraphWeight,
                color: const Color(0xff000000).withOpacity(0.5)),
          ),
        ),
      ),
    );
  }

  Align _buildSubHeading({
    required String message,
  }) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: EdgeInsets.only(left: 29.0.w),
        child: Text(
          message,
          style: TextStyle(
              fontSize: PlanRoutineScreenTextStyle.subHeadingSize,
              fontWeight: PlanRoutineScreenTextStyle.subHeadingWeight500,
              color: Colors.black),
        ),
      ),
    );
  }

  Padding _buildPageProgressIndicator() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0.h, left: 30.0.w, right: 30.0.w),
      child: const LinearPageProgressIndicator(
        percentageProgress: 0.85,
      ),
    );
  }

  Widget _buildBackButtonAndTitle() {
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
          'my goal & punishment',
          style: TextStyle(
              fontSize: PlanAccountabilityScreenTextStyle.headingSize,
              fontWeight: PlanAccountabilityScreenTextStyle.headingWeight,
              color: const Color(0xff062540)),
        ),
      ],
    );
  }
}
