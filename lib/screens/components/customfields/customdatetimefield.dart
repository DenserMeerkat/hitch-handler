import 'dart:ui';
import 'package:flutter/material.dart';
import '../../components/customfields/fieldlabel.dart';
import '../../../constants.dart';
import '../pickers&dialogs/datetimepicker.dart';

class CustomDateTime extends StatefulWidget {
  DateTime dateController;
  TimeOfDay timeController;
  CustomDateTime({
    super.key,
    required this.dateController,
    required this.timeController,
  });
  @override
  State<CustomDateTime> createState() => _CustomDateTimeState();
}

class _CustomDateTimeState extends State<CustomDateTime> {
  late String day;
  late String mon;
  late String year;

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
      day = widget.dateController.toString().substring(8, 10);
      mon = widget.dateController.toString().substring(5, 7);
      year = widget.dateController.toString().substring(0, 4);
    });
  }

  void updateTime() {
    String hrStr;
    int hrInt = int.parse(widget.timeController.toString().substring(10, 12));
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
      min = widget.timeController.toString().substring(13, 15);
      ampm = int.parse(widget.timeController.toString().substring(10, 12)) >= 12
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
        widget.dateController,
      );
      if (pickeddate != null) {
        setState(() {
          widget.dateController = pickeddate;
        });
      }
      updateDate();
    }

    void launchTime() async {
      TimeOfDay? pickedtime = await selectTime(
        context,
        kPrimaryColor,
        widget.timeController,
      );
      if (pickedtime != null && pickedtime != widget.timeController) {
        setState(() {
          widget.timeController = pickedtime;
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
