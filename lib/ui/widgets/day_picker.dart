import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DayInWeek {
  String dayName;
  bool isSelected = false;

  DayInWeek(this.dayName, {this.isSelected = false});

  void toggleIsSelected() {
    this.isSelected = !this.isSelected;
  }
}

class SelectWeekDays extends StatefulWidget {
  /// [onSelect] callBack to handle the Selected days
  final Function onSelect;

  /// List of days of type `DayInWeek`
  List<DayInWeek> days;

  /// [backgroundColor] - property to change the color of the container.
  final Color? backgroundColor;

  /// [fontWeight] - property to change the weight of selected text
  final FontWeight? fontWeight;

  /// [fontSize] - property to change the size of selected text
  final double? fontSize;

  /// [daysFillColor] -  property to change the button color of days when the button is pressed.
  final Color? daysFillColor;

  /// [daysBorderColor] - property to change the bordercolor of the rounded buttons.
  final Color? daysBorderColor;

  /// [selectedDayTextColor] - property to change the color of text when the day is selected.
  final Color? selectedDayTextColor;

  /// [unSelectedDayTextColor] - property to change the text color when the day is not selected.
  final Color? unSelectedDayTextColor;

  /// [border] Boolean to handle the day button border by default the border will be true.
  final bool border;

  /// [boxDecoration] to handle the decoration of the container.
  final BoxDecoration? boxDecoration;

  /// [padding] property  to handle the padding between the container and buttons by default it is 8.0
  final double padding;

  /// `SelectWeekDays` takes a list of days of type `DayInWeek`.
  /// `onSelect` property will return `list` of days that are selected.
  SelectWeekDays({
    required this.onSelect,
    this.backgroundColor,
    this.fontWeight,
    this.fontSize,
    this.daysFillColor,
    this.daysBorderColor,
    this.selectedDayTextColor,
    this.unSelectedDayTextColor,
    this.border = true,
    this.boxDecoration,
    this.padding = 8.0,
    required this.days,
    Key? key,
  }) : super(key: key);

  @override
  _SelectWeekDaysState createState() => _SelectWeekDaysState(days);
}

class _SelectWeekDaysState extends State<SelectWeekDays> {
  _SelectWeekDaysState(List<DayInWeek> days) : _daysInWeek = days;

  // list to insert the selected days.
  List<String> selectedDays = [];

  // list of days in a week.
  List<DayInWeek> _daysInWeek = [];

  @override
  void initState() {
    _daysInWeek.forEach((element) {
      if (element.isSelected) {
        selectedDays.add(element.dayName);
      }
    });
    super.initState();
  }

  void _getSelectedWeekDays(bool isSelected, String day) {
    if (isSelected == true) {
      if (!selectedDays.contains(day)) {
        selectedDays.add(day);
      }
    } else if (isSelected == false) {
      if (selectedDays.contains(day)) {
        selectedDays.remove(day);
      }
    }
    // [onSelect] is the callback which passes the Selected days as list.
    widget.onSelect(selectedDays.toList());
  }

// getter to handle background color of container.
  Color? get _handleBackgroundColor {
    if (widget.backgroundColor == null) {
      // ignore: deprecated_member_use
      return Theme.of(context).accentColor;
    } else {
      return widget.backgroundColor;
    }
  }

// getter to handle fill color of buttons.
  Color? get _handleDaysFillColor {
    if (widget.daysFillColor == null) {
      return Colors.white;
    } else {
      return widget.daysFillColor;
    }
  }

//getter to handle border color of days[buttons].
  // ignore: unused_element
  Color? get _handleBorderColorOfDays {
    if (widget.daysBorderColor == null) {
      return Colors.white;
    } else {
      return widget.daysBorderColor;
    }
  }

// Handler to change the text color when the button is pressed and not pressed.
  Color? _handleTextColor(bool onSelect) {
    if (onSelect == true) {
      if (widget.selectedDayTextColor == null) {
        return Colors.black;
      } else {
        return widget.selectedDayTextColor;
      }
    } else if (onSelect == false) {
      if (widget.unSelectedDayTextColor == null) {
        return Colors.white;
      } else {
        return widget.unSelectedDayTextColor;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: widget.boxDecoration ??
          BoxDecoration(
            color: _handleBackgroundColor,
            borderRadius: BorderRadius.circular(0),
          ),
      child: Padding(
        padding: EdgeInsets.all(widget.padding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: _daysInWeek.map(
            (day) {
              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      day.toggleIsSelected();
                    });
                    _getSelectedWeekDays(day.isSelected, day.dayName);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      gradient: day.isSelected == true
                          ? const LinearGradient(
                              colors: [
                                  Color(0xffFA8A3C),
                                  Color(0xffFFD037),
                                ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight)
                          : null,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      height: 32.r,
                      width: 32.r,
                      decoration: BoxDecoration(
                          color: day.isSelected == true
                              ? _handleDaysFillColor
                              : Colors.white,
                          shape: BoxShape.circle),
                      child: Center(
                        child: Text(
                          day.dayName.substring(0, 1),
                          style: TextStyle(
                            fontSize: widget.fontSize,
                            fontWeight: widget.fontWeight,
                            color: _handleTextColor(day.isSelected),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
