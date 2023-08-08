import 'dart:developer';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/colors.dart';
import 'package:relife/constants/text_data.dart';
import 'package:relife/providers/add_habits_provider.dart';
import 'package:relife/providers/update_user_habit_provider.dart';

Future<dynamic> buildBottomSheetRecommendation({
  required BuildContext context,
  required String heading,
  required String subHeading,
  required List<String> recommended,
}) {
  return showModalBottomSheet(
    isScrollControlled:
        true, // it'll allow the bottom sheet to take the required height which gives more insurance that TextField is not covered by the keyboard.
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0.r),
      ),
    ),
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom), // for lifiting the widget upward when textfield is in use
        child: Padding(
          padding: EdgeInsets.only(
              top: 18.0.h, left: 12.0.w, right: 12.0.w, bottom: 5.0.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeading(heading),
              SizedBox(
                height: 9.5.h,
              ),
              _buildSubHeading(subHeading),
              SizedBox(
                height: 9.5.h,
              ),
              _buildTextField(context),
              SizedBox(
                height: 10.26.h,
              ),
              _buildRecommendedText(),
              SizedBox(
                height: 10.26.h,
              ),
              _buildReommendedWidgets(
                  recommended, context), // rendering all recommended widgets
            ],
          ),
        ),
      ),
    ),
  );
}

Align _buildRecommendedText() {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 9.0.w),
      child: Text(
        'recommended',
        style: TextStyle(
            fontSize: BottomSheetTextStyle.paragraphSize,
            fontWeight: BottomSheetTextStyle.paragraphWeight),
      ),
    ),
  );
}

TextField _buildTextField(BuildContext context) {
  return TextField(
    //maxLength: 50,
    onSubmitted: (val) {
      final addHabits = Provider.of<AddHabitsProvider>(context, listen: false);
      addHabits.setReminderHabit(val);
      final updateHabit =
          Provider.of<UpdateHabitsProvider>(context, listen: false);
      updateHabit.setReminderHabit(val);
      // print("HAbits" + addHabits.createHabitRequestModel.reminderHabit);
      Navigator.pop(context);
    },
    decoration: InputDecoration(
      hintText: 'add your own',
      hintStyle: TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w300,
      ),
      contentPadding: EdgeInsets.only(
          left: 24.0.w, right: 24.0.w, top: 12.35.h, bottom: 14.69),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0.r),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.bottomSheetTextFieldColor,
    ),
  );
}

Padding _buildSubHeading(String subHeading) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 12.0.w),
    child: Text(
      subHeading,
      style: TextStyle(
          fontSize: BottomSheetTextStyle.paragraphSize,
          fontWeight: BottomSheetTextStyle.paragraphWeight),
    ),
  );
}

Text _buildHeading(String heading) {
  return Text(
    heading,
    style: TextStyle(
        fontSize: BottomSheetTextStyle.headingSize,
        fontWeight: BottomSheetTextStyle.headingWeight),
  );
}

Widget _buildReommendedWidgets(
    List<dynamic> recommended, BuildContext context) {
  List<Widget> list = [];
  for (int i = 0; i < recommended.length; i++) {
    list.add(Padding(
      padding: EdgeInsets.only(bottom: 10.0.h),
      child: GestureDetector(
        onTap: () {
          final addHabits =
              Provider.of<AddHabitsProvider>(context, listen: false);
          addHabits.setReminderHabit(recommended[i]);
          final updateHabit =
              Provider.of<UpdateHabitsProvider>(context, listen: false);
          updateHabit.setReminderHabit(recommended[i]);
          //debugPrint(recommended[i]);
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.only(left: 26.0.w, top: 12.35.h, bottom: 14.69.h),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0.r),
              color: const Color(0xffF4F4F2)),
          child: Text(
            recommended[i],
            style: TextStyle(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    ));
  }
  return Column(
    children: list,
  );
}

Future<dynamic> buildBottomSheetRecommendationReward({
  required BuildContext context,
  required String heading,
  required String subHeading,
  required List<String> recommended,
}) {
  return showModalBottomSheet(
    isScrollControlled:
        true, // it'll allow the bottom sheet to take the required height which gives more insurance that TextField is not covered by the keyboard.
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0.r),
      ),
    ),
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom), // for lifiting the widget upward when textfield is in use
        child: Padding(
          padding: EdgeInsets.only(
              top: 18.0.h, left: 12.0.w, right: 12.0.w, bottom: 5.0.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeading(heading),
              SizedBox(
                height: 9.5.h,
              ),
              _buildSubHeading(subHeading),
              SizedBox(
                height: 9.5.h,
              ),
              _buildRewardTextField(context),
              SizedBox(
                height: 10.26.h,
              ),
              _buildRecommendedText(),
              SizedBox(
                height: 10.26.h,
              ),
              _buildReommendedWidgetsReward(
                  recommended, context), // rendering all recommended widgets
            ],
          ),
        ),
      ),
    ),
  );
}

TextField _buildRewardTextField(BuildContext context) {
  return TextField(
    //maxLength: 50,
    onSubmitted: (val) {
      final addHabits = Provider.of<AddHabitsProvider>(context, listen: false);
      addHabits.setReward(val);
      final updateHabit =
          Provider.of<UpdateHabitsProvider>(context, listen: false);
      updateHabit.setReward(val);
      // print("HAbits" + addHabits.createHabitRequestModel.reminderHabit);
      Navigator.pop(context);
    },
    decoration: InputDecoration(
      hintText: 'add your own',
      hintStyle: TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w300,
      ),
      contentPadding: EdgeInsets.only(
          left: 24.0.w, right: 24.0.w, top: 12.35.h, bottom: 14.69),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0.r),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.bottomSheetTextFieldColor,
    ),
  );
}

Widget _buildReommendedWidgetsReward(
    List<dynamic> recommended, BuildContext context) {
  List<Widget> list = [];
  for (int i = 0; i < recommended.length; i++) {
    list.add(Padding(
      padding: EdgeInsets.only(bottom: 10.0.h),
      child: GestureDetector(
        onTap: () {
          final addHabits =
              Provider.of<AddHabitsProvider>(context, listen: false);
          addHabits.setReward(recommended[i]);
          final updateHabit =
              Provider.of<UpdateHabitsProvider>(context, listen: false);
          updateHabit.setReward(recommended[i]);
          //debugPrint(recommended[i]);
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.only(left: 26.0.w, top: 12.35.h, bottom: 14.69.h),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0.r),
              color: const Color(0xffF4F4F2)),
          child: Text(
            recommended[i],
            style: TextStyle(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    ));
  }
  return Column(
    children: list,
  );
}

Future<dynamic> buildBottomSheetRecommendationExactBehaviour({
  required BuildContext context,
  required String heading,
  required String subHeading,
  required List<String> recommended,
}) {
  return showModalBottomSheet(
    isScrollControlled:
        true, // it'll allow the bottom sheet to take the required height which gives more insurance that TextField is not covered by the keyboard.
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0.r),
      ),
    ),
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom), // for lifiting the widget upward when textfield is in use
        child: Padding(
          padding: EdgeInsets.only(
              top: 18.0.h, left: 12.0.w, right: 12.0.w, bottom: 5.0.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeading(heading),
              SizedBox(
                height: 9.5.h,
              ),
              _buildSubHeading(subHeading),
              SizedBox(
                height: 9.5.h,
              ),
              _buildExactBehaviourTextField(context),
              SizedBox(
                height: 10.26.h,
              ),
              _buildRecommendedText(),
              SizedBox(
                height: 10.26.h,
              ),
              _buildReommendedWidgetsExactBehaviour(
                  recommended, context), // rendering all recommended widgets
            ],
          ),
        ),
      ),
    ),
  );
}

TextField _buildExactBehaviourTextField(BuildContext context) {
  return TextField(
    //maxLength: 50,
    onSubmitted: (val) {
      final addHabits = Provider.of<AddHabitsProvider>(context, listen: false);
      addHabits.setExactBehaviour(val);
      final updateHabit =
          Provider.of<UpdateHabitsProvider>(context, listen: false);
      updateHabit.setExactBehaviour(val);
      // print("HAbits" + addHabits.createHabitRequestModel.reminderHabit);
      Navigator.pop(context);
    },
    decoration: InputDecoration(
      hintText: 'add your own',
      hintStyle: TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w300,
      ),
      contentPadding: EdgeInsets.only(
          left: 24.0.w, right: 24.0.w, top: 12.35.h, bottom: 14.69),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0.r),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.bottomSheetTextFieldColor,
    ),
  );
}

Widget _buildReommendedWidgetsExactBehaviour(
    List<dynamic> recommended, BuildContext context) {
  List<Widget> list = [];
  for (int i = 0; i < recommended.length; i++) {
    list.add(Padding(
      padding: EdgeInsets.only(bottom: 10.0.h),
      child: GestureDetector(
        onTap: () {
          final addHabits =
              Provider.of<AddHabitsProvider>(context, listen: false);
          addHabits.setExactBehaviour(recommended[i]);
          final updateHabit =
              Provider.of<UpdateHabitsProvider>(context, listen: false);
          updateHabit.setExactBehaviour(recommended[i]);
          //debugPrint(recommended[i]);
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.only(left: 26.0.w, top: 12.35.h, bottom: 14.69.h),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0.r),
              color: const Color(0xffF4F4F2)),
          child: Text(
            recommended[i],
            style: TextStyle(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    ));
  }
  return Column(
    children: list,
  );
}

Future<dynamic> buildBottomSheetRecommendationDaysperMonth({
  required BuildContext context,
  required String heading,
  required String subHeading,
  required List<String> recommended,
}) {
  return showModalBottomSheet(
    isScrollControlled:
        true, // it'll allow the bottom sheet to take the required height which gives more insurance that TextField is not covered by the keyboard.
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0.r),
      ),
    ),
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom), // for lifiting the widget upward when textfield is in use
        child: Padding(
          padding: EdgeInsets.only(
              top: 18.0.h, left: 12.0.w, right: 12.0.w, bottom: 5.0.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeading(heading),
              SizedBox(
                height: 9.5.h,
              ),
              _buildSubHeading(subHeading),
              SizedBox(
                height: 9.5.h,
              ),
              _buildDaysperMonthTextField(context),
              SizedBox(
                height: 10.26.h,
              ),
              _buildRecommendedText(),
              SizedBox(
                height: 10.26.h,
              ),
              _buildReommendedWidgetsDaysPerMonth(
                recommended,
                context,
              ), // rendering all recommended widgets
            ],
          ),
        ),
      ),
    ),
  );
}

TextField _buildDaysperMonthTextField(BuildContext context) {
  return TextField(
    //maxLength: 50,
    onSubmitted: (val) {
      final addHabits = Provider.of<AddHabitsProvider>(context, listen: false);
      addHabits.setDaysPerMonth(val);
      final updateHabit =
          Provider.of<UpdateHabitsProvider>(context, listen: false);
      updateHabit.setDaysPerMonth(val);
      // print("HAbits" + addHabits.createHabitRequestModel.reminderHabit);
      Navigator.pop(context);
    },
    decoration: InputDecoration(
      hintText: 'add your own',
      hintStyle: TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w300,
      ),
      contentPadding: EdgeInsets.only(
          left: 24.0.w, right: 24.0.w, top: 12.35.h, bottom: 14.69),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0.r),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.bottomSheetTextFieldColor,
    ),
  );
}

Widget _buildReommendedWidgetsDaysPerMonth(
    List<dynamic> recommended, BuildContext context) {
  List<Widget> list = [];
  for (int i = 0; i < recommended.length; i++) {
    list.add(Padding(
      padding: EdgeInsets.only(bottom: 10.0.h),
      child: GestureDetector(
        onTap: () {
          final addHabits =
              Provider.of<AddHabitsProvider>(context, listen: false);
          addHabits.setDaysPerMonth(recommended[i]);
          final updateHabit =
              Provider.of<UpdateHabitsProvider>(context, listen: false);
          updateHabit.setDaysPerMonth(recommended[i]);
          //debugPrint(recommended[i]);
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.only(left: 26.0.w, top: 12.35.h, bottom: 14.69.h),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0.r),
              color: const Color(0xffF4F4F2)),
          child: Text(
            recommended[i],
            style: TextStyle(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    ));
  }
  return Column(
    children: list,
  );
}

Future<dynamic> buildBottomSheetRecommendationPunishment({
  required BuildContext context,
  required String heading,
  required String subHeading,
  required List<String> recommended,
}) {
  return showModalBottomSheet(
    isScrollControlled:
        true, // it'll allow the bottom sheet to take the required height which gives more insurance that TextField is not covered by the keyboard.
    backgroundColor: Colors.white,
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0.r),
      ),
    ),
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom), // for lifiting the widget upward when textfield is in use
        child: Padding(
          padding: EdgeInsets.only(
              top: 18.0.h, left: 12.0.w, right: 12.0.w, bottom: 5.0.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeading(heading),
              SizedBox(
                height: 9.5.h,
              ),
              _buildSubHeading(subHeading),
              SizedBox(
                height: 9.5.h,
              ),
              _buildDaysperPunishmentField(context),
              SizedBox(
                height: 10.26.h,
              ),
              _buildRecommendedText(),
              SizedBox(
                height: 10.26.h,
              ),
              _buildReommendedWidgetsPunishment(
                recommended,
                context,
              ), // rendering all recommended widgets
            ],
          ),
        ),
      ),
    ),
  );
}

TextField _buildDaysperPunishmentField(BuildContext context) {
  return TextField(
    //maxLength: 50,
    onSubmitted: (val) {
      final addHabits = Provider.of<AddHabitsProvider>(context, listen: false);
      addHabits.setPunishment(val);
      final updateHabit =
          Provider.of<UpdateHabitsProvider>(context, listen: false);
      updateHabit.setPunishment(val);
      // print("HAbits" + addHabits.createHabitRequestModel.reminderHabit);
      Navigator.pop(context);
    },
    decoration: InputDecoration(
      hintText: 'add your own',
      hintStyle: TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w300,
      ),
      contentPadding: EdgeInsets.only(
          left: 24.0.w, right: 24.0.w, top: 12.35.h, bottom: 14.69),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0.r),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.bottomSheetTextFieldColor,
    ),
  );
}

Widget _buildReommendedWidgetsPunishment(
    List<dynamic> recommended, BuildContext context) {
  List<Widget> list = [];
  for (int i = 0; i < recommended.length; i++) {
    list.add(Padding(
      padding: EdgeInsets.only(bottom: 10.0.h),
      child: GestureDetector(
        onTap: () {
          final addHabits =
              Provider.of<AddHabitsProvider>(context, listen: false);
          addHabits.setPunishment(recommended[i]);
          final updateHabit =
              Provider.of<UpdateHabitsProvider>(context, listen: false);
          updateHabit.setPunishment(recommended[i]);
          //debugPrint(recommended[i]);
          Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.only(left: 26.0.w, top: 12.35.h, bottom: 14.69.h),
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0.r),
              color: const Color(0xffF4F4F2)),
          child: Text(
            recommended[i],
            style: TextStyle(
              fontSize: 14.0.sp,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
      ),
    ));
  }
  return Column(
    children: list,
  );
}

Future<dynamic> buildBottomSheetRecommendationFriends({
  required BuildContext context,
  required String heading,
  required var habitProvider,
  required TextEditingController editingController,
}) {
  return showModalBottomSheet(
    isScrollControlled:
        true, // it'll allow the bottom sheet to take the required height which gives more insurance that TextField is not covered by the keyboard.
    backgroundColor: Colors.white,

    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(25.0.r),
      ),
    ),
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.80,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.w)),
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context)
                .viewInsets
                .bottom), // for lifiting the widget upward when textfield is in use
        child: Padding(
          padding: EdgeInsets.only(
              top: 18.0.h, left: 12.0.w, right: 12.0.w, bottom: 5.0.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildHeading(heading),
              SizedBox(
                height: 9.5.h,
              ),
              _buildSearchTextField(context, editingController),
              SizedBox(
                height: 10.26.h,
              ),
              _buildFriendsText(),
              SizedBox(
                height: 10.26.h,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: _buildReommendedWidgetsFriends(
                    habitProvider,
                    context,
                    editingController,
                  ),
                ),
              ), // rendering all recommended widgets
            ],
          ),
        ),
      ),
    ),
  ).whenComplete(() {
    editingController.clear(); // onclosing of bottomsheet
  });
}

Align _buildFriendsText() {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 9.0.w),
      child: Text(
        'contacts',
        style: TextStyle(
            fontSize: BottomSheetTextStyle.paragraphSize,
            fontWeight: BottomSheetTextStyle.paragraphWeight),
      ),
    ),
  );
}

Widget _buildReommendedWidgetsFriends(var habitProvider, BuildContext context,
    TextEditingController editingController) {
  List<Contact>? recommended = editingController.text.isEmpty
      ? habitProvider.contacts
      : habitProvider.contactsFiltered;
  List<Widget> list = [];
  for (int i = 0; i < recommended!.length; i++) {
    recommended[i].displayName != null && recommended[i].phones!.isNotEmpty
        // recommended[i].androidAccountType == AndroidAccountType.whatsapp ||
        //         recommended[i].androidAccountType == AndroidAccountType.google
        ? list.add(Padding(
            padding: EdgeInsets.only(bottom: 10.0.h),
            child: GestureDetector(
                onTap: () {
                  final addHabits =
                      Provider.of<AddHabitsProvider>(context, listen: false);
                  addHabits.setFriends(recommended[i].displayName!);
                  addHabits.createHabitRequestModel.accountabilityPartnerName =
                      recommended[i].displayName!;

                  try {
                    addHabits.createHabitRequestModel
                            .accountabilityPartnerPhoneNumber =
                        recommended[i].phones!.first.value!;
                    addHabits.setPhone(recommended[i].phones!.first.value!);
                  } catch (e) {
                    log("error : $e in _buildReommendedWidgetsFriends ");
                  }

                  final updateHabits =
                      Provider.of<UpdateHabitsProvider>(context, listen: false);
                  updateHabits.setFriends(recommended[i].displayName!);

                  updateHabits.updateHabitRequestModel
                      .accountabilityPartnerName = recommended[i].displayName!;

                  try {
                    updateHabits.updateHabitRequestModel
                            .accountabilityPartnerPhoneNumber =
                        recommended[i].phones!.first.value!;
                    updateHabits.setPhone(recommended[i].phones!.first.value!);
                  } catch (e) {
                    log("error : $e in _buildReommendedWidgetsFriends ");
                  }
                  //print(recommended[i].phones!.first.value);
                  Navigator.pop(context);
                },
                child: Container(
                  padding: EdgeInsets.only(
                      left: 26.0.w, top: 12.35.h, bottom: 14.69.h),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0.r),
                      color: const Color(0xffF4F4F2)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        recommended[i].displayName!,
                        style: TextStyle(
                          fontSize: 14.0.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        recommended[i].phones!.first.value!,
                        style: TextStyle(
                          fontSize: 10.0.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                )),
          ))
        : Container();

    // debugPrint("______________________________, ${recommended[i]}");
    // debugPrint('object');
  }
  return Column(
    children: list,
  );
}

TextField _buildSearchTextField(
    BuildContext context, TextEditingController editingController) {
  final addHabits = Provider.of<AddHabitsProvider>(context, listen: true);
  final updateHabit = Provider.of<UpdateHabitsProvider>(context, listen: true);
  return TextField(
    //maxLength: 50,
    // onSubmitted: (val) {
    //   addHabits.setReminderHabit(val);
    //   updateHabit.setReminderHabit(val);
    //   // print("HAbits" + addHabits.createHabitRequestModel.reminderHabit);
    //   Navigator.pop(context);
    // },
    controller: editingController,
    onChanged: (value) {
      addHabits.filteredContacts(editingController, value);
      updateHabit.filteredContacts(editingController, value);
      print(editingController);
    },
    decoration: InputDecoration(
      hintText: 'search friends',
      hintStyle: TextStyle(
        fontSize: 14.0.sp,
        fontWeight: FontWeight.w300,
      ),
      contentPadding: EdgeInsets.only(
          left: 24.0.w, right: 24.0.w, top: 12.35.h, bottom: 14.69),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15.0.r),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.bottomSheetTextFieldColor,
    ),
  );
}
