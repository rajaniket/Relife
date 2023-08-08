import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/model/service%20model/forgot_password_model.dart';
import 'package:relife/providers/forgot_password_provider.dart';
import 'package:relife/ui/pages/login/local_widgets/custom_text_field.dart';
import 'package:relife/ui/pages/login/login_page.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';
import 'package:url_launcher/url_launcher.dart';

class ForgotPassWordPage extends StatelessWidget {
  ForgotPassWordPage({Key? key}) : super(key: key);

  final message1 = 'a private community for motivated people';

  final message2 =
      'we are working hard to onboard new members and taking it slow to make sure nothing breaks. if you’re already a member, then login below. if not, we can’t wait for you to join. scroll down to join the waitlist.';

  final message3 = '- your friends at relife';

  final _formKey = GlobalKey<FormState>();

  final TextEditingController resetPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            // Padding(
            //   padding: EdgeInsets.only(left: 21.0.w, right: 35.0.w),
            //   child: Text(message2,
            //       style: TextStyle(
            //           fontSize: LoginScreenTextStyle.paragraphSize,
            //           fontWeight: LoginScreenTextStyle.paragraphWeight,
            //           color: AppColors.defaultTextColor)),
            // ),
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
              height: 34.0.h,
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
                    _buildForm(context),
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
            SizedBox(
              height: 57.h,
            ),
            _buildBecomeMember(),
            const SizedBox(
              height: 22,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 50.w),
              child: Text(
                  "got an invite? click on your invite link to skip the waitlist",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: LoginScreenTextStyle.paragraphSize,
                    fontWeight: LoginScreenTextStyle.paragraphWeight,
                    color: AppColors.defaultTextColor,
                  )),
            ),
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
          onTap: () async {
            //navigatorPush(context, const BecomeMember());
            await launch('https://relife.co.in',
                forceWebView: true, enableJavaScript: true);
          },
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
            Navigator.maybePop(context);
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

  Form _buildForm(BuildContext context) {
    var passwordProvider =
        Provider.of<ForgotPasswordProvider>(context, listen: false);
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildUserNameTextFiled(
                passwordProvider.forgortPasswordRequestModel),
            SizedBox(
              height: 22.0.h,
            ),
            _buildResetPasswordButton(context)
          ],
        ));
  }

  Padding _buildResetPasswordButton(BuildContext context) {
    var passwordProvider =
        Provider.of<ForgotPasswordProvider>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(left: 57.w, right: 40.w),
      child: CustomTextButton(
        message: 'reset password',
        fontSize: LoginScreenTextStyle.buttonTextSize,
        fontWeight: LoginScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.0.sp,
        elevation: 0,
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            if (await passwordProvider.forgotPassword() == 200) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(passwordProvider.message),
                  backgroundColor: const Color(0xffDF532B),
                  //duration: const Duration(milliseconds: 350),
                ),
              );
              navigatorPush(context, const LoginPage());
            }
          }
        },
      ),
    );
  }

  Padding _buildUserNameTextFiled(
      ForgortPasswordRequestModel forgortPasswordRequestModel) {
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
              hintText: 'username@gmail.com',
              keyboard: TextInputType.emailAddress,
              isObscure: false,
              onSaved: (val) {
                forgortPasswordRequestModel.email = val!;
              },
              controller: resetPasswordController,
              validator: (val) {
                if (val!.isEmpty) {
                  return "please enter your email id";
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
