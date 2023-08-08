import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_custom_tabs/flutter_custom_tabs.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/providers/login_provider.dart';
import 'package:relife/providers/payment_detail_provider.dart';
import 'package:relife/providers/payment_provider.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/ui/pages/payment/local_widget/benifits_container.dart';
import 'package:relife/ui/pages/payment/local_widget/review_container.dart';
import 'package:relife/ui/web_view/razor_pay.dart';
import 'package:relife/ui/widgets/back_button.dart';
import 'package:relife/ui/widgets/progress_loader.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'local_widget/plan_container.dart';
import 'local_widget/quote_container.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final message1 = 'get relife membership';

  final message2 =
      'join the exclusive community \nof motivated people \nto build healthy habits';

  final message4 =
      'we offer a referral program so that\nmoney doesn’t stop anyone from \nbuilding healthy habits.\nall plans come with the same exclusive\n membership and features. ';

  final message5 = 'why paid membership?';

  final message6 =
      'hundreds of members\nare building healthy\nhabits with relife';

  final message7 = 'made with ❤️ in india';
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final paymentProvider =
        Provider.of<PaymentDetailProvider>(context, listen: false);
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
      backgroundColor: const Color(0xff062540),
      body: SingleChildScrollView(
        padding: EdgeInsets.zero,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 5.0.h,
            ),
            Row(
              children: [
                RoundBackButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
            Container(
              width: 286.w,
              alignment: Alignment.topCenter,
              child: FittedBox(
                child: Text(
                  message1,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                    height: 36 / 24.sp,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 37.w),
              child: Align(
                alignment: Alignment.topLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'current plan: ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.6.sp,
                            height: 21 / 14.sp,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        TextSpan(
                          text: paymentProvider.planName,
                          style: TextStyle(
                            color: const Color(0xffDF532B),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.6.sp,
                            height: 21 / 14.sp,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'valid till : ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.6.sp,
                              fontFamily: 'Poppins',
                              height: 21 / 14.sp),
                        ),
                        TextSpan(
                          text: ' ${paymentProvider.validTill.split(' ')[0]}',
                          style: TextStyle(
                              color: const Color(0xffDF532B),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.06,
                              fontFamily: 'Poppins',
                              height: 21 / 14.sp),
                        ),
                      ]),
                    ),
                    SizedBox(
                      height: 6.h,
                    ),
                    RichText(
                      text: TextSpan(children: [
                        TextSpan(
                          text: 'total referrals: ',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'Poppins',
                              letterSpacing: 0.06,
                              height: 21 / 14.sp),
                        ),
                        TextSpan(
                          text: ' ${paymentProvider.totalReferral.toString()}',
                          style: TextStyle(
                              color: const Color(0xffDF532B),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.06,
                              fontFamily: 'Poppins',
                              height: 21 / 14.sp),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
            _buildPlan(context),
            Padding(
              padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 28.h),
              child: FittedBox(
                child: Text(
                  message4,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      height: 21 / 14.sp),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 36.w, right: 35.2, top: 117.h),
              child: FittedBox(
                child: Text(
                  message5,
                  maxLines: 1,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 47.h),
            _buildBenifits(),
            // Padding(
            //   padding: EdgeInsets.only(left: 36.w, right: 35.2, top: 132.h),
            //   child: Text(
            //     message6,
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //       color: Colors.white,
            //       fontSize: 24.sp,
            //       fontWeight: FontWeight.w600,
            //       height: 36 / 24.sp,
            //     ),
            //   ),
            // ),
            SizedBox(height: 48.h),
            // _buildReview(),
            SizedBox(height: 80.h),
            QuoteContainer(
              isPaymentPageLogin: true,
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 20.h,
                left: 12.w,
                right: 43.w,
              ),
              child: _buildFounder(),
            ),
            SizedBox(height: 70.h),
            SvgPicture.asset(
              AppAssets.relifeLogoWithTitle,
              height: 90.h,
            ),
            Padding(
              padding: EdgeInsets.only(top: 32.h, bottom: 35.h),
              child: Text(
                message7,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.06.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildPlan(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(left: 0.w, right: 0.w, top: 34.h),
        child: Column(
          children: [
            PlanContainer(
              heading1: 'starter',
              heading2: '1 referral',
              heading3: 'get 1 month membership, on us',
              heading4: 'get membership by sharing relife:',
              point1: 'your friend skips the waitlist and \ngets 14 days free',
              point2: 'get them to post first activity',
              point3: 'you get 1 month membership',
              buttonText: 'share relife',
              onPressed: () async {
                final prefs = await SharedPreferences.getInstance();
                Share.share(
                    'Hey! I just started building healthy habits on Relife. I\'m loving it and want you to join! Download the app here to skip the waitlist and get a 14 day free trial 😉: ${prefs.getString('referralLink')}');
              },
              color: const Color(0xffDF532B),
            ),
            SizedBox(height: 23.h),
            Consumer<PaymentProvider>(
                builder: (context, paymentProvider, child) {
              return PlanContainer(
                heading1: 'supporter',
                heading2: 'Rs 199',
                heading3: 'per month',
                heading4: 'get serious about your lifestyle',
                point1: 'feel the change',
                point2: 'start feeling happier',
                point3:
                    'people start noticing visible \nchanges, more compliments',
                // buttonText: paymentProvider.isLoading == true
                //     ? 'processing...'
                //     : 'become a member',
                buttonText: 'become a member',
                onPressed: () async {
                  CustomProgressIndicator().buildShowDialog(context);
                  await paymentProvider.makePaymentFun('oneMonth', context);

                  Navigator.pop(context);

                  String url = paymentProvider.paymentUrl;
                  bool isEmail = url.contains("@");
                  if (!isEmail) {
                    if (!Uri.parse(url).hasScheme) {
                      url = "http://" + url;
                    }
                  }
                  bool _validURL = Uri.parse(url).isAbsolute;
                  if (isEmail) {
                  } else if (_validURL) {
                    try {
                      await launch(
                        url,
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
                      print(e);
                      // rethrow;
                    }
                  }
                },
                color: const Color(0xffDF532B),
              );
            }),
            SizedBox(height: 23.h),
            Consumer<PaymentProvider>(
                builder: (context, paymentProvider, child) {
              return PlanContainer(
                stackText: 'recommended',
                heading1: 'believer',
                heading2: 'Rs 999',
                heading3: 'for six month',
                heading4: 'change your lifestyle',
                point1: 'you’ve acheived your lifestyle goals',
                point2: 'you feel happier and more satisfied',
                point3: 'healthy habits become your \nlifestyle',
                buttonText: 'become a member',
                onPressed: () async {
                  CustomProgressIndicator().buildShowDialog(context);
                  await paymentProvider.makePaymentFun('sixMonths', context);
                  //     .then((value) {
                  //   navigatorPush(context, const RazorPayWeb());
                  // });
                  Navigator.pop(context);
                  // launch(paymentProvider.paymentUrl,
                  //     forceWebView: true,
                  //     enableJavaScript: true,
                  //     statusBarBrightness: Brightness.light,
                  //     forceSafariVC: true);
                  String url = paymentProvider.paymentUrl;
                  bool isEmail = url.contains("@");
                  if (!isEmail) {
                    if (!Uri.parse(url).hasScheme) {
                      url = "http://" + url;
                    }
                  }
                  bool _validURL = Uri.parse(url).isAbsolute;
                  if (isEmail) {
                  } else if (_validURL) {
                    try {
                      await launch(
                        url,
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
                      print(e);
                      // rethrow;
                    }
                  }
                },
                color: const Color(0xffDF532B),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildBenifits() {
    return Column(
      children: [
        const BenifitsContainer(
          imgPath: AppAssets.teamGoals,
          heading: 'committed people only',
          body:
              'we are very serious about who \ngets in. it helps us maintain the \nquality of the community',
        ),
        SizedBox(
          height: 47.h,
        ),
        const BenifitsContainer(
          imgPath: AppAssets.mindMapp,
          heading: 'our brains are weird',
          body:
              'we don’t value things when\n we get them for free. and we get\nbetter results when we pay',
        ),
        SizedBox(
          height: 47.h,
        ),
        const BenifitsContainer(
          imgPath: AppAssets.boostImune,
          heading: 'importance of things',
          body:
              'how much do you spend on\nnetflix? swiggy? partying?\nand what’s more important?',
        ),
        SizedBox(
          height: 52.h,
        ),
        // const BenifitsContainer(
        //   imgPath: AppAssets.investingPana,
        //   heading: 'best things aren’t free',
        //   body:
        //       'the best things in life often aren’t\nfree. great products do cost a lot\nto build and maintain',
        // ),
        // SizedBox(
        //   height: 58.h,
        // ),
        const BenifitsContainer(
          imgPath: AppAssets.onlineAds,
          heading: 'ad free',
          body:
              'when something is free, you\nare the product. at relife,\nwe don’t sell your data. ever.',
        ),
      ],
    );
  }

  Widget _buildReview() {
    return Column(
      children: [
        const ReviewContainer(
            noOfStars: 5,
            acctualStar: 4.9,
            noOfReviews: 774,
            iconPath: AppAssets.appleStore,
            platform: 'Apple app store'),
        SizedBox(
          height: 24.h,
        ),
        const ReviewContainer(
          noOfStars: 5,
          acctualStar: 4.9,
          noOfReviews: 774,
          iconPath: AppAssets.playstore,
          platform: 'Google playstore',
        ),
      ],
    );
  }

  Widget _buildFounder() {
    return Row(
      children: [
        CircleAvatar(
          radius: 38.r,
          backgroundImage: const AssetImage(AppAssets.yash),
        ),
        SizedBox(
          width: 13.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'yash jakhete',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.06.sp,
                  ),
                ),
                Text(
                  ' (founder)',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.06.sp,
                  ),
                )
              ],
            ),
            GestureDetector(
              onTap: () async {
                await launch("https://wa.me/918504977433");
              },
              child: Text(
                'chat with me',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 0.06.sp,
                  fontFamily: 'Poppins',
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.solid,
                  decorationThickness: 1,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
