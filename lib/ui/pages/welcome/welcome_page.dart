import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:relife/providers/get_user_all_habits_provider.dart';
import 'package:relife/providers/page_provider/habit_tab_provider.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/ui/pages/email_verify/email_verify_page.dart';
import 'package:relife/ui/pages/login/login_page.dart';
import 'package:relife/ui/pages/start/start_page.dart';
import 'package:relife/ui/pages/tabs/bottom_navigation_page.dart.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  String? token;
  String? id;
  Future<String?> getsharedToken() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('token');
  }

  Future<String?> getsharedTokenId() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    return sharedPreferences.getString('userId');
  }

  getToken() async {
    token = await getsharedToken();
    id = await getsharedTokenId();
  }

  @override
  void initState() {
    clearCache();
    WidgetsBinding.instance!.addPostFrameCallback(
      (timeStamp) async {
        token = await getsharedToken().whenComplete(() {});
        id = await getsharedTokenId();
        GetUserAllHabitsProvider? getUserHabitsProvider;
        if (token == null) {
          final SharedPreferences sharedPreferences =
              await SharedPreferences.getInstance();
          bool isAvailable =
              sharedPreferences.containsKey("is_slot_booking_skiped");
          // print("isAvailable ++++++++++++++++ = $isAvailable");
          if (!isAvailable) {
            navigatorPushReplacement(context, const LoginPage());
          } else {
            bool? is_slot_booking_skiped =
                sharedPreferences.getBool("is_slot_booking_skiped") ?? true;
            //  print(
            //    "is_slot_booking_skiped ++++++++++++++++ = $is_slot_booking_skiped");
            if (!is_slot_booking_skiped) {
              navigatorPushReplacement(context, const EmailVerifyPage());
            } else {
              navigatorPushReplacement(context, const LoginPage());
            }
          }
          // navigatorPushReplacement(context, const LoginPage());
        } else {
          Provider.of<ProfileProvider>(context, listen: false)
              .getProfile(context);
          getUserHabitsProvider =
              Provider.of<GetUserAllHabitsProvider>(context, listen: false);
          getUserHabitsProvider.getUserAllHabits(context).whenComplete(
            // fetching all habits of user
            () {
              getUserHabitsProvider!.getUserAllHabitsModel!.details.isNotEmpty
                  ? navigatorPushReplacement(
                      context,
                      const BottomNavigationPage(),
                    )
                  : Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (_) {
                          return const StartPage();
                        },
                      ),
                    );
            },
          );
          Provider.of<HabitTabProvider>(context, listen: false)
              .getHabitTabData(context: context, isLoadingRequired: true);
        }
      },
    );

    super.initState();
  }

  clearCache() async {
    PaintingBinding.instance!.imageCache!.clear();
    DefaultCacheManager manager = DefaultCacheManager();
    await manager.emptyCache();
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
          statusBarColor: Color(0xffFA8A3C),

          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
          statusBarBrightness: Brightness.light, // For iOS (dark icons)
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Column(
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
                // gradient: LinearGradient(
                //   begin: Alignment.topCenter,
                //   end: Alignment.bottomCenter,
                //   colors: [
                //     Color(0xffFF878B),
                //     Color(0xffF08A5D),
                //   ],
                // ),
                color: Color(0xffFA8A3C)),
            child: Center(
                child: Text("just 1% better, everyday",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.white))),
          ),
        ),
      ],
    );
  }
}
