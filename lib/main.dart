import 'dart:io';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_mentions/flutter_mentions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:relife/providers/add_habits_provider.dart';
import 'package:relife/providers/connectivity_provider.dart';
import 'package:relife/providers/alarm_provider.dart';
import 'package:relife/providers/explore_tab_data_provider.dart';
import 'package:relife/providers/follow_provider.dart';
import 'package:relife/providers/forgot_password_provider.dart';
import 'package:relife/providers/get_particular_system_habit_provider.dart';
import 'package:relife/providers/get_user_all_habits_provider.dart';
import 'package:relife/providers/login_provider.dart';
import 'package:relife/providers/others_profile_provider.dart';
import 'package:relife/providers/page_provider/habit_tab_provider.dart';
import 'package:relife/providers/payment_detail_provider.dart';
import 'package:relife/providers/payment_provider.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/providers/referral_register_provider.dart';
import 'package:relife/providers/reset_password_provider.dart';
import 'package:relife/providers/system_habits_provider.dart';
import 'package:relife/providers/update_dp_provider.dart';
import 'package:relife/providers/post_create_provider.dart';
import 'package:relife/providers/post_provider.dart';
import 'package:relife/providers/update_profile_provider.dart';
import 'package:relife/providers/update_user_habit_provider.dart';
import 'package:relife/ui/pages/welcome/welcome_page.dart';
import 'providers/notification_provider.dart';
import 'providers/register_waitlist_provider.dart';
import 'package:flutter/services.dart';
import 'package:getsocial_flutter_sdk/getsocial_flutter_sdk.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel', // id
  'High Importance Notifications', // title
  description:
      'This channel is used for important notifications.', // description
  importance: Importance.high,
  playSound: true,
  enableVibration: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

// if there is any notification it will initialize the app
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  // print('A bg message just showed up :  ${message.messageId}');
}

Future<void> main() async {
  // await dotenv.load(fileName: Environment.fileName);

  // log("Environment.apiUrl : ${Environment.apiUrl}");
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  Completer<bool> getSocialInitializerCompleter = Completer();
  Notifications.setOnNotificationReceivedListener((p0) {
    // print(p0);
  });

  GetSocial.addOnInitializedListener(() {
    getSocialInitializerCompleter.complete(true);
  });
  await getSocialInitializerCompleter.future;

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ConnectivityProvider>(
        create: (_) => ConnectivityProvider(),
      ),
      ChangeNotifierProvider<LoginProvider>(
        create: (_) => LoginProvider(),
      ),
      ChangeNotifierProvider<ProfileProvider>(
        create: (_) => ProfileProvider(),
      ),
      ChangeNotifierProvider<UpdateProfileProvider>(
        create: (_) => UpdateProfileProvider(),
      ),
      ChangeNotifierProvider<UpdateDpProvider>(
        create: (_) => UpdateDpProvider(),
      ),
      ChangeNotifierProvider<FollowProvider>(
        create: (_) => FollowProvider()
          ..getFollowers()
          ..getFollowing(),
      ),
      ChangeNotifierProvider<SystemHabitsProvider>(
        create: (_) => SystemHabitsProvider(),
      ),
      ChangeNotifierProvider<AddHabitsProvider>(
        create: (_) => AddHabitsProvider(),
      ),
      ChangeNotifierProvider<UpdateHabitsProvider>(
        create: (_) => UpdateHabitsProvider(),
      ),
      ChangeNotifierProvider<GetUserAllHabitsProvider>(
        create: (_) => GetUserAllHabitsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => PostCreateProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => AllPostsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => DetailedPostProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => ExploreTabDataProvider(),
      ),
      ChangeNotifierProvider<ForgotPasswordProvider>(
        create: (_) => ForgotPasswordProvider(),
      ),
      ChangeNotifierProvider<ResetPasswordProvider>(
        create: (_) => ResetPasswordProvider(),
      ),
      ChangeNotifierProvider<WaitlistRegisterProvider>(
        create: (_) => WaitlistRegisterProvider(),
      ),
      ChangeNotifierProvider<ReferralRegisterProvider>(
        create: (_) => ReferralRegisterProvider(),
      ),
      ChangeNotifierProvider<ParticuarSystemHabitProvider>(
        create: (_) => ParticuarSystemHabitProvider(),
      ),
      ChangeNotifierProvider<PaymentProvider>(
        create: (_) => PaymentProvider(),
      ),
      ChangeNotifierProvider<PaymentDetailProvider>(
        create: (_) => PaymentDetailProvider(),
      ),
      ChangeNotifierProvider<OthersProfileProvider>(
        create: (_) => OthersProfileProvider(),
      ),
      ChangeNotifierProvider<NotificationProvider>(
        create: (_) => NotificationProvider(),
      ),
      ChangeNotifierProvider<AlarmProvider>(
        create: (_) => AlarmProvider(),
      ),
      ChangeNotifierProvider<HabitTabProvider>(
        create: (_) => HabitTabProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return ScreenUtilInit(
      builder: (context, child) {
        return Portal(
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Relife App',
            theme: ThemeData(
              // primarySwatch: Colors.blue,
              // textTheme: GoogleFonts.poppinsTextTheme(
              //   Theme.of(contex*
              // 3t).textTheme,
              // )
              timePickerTheme: TimePickerTheme.of(context).copyWith(
                dialHandColor: const Color(0xffDF532B),
                dayPeriodColor: const Color(0xffDF532B),
                dayPeriodTextColor: const Color(0xffFFFFFF),
                hourMinuteTextColor: const Color(0xffFFFFFF),
                hourMinuteColor: const Color(0xffDF532B),
              ),
              fontFamily: 'Poppins',
            ),
            home: const WelcomePage(),
            // home: Consumer<ConnectivityProvider>(
            //     builder: (context, connectivity, child) {
            //   connectivity.startMonitoring();
            //   if (connectivity.isOnline != null) {
            //     return connectivity.isOnline!
            //         ? const WelcomePage()
            //         : const NoInternetPage();
            //   }
            //   return const Scaffold(
            //     body: Center(
            //       child: CircularProgressIndicator(),
            //     ),
            //   );
            // }),
          ),
        );
      },
      designSize: const Size(360, 760),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
