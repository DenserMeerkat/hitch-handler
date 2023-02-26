import 'dart:ui';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import '../../user_home/notifiers.dart';
import '../../components/customfields/fieldlabel.dart';
import '../../../constants.dart';
import '../utils/datetimepicker.dart';

class CustomDateTime extends StatefulWidget {
  const CustomDateTime({
    super.key,
  });
  @override
  State<CustomDateTime> createState() => _CustomDateTimeState();
}

class _CustomDateTimeState extends State<CustomDateTime> {
  DateTime myDateController = DateTime.now();
  TimeOfDay myTimeController = const TimeOfDay(hour: 0, minute: 0);

  late String day = DateTime.now.toString().substring(8, 10);
  late String mon = DateTime.now.toString().substring(5, 7);
  late String year = DateTime.now.toString().substring(0, 4);

  late String hour;
  late String min;
  late String ampm;

  @override
  void initState() {
    updateTime();
    updateDate();
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

  @override
  Widget build(BuildContext context) {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;

    TextStyle textStyle =
        AdaptiveTheme.of(context).theme.textTheme.bodyMedium!.copyWith(
      fontWeight: FontWeight.bold,
      fontFeatures: [FontFeature.oldstyleFigures()],
    );
    BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: isDark ? kGrey30.withOpacity(0.8) : kLGrey40.withOpacity(0.4),
      border: Border.all(
        width: 1.2,
        color: isDark ? kGrey30 : kLGrey50.withOpacity(0.5),
      ),
    );
    void launchDate() async {
      DateTime? pickeddate = await showCustomDatePicker(
        context,
        kPrimaryColor,
        myDateController,
      );
      if (pickeddate != null) {
        setState(() {
          myDateController = pickeddate;
          DateTimeChanged(myDateController, myTimeController).dispatch(context);
        });
      }
      updateDate();
    }

    void launchTime() async {
      TimeOfDay? pickedtime = await selectTime(
        context,
        kPrimaryColor,
        myTimeController,
      );
      if (pickedtime != null && pickedtime != myTimeController) {
        setState(() {
          myTimeController = pickedtime;
          DateTimeChanged(myDateController, myTimeController).dispatch(context);
        });
      }
      updateTime();
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
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 3),
                  color: isDark ? kBlack20 : kGrey150,
                )
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                trailing: GestureDetector(
                  onTap: launchDate,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? kBlack20 : kGrey40,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.calendar_month_outlined,
                    ),
                  ),
                ),
                iconColor: isDark ? kPrimaryColor : kLPrimaryColor,
                title: Row(
                  children: [
                    GestureDetector(
                      onTap: launchDate,
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
                ),
              ),
              Divider(
                thickness: 1.0,
                color: isDark ? kBlack20 : kLGrey30,
              ),
              ListTile(
                trailing: GestureDetector(
                  onTap: launchTime,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark ? kBlack20 : kGrey40,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.schedule_rounded,
                    ),
                  ),
                ),
                iconColor: isDark ? kPrimaryColor : kLPrimaryColor,
                title: GestureDetector(
                  onTap: launchTime,
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
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
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
