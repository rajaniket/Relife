import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:relife/constants/assets.dart';
import 'package:relife/ui/pages/tabs/habits_screen/local_widget/utils_habit.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

import '../../../../../providers/page_provider/habit_tab_provider.dart';

class ShortCalendar extends StatefulWidget {
  const ShortCalendar({Key? key, required this.habitIndex}) : super(key: key);
  final int habitIndex;

  @override
  State<ShortCalendar> createState() => _ShortCalendarState();
}

class _ShortCalendarState extends State<ShortCalendar> {
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  //CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    // _selectedDays.addAll({
    //   DateTime(2021, 11, 1),
    //   DateTime(2021, 11, 3),
    //   DateTime(2021, 11, 5),
    //   DateTime(2021, 11, 6),
    //   DateTime(2021, 11, 7),
    //   DateTime(2021, 11, 10),
    //   DateTime(2021, 11, 19),
    //   DateTime(2021, 11, 12),
    //   DateTime(2021, 11, 15),
    //   DateTime(2021, 11, 18),
    //   DateTime(2021, 11, 21),
    //   DateTime(2021, 11, 24),
    //   DateTime(2021, 11, 30),
    // });
    final habitsPovider = Provider.of<HabitTabProvider>(context, listen: false);

    for (int i = 0;
        i <
            habitsPovider
                .listOfUserHabitdetails[widget.habitIndex].streakData!.length;
        i++) {
      var data = habitsPovider
          .listOfUserHabitdetails[widget.habitIndex].streakData![i];

      var year =
          DateTime.fromMillisecondsSinceEpoch(data.createdAt * 1000).year;
      var month =
          DateTime.fromMillisecondsSinceEpoch(data.createdAt * 1000).month;
      var day = DateTime.fromMillisecondsSinceEpoch(data.createdAt * 1000).day;
      // print(data);
      // print(DateTime.fromMicrosecondsSinceEpoch(data.createdAt * 1000));
      // print(
      //     '--------$day---------$month----------$year------${data.createdAt}');
      _selectedDays.add(DateTime(year, month, day));
    }
    super.initState();
  }

  @override
  void dispose() {
    // _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar<Event>(
      firstDay: DateTime(2000),
      lastDay: DateTime(2050),
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.twoWeeks,
      daysOfWeekHeight: 22.h,
      rowHeight: 45.h,
      headerVisible: false,
      availableGestures: AvailableGestures.none,
      currentDay: DateTime.now(),
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: const CalendarStyle(
          defaultTextStyle: TextStyle(
        fontFamily: 'Poppins',
        fontSize: 14,
        fontWeight: FontWeight.w500,
      )),

      headerStyle: HeaderStyle(
        formatButtonVisible: false,
        titleCentered: true,
        leftChevronPadding: EdgeInsets.only(left: 50.w),
        rightChevronPadding: EdgeInsets.only(right: 50.w),
      ),

      selectedDayPredicate: (day) {
        // Use values from Set to mark multiple days as selected
        return _selectedDays.contains(day);
      },
      // onDaySelected: _onDaySelected,

      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },

      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, events) => Container(
            height: 36.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xffF5DECD),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                height: 30.r,
                decoration: const BoxDecoration(
                  color: Color(0xffF7F6F2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )),
        todayBuilder: (context, date, events) => Container(
            height: 36.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xffF5DECD),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                height: 30.r,
                decoration: const BoxDecoration(
                  color: Color(0xffF7F6F2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )),
        outsideBuilder: (context, date, events) => Container(
            height: 36.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xffF5DECD),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                height: 30.r,
                decoration: const BoxDecoration(
                  color: Color(0xffF7F6F2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )),
        //dowBuilder: (context, date) => ,
        selectedBuilder: (context, date, events) => Container(
            height: 36.r,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xffFA8A3C), Color(0xffFFD037)]),
              shape: BoxShape.circle,
            ),
            child: Stack(
              children: [
                Center(
                  child: Container(
                    height: 30.r,
                    decoration: const BoxDecoration(
                      color: Color(0xffF7F6F2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                    right: 5.r,
                    bottom: 3.r,
                    //  alignment: Alignment.bottomRight,
                    child: SvgPicture.asset(AppAssets.fireIcon))
              ],
            )),
      ),
    );
  }
}
