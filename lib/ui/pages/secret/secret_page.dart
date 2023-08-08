import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/ui/pages/habit_stacking/habit_stacking.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/ui/widgets/linear_page_progress_indicator.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';

class SecretPage extends StatelessWidget {
  final String habitName;
  const SecretPage({Key? key, required this.habitName}) : super(key: key);
  final message1 = "the secret to\nbuilding a habit is in\nyour daily routine";
  final message2 = "use reminder habits and\nrewards to build a habit";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xff062540),

          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      backgroundColor: AppColors.secretScreenBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildPageProgressIndicator(),
            SizedBox(
              height: 7.0.h,
            ),
            _buildBackButton(context),
            SizedBox(
              height: 7.0.h,
            ),
            _buildHeadingText(),
            SizedBox(
              height: 46.0.h,
            ),
            _buildMindMapImage(),
            SizedBox(
              height: 49.0.h,
            ),
            _buildParagraphText(),
            SizedBox(
              height: 49.0.h,
            ),
            _buildButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildBackButton(BuildContext context) => Align(
        alignment: Alignment.centerLeft,
        child: RoundBackButton(
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      );

  Padding _buildButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 53.0.w),
      child: CustomTextButton(
        message: 'tell me more',
        fontSize: SecretScreenTextStyle.buttonTextSize,
        fontWeight: SecretScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.r,
        elevation: 0,
        onTap: () {
          navigatorPush(
              context,
              HabitStackingPage(
                habitName: habitName,
              ));
        },
      ),
    );
  }

  Container _buildMindMapImage() {
    return Container(
      width: 280.0.r,
      height: 280.0.r,
      decoration:
          const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
      child: SvgPicture.asset(AppAssets.mindMap, fit: BoxFit.contain),
    );
  }

  Text _buildHeadingText() {
    return Text(
      message1,
      style: TextStyle(
          fontSize: SecretScreenTextStyle.headingSize,
          fontWeight: SecretScreenTextStyle.headingWeight,
          color: Colors.white),
      textAlign: TextAlign.center,
    );
  }

  Padding _buildPageProgressIndicator() {
    return Padding(
      padding: EdgeInsets.only(top: 15.0.h, left: 30.0.w, right: 30.0.w),
      child: const LinearPageProgressIndicator(
        percentageProgress: 0.20,
      ),
    );
  }

  Widget _buildParagraphText() {
    return Text(
      message2,
      style: TextStyle(
          fontSize: SecretScreenTextStyle.paragraphSize,
          fontWeight: SecretScreenTextStyle.paragraphWeight,
          color: Colors.white),
      textAlign: TextAlign.center,
    );
  }
}
