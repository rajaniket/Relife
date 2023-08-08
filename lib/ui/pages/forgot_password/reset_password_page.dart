import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/model/service%20model/reset_password_model.dart';
import 'package:relife/providers/reset_password_provider.dart';
import 'package:relife/ui/pages/login/local_widgets/custom_text_field.dart';
import 'package:relife/ui/pages/login/login_page.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';

class ResetPasswordPage extends StatelessWidget {
  ResetPasswordPage({Key? key}) : super(key: key);

  final message1 = 'you can update your password now';

  final message2 =
      'we are working hard to onboard new members and taking it slow to make sure nothing breaks. if you’re already a member, then login below. if not, we can’t wait for you to join. scroll down to join the waitlist.';

  final message3 = '- your friends at relife';

  final _formKey = GlobalKey<FormState>();

  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    var token = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F2),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 30.0.h,
            ),
            _buildAppLogo(),
            SizedBox(
              height: 120.h,
            ),
            // Heading
            Padding(
              padding: EdgeInsets.only(left: 21.0.w),
              child: FittedBox(
                child: Text(message1,
                    style: TextStyle(
                        fontSize: LoginScreenTextStyle.headingSize,
                        fontWeight: LoginScreenTextStyle.headingWeight,
                        color: AppColors.defaultTextColor)),
              ),
            ),
            // SizedBox(
            //   height: 13.0.h,
            // ),
            // // Padding(
            // //   padding: EdgeInsets.only(left: 21.0.w, right: 35.0.w),
            // //   child: Text(message2,
            // //       style: TextStyle(
            // //           fontSize: LoginScreenTextStyle.paragraphSize,
            // //           fontWeight: LoginScreenTextStyle.paragraphWeight,
            // //           color: AppColors.defaultTextColor)),
            // // ),
            // SizedBox(
            //   height: 15.0.h,
            // ),
            // Padding(
            //   padding: EdgeInsets.only(left: 21.0.w, right: 35.0.w),
            //   child: Text(message3,
            //       style: TextStyle(
            //           fontSize: LoginScreenTextStyle.paragraphSize,
            //           fontWeight: LoginScreenTextStyle.paragraphWeight,
            //           color: AppColors.defaultTextColor)),
            // ),
            SizedBox(
              height: 30.0.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0.w),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    _buildForm(context, token),
                    SizedBox(
                      height: 22.0.h,
                    ),
                    _buildSignInTextButton(context),
                    SizedBox(
                      height: 14.h,
                    )
                  ],
                ),
              ),
            ),
            // SizedBox(
            //   height: 57.h,
            // ),
            // _buildBecomeMember(),
          ],
        )),
      ),
    );
  }

  Row _buildBecomeMember() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'not a member yet? ',
          style: TextStyle(
            fontSize: LoginScreenTextStyle.paragraphSize,
            fontWeight: LoginScreenTextStyle.paragraphWeight,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            'become a member now',
            style: TextStyle(
                fontSize: LoginScreenTextStyle.paragraphSize,
                fontWeight: LoginScreenTextStyle.paragraphWeight,
                decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  Padding _buildSignInTextButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 120.0.w, right: 110.0.w),
      child: Center(
        child: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LoginPage()));
          },
          child: Text(
            'sign in',
            style: TextStyle(
                fontSize: LoginScreenTextStyle.paragraphSize,
                fontWeight: LoginScreenTextStyle.paragraphWeight,
                decoration: TextDecoration.underline),
          ),
        ),
      ),
    );
  }

  Form _buildForm(BuildContext context, String token) {
    var resetpasswordProvider =
        Provider.of<ResetPasswordProvider>(context, listen: false);
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildNewPasswordTextFiled(
                resetpasswordProvider.resetPasswordRequestModel),
            SizedBox(
              height: 22.0.h,
            ),
            _buildConfirmPasswordTextFiled(
                resetpasswordProvider.resetPasswordRequestModel),
            SizedBox(
              height: 22.0.h,
            ),
            _buildUpdatePasswordButton(context, token)
          ],
        ));
  }

  Padding _buildUpdatePasswordButton(BuildContext context, String token) {
    var resetpasswordProvider =
        Provider.of<ResetPasswordProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(left: 57.w, right: 40.w),
      child: CustomTextButton(
        message: 'update password',
        fontSize: LoginScreenTextStyle.buttonTextSize,
        fontWeight: LoginScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.0.sp,
        elevation: 0,
        onTap: () {
          if (_formKey.currentState!.validate()) {
            resetpasswordProvider.resetPassword(token);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                    'your password has been updated. sign in with your new password'),
                backgroundColor: Color(0xffDF532B),
              ),
            );
            navigatorPush(
              context,
              const LoginPage(),
            );
          }
        },
      ),
    );
  }

  Padding _buildNewPasswordTextFiled(ResetPasswordRequestModel requestModel) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 22.w,
            child: Image.asset(
              AppAssets.appMessageIcon,
              height: 18.2.h,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: customTextField(
              hintText: 'enter new password',
              keyboard: TextInputType.emailAddress,
              isObscure: true,
              onSaved: (val) {
                requestModel.newPassword = val!;
              },
              controller: newPasswordController,
              validator: (val) {
                if (val!.isEmpty) {
                  return "please enter a valid password";
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildConfirmPasswordTextFiled(
      ResetPasswordRequestModel requestModel) {
    return Padding(
      padding: EdgeInsets.only(left: 20.0.w, right: 20.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 22.w,
            child: Image.asset(
              AppAssets.appPasswordIcon,
              height: 22.2.h,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: customTextField(
              hintText: 'confirm new password',
              keyboard: TextInputType.emailAddress,
              isObscure: true,
              onSaved: (val) {
                requestModel.confirmPassword = val!;
              },
              controller: confirmPasswordController,
              validator: (val) {
                if (val!.isEmpty) {
                  return "please enter a valid password";
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildAppLogo() {
    return Padding(
      padding: EdgeInsets.only(left: 21.0.w),
      child: SizedBox(
          height: 93.0.h,
          width: 150.0.w,
          child: SvgPicture.asset(
            AppAssets.applogo,
            fit: BoxFit.contain,
          )),
    );
  }
}
