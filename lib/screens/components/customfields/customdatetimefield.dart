// Dart imports:
import 'dart:ui';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/customfields/fieldlabel.dart';
import 'package:hitch_handler/screens/components/customiconbutton.dart';
import 'package:hitch_handler/screens/components/utils/datetimepicker.dart';
import 'package:hitch_handler/screens/user_home/notifiers.dart';

class CustomDateTime extends StatefulWidget {
  const CustomDateTime({required Key key}) : super(key: key);
  @override
  State<CustomDateTime> createState() => CustomDateTimeState();
}

class CustomDateTimeState extends State<CustomDateTime> {
  DateTime? myDateController;
  TimeOfDay? myTimeController;

  late String day = "dd";
  late String mon = "mm";
  late String year = "yyyy";

  late String hour = "hh";
  late String min = "mm";
  late String ampm = "am_pm";

  @override
  void initState() {
    super.initState();
  }

  void updateDate() {
    setState(() {
      day = myDateController.toString().substring(8, 10);
      mon = myDateController.toString().substring(5, 7);
      year = myDateController.toString().substring(0, 4);
    });
  }

  void updateTime() {
    String hrStr;
    int hrInt = int.parse(myTimeController.toString().substring(10, 12));
    if (hrInt > 12) {
      hrStr = (hrInt - 12).toString();
      if (hrStr.length == 1) {
        hrStr = '0$hrStr';
      }
    } else {
      hrStr = hrInt.toString();
      if (hrStr.length == 1) {
        hrStr = '0$hrStr';
      }
    }
    setState(() {
      hour = hrStr;
      min = myTimeController.toString().substring(13, 15);
      ampm = int.parse(myTimeController.toString().substring(10, 12)) >= 12
          ? "pm"
          : "am";
    });
  }

  void resetTime() {
    setState(() {
      myTimeController = null;
      hour = "hh";
      min = "mm";
      ampm = "am / pm";
    });
    DateTimeChanged(myDateController, myTimeController).dispatch(context);
  }

  void resetDate() {
    setState(() {
      myDateController = null;
      day = "dd";
      mon = "mm";
      year = "yyyy";
    });
    DateTimeChanged(myDateController, myTimeController).dispatch(context);
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;

    TextStyle textStyle =
        AdaptiveTheme.of(context).theme.textTheme.bodyMedium!.copyWith(
      fontSize: 14.r,
      fontWeight: FontWeight.bold,
      fontFeatures: [const FontFeature.oldstyleFigures()],
    );
    BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: isDark ? kGrey30.withOpacity(0.8) : kLBlack20.withOpacity(0.5),
      border: Border.all(
        width: 1.2,
        color: isDark ? kGrey30 : kLGrey30,
      ),
    );
    void launchDate() async {
      DateTime? pickeddate = await showCustomDatePicker(
        context,
        kPrimaryColor,
        myDateController ?? DateTime.now(),
      );
      if (pickeddate != null) {
        setState(() {
          myDateController = pickeddate;
          DateTimeChanged(myDateController, myTimeController).dispatch(context);
        });
        updateDate();
      }
    }

    void launchTime() async {
      TimeOfDay? pickedtime = await selectTime(
        context,
        kPrimaryColor,
        myTimeController ?? const TimeOfDay(hour: 0, minute: 0),
      );
      if (pickedtime != null && pickedtime != myTimeController) {
        setState(() {
          myTimeController = pickedtime;
          DateTimeChanged(myDateController, myTimeController).dispatch(context);
        });
        updateTime();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(
            fgcolor: isDark ? kPrimaryColor : kLPrimaryColor,
            title: "Date & Time",
            bgcolor: isDark ? kBlack15 : kGrey30,
            tooltip: 'tooltip'),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: BoxDecoration(
            color: isDark ? kGrey50 : kLBlack10,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 0.5,
              color: isDark ? kBlack20 : kGrey150,
            ),
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, 1.5),
                color: isDark ? kBlack20 : kGrey150,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                contentPadding: day != "dd"
                    ? const EdgeInsets.symmetric(horizontal: 10)
                    : null,
                leading: day != "dd"
                    ? CustomIconButton(
                        icon: Icons.close,
                        tooltip: 'Reset Date',
                        onTap: resetDate,
                      )
                    : null,
                trailing: TrailingWidget(
                  icon: Icons.calendar_month_outlined,
                  tooltip: 'Edit Date',
                  onTap: launchDate,
                ),
                iconColor: isDark ? kPrimaryColor : kLPrimaryColor,
                title: day != "dd"
                    ? Transform.translate(
                        offset: const Offset(-10, 0),
                        child: DateWidget(
                            onTap: launchDate,
                            boxDecoration: boxDecoration,
                            day: day,
                            textStyle: textStyle,
                            mon: mon,
                            year: year),
                      )
                    : DateWidget(
                        onTap: launchDate,
                        boxDecoration: boxDecoration,
                        day: day,
                        textStyle: textStyle,
                        mon: mon,
                        year: year),
              ),
              Divider(
                thickness: 1.0,
                color: isDark ? kBlack20 : kLGrey30,
              ),
              ListTile(
                contentPadding: hour != "hh"
                    ? const EdgeInsets.symmetric(horizontal: 10)
                    : null,
                leading: hour != "hh"
                    ? CustomIconButton(
                        icon: Icons.close,
                        tooltip: 'Reset Time',
                        onTap: resetTime,
                      )
                    : null,
                trailing: TrailingWidget(
                  icon: Icons.schedule_rounded,
                  tooltip: 'Edit Time',
                  onTap: launchTime,
                ),
                iconColor: isDark ? kPrimaryColor : kLPrimaryColor,
                title: hour != "hh"
                    ? Transform.translate(
                        offset: const Offset(-10, 0),
                        child: TimeWidget(
                            onTap: launchTime,
                            boxDecoration: boxDecoration,
                            hour: hour,
                            textStyle: textStyle,
                            min: min,
                            ampm: ampm),
                      )
                    : TimeWidget(
                        onTap: launchTime,
                        boxDecoration: boxDecoration,
                        hour: hour,
                        textStyle: textStyle,
                        min: min,
                        ampm: ampm),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DateWidget extends StatelessWidget {
  const DateWidget({
    super.key,
    required this.boxDecoration,
    required this.day,
    required this.textStyle,
    required this.mon,
    required this.year,
    this.onTap,
  });

  final BoxDecoration boxDecoration;
  final String day;
  final TextStyle textStyle;
  final String mon;
  final String year;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: boxDecoration,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  //decoration: boxDecoration,
                  child: FittedBox(
                    child: Text(
                      day,
                      style: textStyle,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        "-",
                        style: textStyle,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  //decoration: boxDecoration,
                  child: FittedBox(
                    child: Text(
                      mon,
                      style: textStyle,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        "-",
                        style: textStyle,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  //decoration: boxDecoration,
                  child: FittedBox(
                    child: Text(
                      year,
                      style: textStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TimeWidget extends StatelessWidget {
  const TimeWidget({
    super.key,
    required this.boxDecoration,
    required this.hour,
    required this.textStyle,
    required this.min,
    required this.ampm,
    this.onTap,
  });

  final BoxDecoration boxDecoration;
  final String hour;
  final TextStyle textStyle;
  final String min;
  final String ampm;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            decoration: boxDecoration,
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  //decoration: boxDecoration,
                  child: FittedBox(
                    child: Text(
                      hour,
                      style: textStyle,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 2,
                  ),
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        ":",
                        style: textStyle,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  //decoration: boxDecoration,
                  child: FittedBox(
                    child: Text(
                      min,
                      style: textStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: boxDecoration,
            child: FittedBox(
              child: Text(
                ampm,
                style: textStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TrailingWidget extends StatelessWidget {
  final String tooltip;
  final IconData icon;
  final Function()? onTap;
  const TrailingWidget({
    super.key,
    required this.tooltip,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isDark ? kBlack20 : kPrimaryColor.withOpacity(0.3),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(
            icon,
            color: isDark ? kPrimaryColor : kLTextColor,
          ),
        ),
      ),
    );
  }
}
