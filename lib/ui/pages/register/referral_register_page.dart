import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/providers/referral_register_provider.dart';
import 'package:relife/ui/pages/email_verify/email_verify_page.dart';
import 'package:relife/ui/pages/login/login_page.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';
import 'local_widgets/custom_text_field.dart';

class ReferralRegisterPage extends StatefulWidget {
  const ReferralRegisterPage({Key? key}) : super(key: key);

  @override
  State<ReferralRegisterPage> createState() => _ReferralRegisterPageState();
}

class _ReferralRegisterPageState extends State<ReferralRegisterPage> {
  final message1 = 'sign up to get 14-day free trial today';

  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

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
              height: 39.0.h,
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
            SizedBox(
              height: 21.0.h,
            ),
            Container(
              margin: EdgeInsets.only(left: 12.w, right: 12.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(
                    height: 31.0.h,
                  ),
                  _buildForm(context),
                  SizedBox(
                    height: 13.0.h,
                  ),
                  _buildSignIn(),
                  SizedBox(
                    height: 14.h,
                  ),
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }

  Padding _buildSignIn() {
    return Padding(
      padding: EdgeInsets.only(left: 127.0.w, right: 110.0.w),
      child: Center(
        child: GestureDetector(
          onTap: () {
            navigatorPush(context, const LoginPage());
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
    final waitlistProvider =
        Provider.of<ReferralRegisterProvider>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildUserNameTextFiled(waitlistProvider),
          SizedBox(
            height: 22.0.h,
          ),
          _buildFirstNameTextFiled(waitlistProvider),
          SizedBox(
            height: 22.0.h,
          ),
          _buildLastNameTextFiled(waitlistProvider),
          SizedBox(
            height: 22.0.h,
          ),
          _buildNewPasswordTextFiled(waitlistProvider),
          SizedBox(
            height: 22.0.h,
          ),
          _buildConfirmPasswordTextFiled(waitlistProvider),
          SizedBox(
            height: 22.0.h,
          ),
          _buildSignUPButton(context)
        ],
      ),
    );
  }

  Padding _buildSignUPButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 69.w, right: 52.w),
      child: CustomTextButton(
        message: 'sign up',
        fontSize: LoginScreenTextStyle.buttonTextSize,
        fontWeight: LoginScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.sp,
        elevation: 0,
        onTap: () async {
          final waitlistProvider =
              Provider.of<ReferralRegisterProvider>(context, listen: false);
          // print(waitlistProvider.referralRegisterModel.firstName);
          // print(waitlistProvider.referralRegisterModel.lastName);
          if (await waitlistProvider.referralRegisterFun() == 200) {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => const EmailVerifyPage(),
                ),
                (route) => false);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Signup successful!'),
                backgroundColor: Color(0xffDF532B),
              ),
            );
          }
        },
      ),
    );
  }

  Padding _buildUserNameTextFiled(
      ReferralRegisterProvider waitlistRegisterProvider) {
    return Padding(
      padding: EdgeInsets.only(left: 32.0.w, right: 32.0.w),
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
              validator: (value) {
                if (value!.isEmpty) {
                  return "email is required";
                }
                if (!RegExp(
                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  return 'please enter a valid email';
                }
                return null;
              },
              readOnly: false,
              hintText: 'username@gmail.com',
              keyboard: TextInputType.emailAddress,
              isObscure: false,
              controller: usernameController,
              onSaved: (val) {
                waitlistRegisterProvider.referralRegisterModel.username = val!;
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildFirstNameTextFiled(
      ReferralRegisterProvider waitlistRegisterProvider) {
    return Padding(
      padding: EdgeInsets.only(left: 32.0.w, right: 32.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 22.w,
            child: Image.asset(
              AppAssets.user,
              height: 22.h,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: customTextField(
              readOnly: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter your firstName";
                }
                // else if (RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                //     .hasMatch(value)) {
                //   return ("Please Enter a valid email");
                // }
                else {
                  return null;
                }
              },
              hintText: 'enter first name',
              keyboard: TextInputType.emailAddress,
              isObscure: false,
              controller: firstNameController,
              onSaved: (val) {
                waitlistRegisterProvider.referralRegisterModel.firstName = val!;
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildLastNameTextFiled(
      ReferralRegisterProvider waitlistRegisterProvider) {
    return Padding(
      padding: EdgeInsets.only(left: 32.0.w, right: 32.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 22.w,
            child: Image.asset(
              AppAssets.user,
              height: 20.2.h,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: customTextField(
              readOnly: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter your last name";
                } else {
                  return null;
                }
              },
              hintText: 'enter last name',
              keyboard: TextInputType.emailAddress,
              isObscure: false,
              controller: lastNameController,
              onSaved: (val) {
                waitlistRegisterProvider.referralRegisterModel.lastName = val!;
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildNewPasswordTextFiled(
      ReferralRegisterProvider waitlistRegisterProvider) {
    return Padding(
      padding: EdgeInsets.only(left: 32.0.w, right: 32.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 22.w,
            child: Image.asset(
              AppAssets.appPasswordIcon,
              height: 20.2.h,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: customTextField(
              readOnly: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter your new password";
                } else {
                  return null;
                }
              },
              hintText: 'enter new password',
              keyboard: TextInputType.emailAddress,
              isObscure: true,
              controller: passwordController,
              onSaved: (val) {
                waitlistRegisterProvider.referralRegisterModel.password = val!;
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildConfirmPasswordTextFiled(
      ReferralRegisterProvider waitlistRegisterProvider) {
    return Padding(
      padding: EdgeInsets.only(left: 32.0.w, right: 32.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 22.w,
            child: Image.asset(
              AppAssets.appPasswordIcon,
              height: 20.2.h,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: customTextField(
              readOnly: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter your email id";
                } else if (passwordController.text != value) {
                  return "passwords do not match";
                } else {
                  return null;
                }
              },
              hintText: 'confirm new password',
              keyboard: TextInputType.emailAddress,
              isObscure: true,
              controller: confirmPasswordController,
              onSaved: (val) {
                waitlistRegisterProvider.referralRegisterModel.confirmPassword =
                    val!;
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
