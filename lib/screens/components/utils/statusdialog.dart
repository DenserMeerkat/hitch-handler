// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:im_stepper/stepper.dart';

// Project imports:
import 'package:hitch_handler/screens/common/post/posttop.dart';
import 'package:hitch_handler/screens/components/customfields/dialogtextfield.dart';
import 'package:hitch_handler/screens/components/customiconbutton.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';
import 'package:hitch_handler/string_extensions.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/resources/firestore_methods.dart';

class StatusDialog extends StatefulWidget {
  final int statusIndex;
  final dynamic snap;
  final dynamic user;
  const StatusDialog(
      {super.key,
      required this.statusIndex,
      required this.snap,
      required this.user});
  @override
  State<StatusDialog> createState() => _StatusDialogState();
}

class _StatusDialogState extends State<StatusDialog> {
  final TextEditingController myTextFieldController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool submit = false;
  bool clear = false;
  late int statusIndex;
  late Color statusColor;
  late IconData statusIcon;
  late String statusTitle;

  @override
  void initState() {
    statusIndex = widget.statusIndex;
    statusIcon = PostTop.status[statusIndex].icon;
    statusColor = PostTop.status[statusIndex].color;
    statusTitle = PostTop.status[statusIndex].title;
    myTextFieldController.addListener(() {
      setState(() {
        clear = myTextFieldController.text.isNotEmpty;
        submit = myTextFieldController.text.isNotEmpty &&
            statusIndex != widget.statusIndex;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    myTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: isDark ? kGrey40 : kLBlack10,
      surfaceTintColor: isDark ? kGrey40 : kLBlack10,
      title: Row(
        children: [
          const FittedBox(
            child: Icon(
              Icons.track_changes_rounded,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Update Status",
            style:
                AdaptiveTheme.of(context).theme.textTheme.bodyLarge!.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
          ),
        ],
      ),
      content: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Divider(
                height: 2,
                color: isDark
                    ? kTextColor.withOpacity(0.2)
                    : kLTextColor.withOpacity(0.2),
              ),
              Theme(
                data: AdaptiveTheme.of(context).theme.copyWith(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                    ),
                child: IconStepper(
                  activeStep: statusIndex,
                  enableStepTapping: true,
                  enableNextPreviousButtons: false,
                  scrollingDisabled: true,
                  stepRadius: 18,
                  stepReachedAnimationEffect: Curves.easeOutCubic,
                  stepColor: isDark ? kGrey90 : kLGrey40,
                  lineColor: isDark ? kTextColor : kLTextColor,
                  activeStepBorderColor: isDark ? kTextColor : kLTextColor,
                  activeStepColor: statusColor,
                  icons: [
                    Icon(
                      Icons.radio_button_checked_rounded,
                      color: isDark ? kTextColor : kTextColor,
                    ),
                    Icon(
                      Icons.cached_rounded,
                      color: isDark ? kTextColor : kTextColor,
                    ),
                    Icon(
                      Icons.check_circle_outline_rounded,
                      color: isDark ? kTextColor : kTextColor,
                    ),
                  ],
                  onStepReached: (index) {
                    setState(() {
                      statusIndex = index;
                      statusIcon = PostTop.status[statusIndex].icon;
                      statusColor = PostTop.status[statusIndex].color;
                      statusTitle = PostTop.status[statusIndex].title;
                    });
                  },
                ),
              ),
              Divider(
                height: 2,
                color: isDark
                    ? kTextColor.withOpacity(0.2)
                    : kLTextColor.withOpacity(0.2),
              ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomIconButton(
                      icon: Icons.arrow_back,
                      tooltip: 'Next',
                      onTap: onPrevious,
                      bgColor: isDark
                          ? kTextColor.withOpacity(0.2)
                          : kLTextColor.withOpacity(0.2),
                      size: 24,
                      iconColor: isDark ? kTextColor : kLTextColor,
                    ),
                    SizedBox(
                      width: 110,
                      child: Status(
                        statusColor: statusColor,
                        statusIcon: statusIcon,
                        statusText: statusTitle,
                        fsize: 12,
                      ),
                    ),
                    CustomIconButton(
                      icon: Icons.arrow_forward,
                      tooltip: 'Previous',
                      onTap: onNext,
                      bgColor: isDark
                          ? kTextColor.withOpacity(0.2)
                          : kLTextColor.withOpacity(0.2),
                      size: 24,
                      iconColor: isDark ? kTextColor : kLTextColor,
                    )
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
                          child: Text(
                            "Write a Brief comment.",
                            style: TextStyle(
                              color: statusIndex != widget.statusIndex
                                  ? isDark
                                      ? kTextColor
                                      : kLTextColor
                                  : isDark
                                      ? kTextColor.withOpacity(0.4)
                                      : kLTextColor.withOpacity(0.4),
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Form(
                      key: _formkey,
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 270.w),
                        child: DialogTextFormField(
                          enabled: statusIndex != widget.statusIndex,
                          validator: (value) {
                            return validateCommnet(value);
                          },
                          controller: myTextFieldController,
                          keyboardType: TextInputType.multiline,
                          icon: Icons.edit_note_rounded,
                          hintText: "Comment",
                          clear: clear,
                          minLines: 1,
                          maxLines: 3,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Divider(
                height: 4,
                color: isDark
                    ? kTextColor.withOpacity(0.2)
                    : kLTextColor.withOpacity(0.2),
              ),
            ],
          ),
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(8, 16, 8, 0),
      actions: [
        buildCancelButton(context),
        buildActiveButton(
            context,
            submit,
            "Update",
            submit
                ? () async {
                    if (_formkey.currentState!.validate()) {
                      // Todo Status Change
                      String res = "";
                      debugPrint(widget.snap['comments']);
                      res = await FirestoreMethods().updateStatus(
                          widget.snap['postId'],
                          widget.user.uid,
                          myTextFieldController.text,
                          statusTitle,
                          widget.user.name);
                      debugPrint("Status Change");
                      if (!mounted) return;
                      Navigator.of(context).pop();
                    } else {
                      debugPrint("Error");
                    }
                  }
                : null)
      ],
      actionsPadding: const EdgeInsets.fromLTRB(24, 12, 24, 12),
    );
  }

  String? validateCommnet(String? value) {
    if (value!.isWhitespace()) {
      return "Comment can't be empty";
    } else if (value.length < 20) {
      return "Minimum 20 characters";
    } else {
      return null;
    }
  }

  void onNext() {
    if (statusIndex < 2) {
      _formkey.currentState!.reset();
      setState(() {
        statusIndex++;
        statusIcon = PostTop.status[statusIndex].icon;
        statusColor = PostTop.status[statusIndex].color;
        statusTitle = PostTop.status[statusIndex].title;
      });
    }
  }

  void onPrevious() {
    if (statusIndex > 0) {
      _formkey.currentState!.reset();
      setState(() {
        statusIndex--;
        statusIcon = PostTop.status[statusIndex].icon;
        statusColor = PostTop.status[statusIndex].color;
        statusTitle = PostTop.status[statusIndex].title;
      });
    }
  }
}
