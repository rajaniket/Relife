import "package:flutter/material.dart";
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/providers/register_waitlist_provider.dart';
import 'package:relife/ui/pages/email_verify/email_verify_page.dart';
import 'package:relife/ui/pages/login/login_page.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';
import 'local_widgets/custom_text_field.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final message1 = 'sign up to get 14-day free trial today';

  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      final waitlistProvider =
          Provider.of<WaitlistRegisterProvider>(context, listen: false);
      await waitlistProvider.setWaitlistUser().then((value) {
        usernameController.text = waitlistProvider.userName;
        firstNameController.text = waitlistProvider.firstName;
        lastNameController.text = waitlistProvider.lastName;
        phoneNumberController.text = waitlistProvider.phoneNumber.toString();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
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
        Provider.of<WaitlistRegisterProvider>(context, listen: false);
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
          _buildPhoneNumberTextFiled(waitlistProvider),
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
        borderRadius: 30.0.sp,
        elevation: 0,
        onTap: () async {
          final waitlistProvider =
              Provider.of<WaitlistRegisterProvider>(context, listen: false);

          waitlistProvider.updateWaitlistRegisterModel();
          // print(waitlistProvider.waitlistRegisterModel.firstName);
          // print(waitlistProvider.waitlistRegisterModel.lastName);
          // print(waitlistProvider.waitlistRegisterModel.password);
          // print(waitlistProvider.waitlistRegisterModel.confirmPassword);

          // on success

          if (await waitlistProvider.registerUser() == 200) {
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

            waitlistProvider.setFirstName("");
            waitlistProvider.setLastName("");
            waitlistProvider.setPassword("");
            waitlistProvider.setConfirmPassword("");
            waitlistProvider.updateWaitlistRegisterModel();
          }
        },
      ),
    );
  }

  Padding _buildUserNameTextFiled(
      WaitlistRegisterProvider waitlistRegisterProvider) {
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
              readOnly: true,
              hintText: 'username@gmail.com',
              keyboard: TextInputType.emailAddress,
              isObscure: false,
              controller: usernameController,
              onSaved: (val) {},
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildFirstNameTextFiled(
      WaitlistRegisterProvider waitlistRegisterProvider) {
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
                  return "please enter your first name";
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
                if (val != null) {
                  waitlistRegisterProvider.setFirstName(val);
                } else {
                  waitlistRegisterProvider.setFirstName("");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildLastNameTextFiled(
      WaitlistRegisterProvider waitlistRegisterProvider) {
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
                  return "please enter your last name";
                }
                // else if (RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                //     .hasMatch(value)) {
                //   return ("Please Enter a valid email");
                // }
                else {
                  return null;
                }
              },
              hintText: 'enter last name',
              keyboard: TextInputType.emailAddress,
              isObscure: false,
              controller: lastNameController,
              onSaved: (val) {
                // waitlistRegisterProvider.waitlistRegisterModel.lastName = val!;
                if (val != null) {
                  waitlistRegisterProvider.setLastName(val);
                } else {
                  waitlistRegisterProvider.setLastName("");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildNewPasswordTextFiled(
      WaitlistRegisterProvider waitlistRegisterProvider) {
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
                  return "please enter your password";
                }
                // else if (RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                //     .hasMatch(value)) {
                //   return ("Please Enter a valid email");
                // }
                else {
                  return null;
                }
              },
              hintText: 'enter new password',
              keyboard: TextInputType.emailAddress,
              isObscure: true,
              controller: passwordController,
              onSaved: (val) {
                // waitlistRegisterProvider.waitlistRegisterModel.password = val!;
                if (val != null) {
                  waitlistRegisterProvider.setPassword(val);
                } else {
                  waitlistRegisterProvider.setPassword("");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildConfirmPasswordTextFiled(
      WaitlistRegisterProvider waitlistRegisterProvider) {
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
                  return "please enter yourpassword";
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
                // waitlistRegisterProvider.waitlistRegisterModel.confirmPassword =
                //     val!;
                if (val != null) {
                  waitlistRegisterProvider.setConfirmPassword(val);
                } else {
                  waitlistRegisterProvider.setConfirmPassword("");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Padding _buildPhoneNumberTextFiled(
      WaitlistRegisterProvider waitlistRegisterProvider) {
    return Padding(
      padding: EdgeInsets.only(left: 32.0.w, right: 32.0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 22.w,
            child: SvgPicture.asset(
              AppAssets.phone,
              height: 23.h,
            ),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: customTextField(
              readOnly: false,
              validator: (value) {
                if (value!.isEmpty) {
                  return "please enter your phone number";
                }
                // else if (RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                //     .hasMatch(value)) {
                //   return ("Please Enter a valid email");
                // }
                else {
                  return null;
                }
              },
              hintText: 'enter phone number',
              keyboard: TextInputType.emailAddress,
              isObscure: false,
              controller: phoneNumberController,
              onSaved: (val) {
                if (val != null) {
                  waitlistRegisterProvider.setPhoneNumber(val);
                } else {
                  waitlistRegisterProvider.setPhoneNumber("");
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  // Padding _buildReferralTextFiled() {
  //   return Padding(
  //     padding: EdgeInsets.only(left: 32.0.w, right: 32.0.w),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       children: [
  //         SizedBox(
  //           width: 22.w,
  //           child: Image.asset(
  //             AppAssets.gift,
  //             height: 20.2.h,
  //           ),
  //         ),
  //         SizedBox(width: 8.w),
  //         Expanded(
  //           child: customTextField(
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return "please enter your email id";
  //               }
  //               // else if (RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
  //               //     .hasMatch(value)) {
  //               //   return ("Please Enter a valid email");
  //               // }
  //               else {
  //                 return null;
  //               }
  //             },
  //             hintText: 'enter referral code',
  //             keyboard: TextInputType.emailAddress,
  //             isObscure: false,
  //             controller: emailController,
  //             onSaved: (val) {},
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

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
