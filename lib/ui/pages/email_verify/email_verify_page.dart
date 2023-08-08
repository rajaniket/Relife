import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/colors.dart';
import '../../../constants/text_data.dart';
import '../../widgets/custom_text_button.dart';
import '../login/login_page.dart';

class EmailVerifyPage extends StatefulWidget {
  const EmailVerifyPage({Key? key}) : super(key: key);

  @override
  State<EmailVerifyPage> createState() => _EmailVerifyPageState();
}

class _EmailVerifyPageState extends State<EmailVerifyPage> {
  CarouselController carouselController = CarouselController();
  int _currentCarousel = 0;
  List<List<String>> carouselImage = [
    [
      "assets/svg/email_verify_1.svg",
      "at relife, we want our members to truly achieve their lifestyle goals 🙏🏻",
    ],
    [
      "assets/svg/email_verify_2.svg",
      "and for that, we need to understand what challenges you face",
    ],
    [
      "assets/svg/email_verify_3.svg",
      "then we'll plan together to make sure you actually start building healthy habits and stick to them 💪🏻",
    ],
    [
      "assets/svg/email_verify_4.svg",
      "you get to do this over a 1:1 call with our experts 🎯",
    ],
  ];
  @override
  void initState() {
    setSkipFlagOnSharedPrefrences(false);
    super.initState();
  }

  Future<void> setSkipFlagOnSharedPrefrences(bool val) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    await sharedPreferences.setBool("is_slot_booking_skiped", val);
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7F6F2),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xffF7F6F2),
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        await setSkipFlagOnSharedPrefrences(true);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                            (route) => false);
                      },
                      child: Padding(
                        padding:
                            EdgeInsets.only(right: 15, top: 8.h, bottom: 10.h),
                        child: Text(
                          _currentCarousel == 3 ? 'skip' : "",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Text(
                  'let’s get you started',
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff062540)),
                ),
              ),
              SizedBox(
                height: 40.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: Center(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      initialPage: 0,
                      enableInfiniteScroll: false,
                      height: 420.h,
                      aspectRatio: 1,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentCarousel = index;
                        });
                      },
                    ),
                    items: carouselImage.map((svgItem) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: SvgPicture.asset(
                                    svgItem[0],
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 30,
                                  ),
                                  child: Text(
                                    svgItem[1],
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: SizedBox(
                  height: 30.h,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: carouselImage.asMap().entries.map((entry) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin:
                            const EdgeInsets.only(top: 0.0, left: 5, right: 5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          // color: Colors.white.withOpacity(_currentCarousel == entry.key ? 1 : 0.4),
                          //borderRadius: BorderRadius.circular(11),
                          color: _currentCarousel == entry.key
                              ? const Color(0xffDF532B)
                              : const Color(0xffF4CBB6),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 65.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 61.0, vertical: 10.h),
                child: CustomTextButton(
                  message: 'book a slot now!',
                  fontSize: SuccessScreenTextStyle.buttonTextSize,
                  fontWeight: SuccessScreenTextStyle.buttonTextWeight,
                  buttonColor: AppColors.buttonColor,
                  buttonSize: const Size(double.infinity, 55.0),
                  borderRadius: 30,
                  elevation: 0,
                  onTap: () async {
                    try {
                      await launch(
                        "https://calendly.com/relifeapp/onboarding",
                        customTabsOption: const CustomTabsOption(
                          toolbarColor: Color(0xffF7F6F2),
                          enableDefaultShare: true,
                          enableUrlBarHiding: true,
                          showPageTitle: true,
                          extraCustomTabs: <String>[
                            // ref. https://play.google.com/store/apps/details?id=org.mozilla.firefox
                            'org.mozilla.firefox',
                            // ref. https://play.google.com/store/apps/details?id=com.microsoft.emmx
                            'com.microsoft.emmx',
                          ],
                        ),
                      );
                    } catch (e) {
                      rethrow;
                    }
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (_) => const BottomNavigationPage(),
                    //     ),
                    //     (route) => false);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
