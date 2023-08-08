import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/model/service%20model/login_model.dart';
import 'package:relife/providers/connectivity_provider.dart';
import 'package:relife/providers/get_user_all_habits_provider.dart';
import 'package:relife/providers/login_provider.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/providers/referral_register_provider.dart';
import 'package:relife/providers/register_waitlist_provider.dart';
import 'package:relife/ui/pages/forgot_password/reset_password_page.dart';
import 'package:relife/ui/pages/forgot_password/forgot_password_page.dart';
import 'package:relife/ui/pages/register/referral_register_page.dart';
import 'package:relife/ui/pages/register/register_page.dart';
import 'package:relife/ui/pages/start/start_page.dart';
import 'package:relife/ui/pages/tabs/bottom_navigation_page.dart.dart';
import 'package:relife/ui/widgets/custom_text_button.dart';
import 'package:relife/ui/widgets/progress_loader.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../providers/page_provider/habit_tab_provider.dart';
import 'local_widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final message1 = 'a private community for motivated people';

  final message2 =
      'we are working hard to onboard new members and taking it slow to make sure nothing breaks. if you’re already a member, then login below. if not, we can’t wait for you to join. scroll down to join the waitlist.';

  final message3 = '- your friends at relife';

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  void initDynamicLinks(BuildContext context) {
    final dynamicLinks = FirebaseDynamicLinks.instance;
    final waitlist =
        Provider.of<WaitlistRegisterProvider>(context, listen: false);
    final refferal =
        Provider.of<ReferralRegisterProvider>(context, listen: false);

    dynamicLinks.onLink.listen((dynamicLinkData) {
      var query = dynamicLinkData.link.query.split('=').first;
      if (dynamicLinkData.link.pathSegments.contains('passwordReset')) {
        ///  print('token : ' + dynamicLinkData.link.queryParameters['token']!);
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => ResetPasswordPage(),
                settings: RouteSettings(
                    arguments: dynamicLinkData.link.queryParameters['token']!)),
            (route) => false);
      } else if (query == 'referral_id') {
        var referralId = dynamicLinkData.link.queryParameters['referral_id'];

        if (referralId != null) {
          refferal.setReferralId(referralId);
        }

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const ReferralRegisterPage(),
            ),
            (route) => false);
      } else if (query == 'waitlist_id') {
        //  print(dynamicLinkData.link.queryParameters['waitlist_id']);
        var waitlistId = dynamicLinkData.link.queryParameters['waitlist_id'];
        if (waitlistId != null) {
          waitlist.setWaitlistId(waitlistId);
        }
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const RegisterPage(),
            ),
            (route) => false);
      } else {
        // print(dynamicLinkData.link);
      }
    }).onError((error) {
      // print('onLink error');
    });
  }

  void pendingDynamicLinks(BuildContext context) async {
    final dynamicLinks = FirebaseDynamicLinks.instance;
    final waitlist =
        Provider.of<WaitlistRegisterProvider>(context, listen: false);
    final refferal =
        Provider.of<ReferralRegisterProvider>(context, listen: false);

    final PendingDynamicLinkData? data = await dynamicLinks.getInitialLink();

    if (data != null) {
      final Uri? deepLink = data.link;
      if (deepLink != null) {
        var query = deepLink.query.split('=').first;
        if (deepLink.pathSegments.contains('passwordReset')) {
          //print('token : ' + deepLink.queryParameters['token']!);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) => ResetPasswordPage(),
                  settings: RouteSettings(
                      arguments: deepLink.queryParameters['token']!)),
              (route) => false);
        } else if (query == 'referral_id') {
          var referralId = deepLink.queryParameters['referral_id'];

          if (referralId != null) {
            refferal.setReferralId(referralId);
          }

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const ReferralRegisterPage(),
              ),
              (route) => false);
        } else if (query == 'waitlist_id') {
          // print(deepLink.queryParameters['waitlist_id']);
          var waitlistId = deepLink.queryParameters['waitlist_id'];
          if (waitlistId != null) {
            waitlist.setWaitlistId(waitlistId);
          }
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => const RegisterPage(),
              ),
              (route) => false);
        } else {
          // print(deepLink);
        }
      }
    }
  }

  @override
  void initState() {
    initDynamicLinks(context);
    pendingDynamicLinks(context);
    notifaction();
    super.initState();
  }

  void notifaction() async {
    // var notifaction = await Notifications.registerDevice().then((value) {});
  }

  // buildShowDialog(BuildContext context) {
  //   return showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (BuildContext context) {
  //         return Center(
  //           child: Container(
  //             height: 70,
  //             width: 70,
  //             decoration: BoxDecoration(
  //                 //borderRadius: BorderRadius.circular(5.r),
  //                 color: Colors.white.withOpacity(0.8),
  //                 shape: BoxShape.circle),
  //             child: Center(
  //               child: Lottie.asset('assets/lottie/loading.json'),
  //             ),
  //           ),
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(
        builder: (context, connectivity, child) {
      // if (connectivity.isOnline != null) {
      // return connectivity.isOnline!?
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          automaticallyImplyLeading: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xffF7F6F2),

            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
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
                height: 120.0.h,
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
              Container(
                margin: EdgeInsets.only(left: 12.w, right: 12.w),
                //width: 336.w,
                //height: 272.h,
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
                      height: 22.0.h,
                    ),
                    _buildForgotPassword(),
                    SizedBox(
                      height: 14.h,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36.h,
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
      //         : const NoInternetPage();
      //   }
      //   return const Center(
      //     child: CircularProgressIndicator(),
      //   );
    });
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

  _buildForgotPassword() {
    return Padding(
      padding: EdgeInsets.only(left: 15.w),
      child: Center(
        child: GestureDetector(
          onTap: () {
            navigatorPush(context, ForgotPassWordPage());
          },
          child: Text(
            'forgot Password',
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
    var loginprovider = Provider.of<LoginProvider>(context, listen: false);
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildUserNameTextFiled(loginprovider.requestModel),
          SizedBox(
            height: 22.0.h,
          ),
          _buildPasswordTextField(loginprovider.requestModel),
          SizedBox(
            height: 22.0.h,
          ),
          _buildSignInButton(context)
        ],
      ),
    );
  }

  Padding _buildSignInButton(BuildContext context) {
    var loginprovider = Provider.of<LoginProvider>(context, listen: true);

    return Padding(
      padding: EdgeInsets.only(left: 69.w, right: 52.w),
      child: CustomTextButton(
        message: loginprovider.isLoading == false ? 'sign in' : 'Loading...',
        fontSize: LoginScreenTextStyle.buttonTextSize,
        fontWeight: LoginScreenTextStyle.buttonTextWeight,
        buttonColor: AppColors.buttonColor,
        buttonSize: Size(double.infinity, 47.0.h),
        borderRadius: 30.0.sp,
        elevation: 0,
        onTap: () async {
          if (_formKey.currentState!.validate()) {
            CustomProgressIndicator().buildShowDialog(context);

            await loginprovider.login(context);

            if (loginprovider.isLoginSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('login Successful'),
                  backgroundColor: Color(0xffDF532B),
                  duration: Duration(milliseconds: 1000),
                ),
              );
              final getUserHabitsProvider =
                  Provider.of<GetUserAllHabitsProvider>(context, listen: false);
              final profileProvider =
                  Provider.of<ProfileProvider>(context, listen: false);

              await getUserHabitsProvider.getUserAllHabits(context);

              Navigator.pop(context); // removing dialog

              if (getUserHabitsProvider.listOfHabitDetails.length >= 1) {
                Provider.of<HabitTabProvider>(context, listen: false)
                    .getHabitTabData(context: context, isLoadingRequired: true);
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (_) => const BottomNavigationPage()));
              } else {
                await profileProvider.getProfile(context).then((value) {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const StartPage()));
                });
              }
            } else {
              Navigator.pop(context); // removing dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(loginprovider.message),
                  backgroundColor: const Color(0xffDF532B),
                  duration: const Duration(milliseconds: 2000),
                  action: SnackBarAction(
                    onPressed: () {
                      ScaffoldMessenger.of(context).clearSnackBars();
                    },
                    label: 'retry',
                    textColor: Colors.white,
                  ),
                ),
              );

              // Fluttertoast.showToast(
              //   msg: loginprovider.message,
              //   toastLength: Toast.LENGTH_SHORT,
              //   gravity: ToastGravity.CENTER,
              //   timeInSecForIosWeb: 1,
              //   backgroundColor: Colors.red,
              //   textColor: Colors.white,
              //   fontSize: 16.0,
              // );
            }
          }
        },
      ),
    );
  }

  Padding _buildPasswordTextField(LoginRequestModel requestModel) {
    return Padding(
      padding: EdgeInsets.only(left: 32.0.w, right: 32.0.w),
      child: Row(
        children: [
          SizedBox(
              // wraping asset image with sized box so that it takes fixed size as we want it to match it's alignmet with the username field
              width: 22.w,
              child: Image.asset(
                AppAssets.appPasswordIcon,
                height: 24.0.h,
              )),
          SizedBox(width: 8.w),
          Expanded(
            child: customTextField(
                validator: (val) {
                  if (val!.isEmpty) {
                    return "please enter your password";
                  }
                },
                hintText: 'Password',
                keyboard: TextInputType.name,
                isObscure: true,
                controller: passwordController,
                onSaved: (val) {
                  //print(val!);
                  requestModel.password = val!;
                }),
          ),
        ],
      ),
    );
  }

  Padding _buildUserNameTextFiled(LoginRequestModel requestModel) {
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
              hintText: 'username@gmail.com',
              keyboard: TextInputType.emailAddress,
              isObscure: false,
              controller: emailController,
              onSaved: (val) {
                //print(val!);
                requestModel.email = val!.toLowerCase();
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
