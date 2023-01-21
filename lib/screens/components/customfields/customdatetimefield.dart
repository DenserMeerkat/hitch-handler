import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hitch_handler/screens/user_home/add/notifiers.dart';
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
    const textStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontFeatures: [FontFeature.oldstyleFigures()],
    );
    BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(5),
      color: kGrey30.withOpacity(0.8),
      border: Border.all(
        width: 1.2,
        color: kGrey30,
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
        const FieldLabel(
            fgcolor: kPrimaryColor,
            title: "Date & Time",
            bgcolor: kBlack15,
            tooltip: 'tooltip'),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          decoration: const BoxDecoration(
              color: kGrey50,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0),
              ),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 3),
                  color: kBlack20,
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
                      color: kBlack20,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.calendar_month_outlined,
                    ),
                  ),
                ),
                iconColor: kPrimaryColor,
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
                            const SizedBox(
                              width: 10,
                              child: Center(
                                child: FittedBox(
                                  child: Text("-"),
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
                            const SizedBox(
                              width: 10,
                              child: Center(
                                child: FittedBox(
                                  child: Text("-"),
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
              const Divider(
                thickness: 1.0,
                color: kBlack20,
              ),
              ListTile(
                trailing: GestureDetector(
                  onTap: launchTime,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: kBlack20,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Icon(
                      Icons.schedule_rounded,
                    ),
                  ),
                ),
                iconColor: kPrimaryColor,
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
                              child: const Center(
                                child: FittedBox(
                                  child: Text(":"),
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
                            style: textStyle.copyWith(
                                color: kTextColor.withOpacity(0.8)),
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
