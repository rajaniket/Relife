import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/providers/profile_provider.dart';
import 'package:relife/providers/system_habits_provider.dart';
import 'package:relife/ui/pages/secret/secret_page.dart';
import 'package:relife/utils/page_transition_navigator/custom_navigator_push.dart';

import 'local_widgets/habit_component.dart';

class AddNewHabitPage extends StatefulWidget {
  const AddNewHabitPage({Key? key}) : super(key: key);

  @override
  State<AddNewHabitPage> createState() => _AddNewHabitPageState();
}

class _AddNewHabitPageState extends State<AddNewHabitPage> {
  final String message1 = 'which habit do you want to build next, ';

  final List<String> images = [
    AppAssets.reading,
    AppAssets.running,
    AppAssets.exercise,
  ];
  @override
  void initState() {
    Provider.of<SystemHabitsProvider>(context, listen: false)
        .getSystemHabitFun(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider =
        Provider.of<ProfileProvider>(context, listen: false);
    return Consumer<SystemHabitsProvider>(
        builder: (context, systemHabit, child) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 0,
          elevation: 0,
          automaticallyImplyLeading: false,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xffF7F6F2),

            statusBarIconBrightness:
                Brightness.dark, // For Android (dark icons)
            statusBarBrightness: Brightness.light, // For iOS (dark icons)
          ),
        ),
        backgroundColor: AppColors.addHabitScreenBackgroundColor,
        body: Column(
          children: [
            _customAppBar(context),
            SizedBox(
              height: 26.0.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 30.w, right: 12.0.w),
              child: Text(
                message1 + '${profileProvider.firstName} ?',
                style: TextStyle(
                    fontSize: AddHabitScreenTextStyle.subHeadingSize,
                    fontWeight: AddHabitScreenTextStyle.subHeadingWeight,
                    color: Colors
                        .black), //TextStyle(fontStyle: ,fontWeight: ,color: ),
              ),
            ),
            SizedBox(height: 25.0.h),
            systemHabit.getSystemHabitsModel != null
                ? Column(
                    children: List.generate(
                        systemHabit.getSystemHabitsModel!.details!.length,
                        (index) {
                      var details =
                          systemHabit.getSystemHabitsModel!.details![index];

                      return Padding(
                        padding: EdgeInsets.only(bottom: 12.h),
                        child: habitComponent(
                          habit: details.name,
                          numOfUsers: details.totalUsersInThisHabit,
                          image: images[index],
                          onTap: () {
                            final systemHabitsProvider =
                                Provider.of<SystemHabitsProvider>(context,
                                    listen: false);

                            systemHabitsProvider.getSystemHabits(
                                index, context);
                            navigatorPush(
                              context,
                              SecretPage(
                                habitName: details.name,
                              ),
                            );
                          },
                        ),
                      );
                    }),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      //backgroundColor: Color(0xffDF532B),
                      color: Color(0xffDF532B),
                    ),
                  )
          ],
        ),
      );
    });
  }

  Padding _customAppBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 23.5.w, top: 15.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              )),
          SizedBox(
            width: 20.51.w,
          ),
          Text('add new habit',
              style: TextStyle(
                  fontSize: AddHabitScreenTextStyle.headingSize,
                  fontWeight: AddHabitScreenTextStyle.headingWeight,
                  color: AppColors.startScreenBackgroundColor)),
        ], //style:TextStyle(fontSize: ,fontWeight: ,color: ),
      ),
    );
  }
}
