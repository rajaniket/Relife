import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/ui/pages/add_new_habit/add_habit.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  final String message1 =
      "relife helps you\nimprove daily by building\ngood habits";
  final String message2 =
      "if you get 1% better everyday\nfor 1 year, you’ll end up\n37 times better";

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
      backgroundColor: AppColors.startScreenBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildHeading(),
            SizedBox(
              height: 46.0.h,
            ),
            _buildGraphImage(),
            SizedBox(
              height: 64.0.h,
            ),
            _buildParagraph(),
            SizedBox(
              height: 53.0.h,
            ),
            _buildButton(context),
            SizedBox(
              height: 40.0.h,
            ),
          ],
        ),
      ),
    );
  }

  CustomTextButton _buildButton(BuildContext context) {
    return CustomTextButton(
      message: 'i\'m ready',
      fontSize: StartScreenTextStyle.buttonTextSize,
      fontWeight: StartScreenTextStyle.buttonTextWeight,
      buttonColor: AppColors.buttonColor,
      buttonSize: Size(239.0.w, 47.0.h),
      borderRadius: 30.r,
      elevation: 0,
      onTap: () {
        navigatorPush(context, const AddNewHabitPage());
      },
    );
  }

  Center _buildParagraph() {
    return Center(
      child: Text(
        message2,
        style: TextStyle(
          fontSize: StartScreenTextStyle.paragraphSize,
          fontWeight: StartScreenTextStyle.paragraphWeight,
          color: AppColors.startScreenTextColor,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Container _buildGraphImage() {
    return Container(
      padding: const EdgeInsets.all(20),
      width: 336.0.w,
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(25.0.r)),
      child: Image.asset(AppAssets.startPageGraph),
    );
  }

  Padding _buildHeading() {
    return Padding(
      padding: EdgeInsets.only(top: 70.0.h),
      child: Center(
        child: Text(
          message1,
          style: TextStyle(
            fontSize: StartScreenTextStyle.headingSize,
            fontWeight: StartScreenTextStyle.headingWeight,
            color: AppColors.startScreenTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
