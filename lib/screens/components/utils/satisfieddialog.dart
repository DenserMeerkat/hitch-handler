// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_segmented_control/material_segmented_control.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/resources/firestore_methods.dart';
import 'package:hitch_handler/screens/components/customfields/dialogtextfield.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';
import 'package:hitch_handler/string_extensions.dart';

class SatisfiedDialog extends StatefulWidget {
  final dynamic snap;
  final dynamic user;
  final Function(bool) onSubmit;
  const SatisfiedDialog(
      {super.key,
      required this.snap,
      required this.user,
      required this.onSubmit});
  @override
  State<SatisfiedDialog> createState() => _SatisfiedDialogState();
}

class _SatisfiedDialogState extends State<SatisfiedDialog> {
  final TextEditingController myTextFieldController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool submit = false;
  bool clear = false;
  String? choice;
  final Map<int, Widget> _children = {
    0: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 1),
      child: Text('Yes'),
    ),
    1: const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 1),
      child: Text('No'),
    ),
  };
  int? currentSelection;
  @override
  void initState() {
    myTextFieldController.addListener(() {
      setState(() {
        clear = myTextFieldController.text.isNotEmpty;
        submit = myTextFieldController.text.isNotEmpty;
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
              Icons.thumbs_up_down_outlined,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            "Are you Satisfied ?",
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
              const SizedBox(height: 4),
              Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: choice == "Yes",
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: const Icon(
                            Icons.thumb_up,
                            size: 20,
                            color: kPrimaryColor,
                          ),
                        ),
                        const SizedBox(width: 12),
                        MaterialSegmentedControl(
                          verticalOffset: 8,
                          children: _children,
                          selectionIndex: currentSelection,
                          borderColor: Colors.grey[600],
                          borderWidth: 1,
                          selectedColor: currentSelection == 0
                              ? kPrimaryColor
                              : isDark
                                  ? AdaptiveTheme.of(context)
                                      .theme
                                      .colorScheme
                                      .error
                                  : kErrorColor,
                          unselectedColor: isDark ? kGrey30 : kLBlack15,
                          selectedTextStyle: TextStyle(
                            fontSize: 14,
                            color: isDark ? kLTextColor : kTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                          unselectedTextStyle: TextStyle(
                            color: Colors.grey[700],
                            fontWeight: FontWeight.w600,
                          ),
                          borderRadius: 50,
                          horizontalPadding: EdgeInsets.zero,
                          onSegmentTapped: (index) {
                            String selection;
                            switch (index) {
                              case 0:
                                selection = 'Yes';
                                break;
                              case 1:
                                selection = 'No';
                                break;
                              default:
                                selection = 'Yes';
                            }
                            setState(() {
                              currentSelection = index;
                              choice = selection;
                            });
                          },
                        ),
                        const SizedBox(width: 12),
                        Visibility(
                          visible: choice == "No",
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Icon(
                            Icons.thumb_down,
                            size: 20,
                            color: isDark
                                ? AdaptiveTheme.of(context)
                                    .theme
                                    .colorScheme
                                    .error
                                : kErrorColor,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 12.0),
                          child: Text(
                            "Write a Brief comment.",
                            style: TextStyle(
                              color: choice != null
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
                          enabled: choice != null && currentSelection != null,
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
                    FocusManager.instance.primaryFocus?.unfocus();
                    if (_formkey.currentState!.validate()) {
                      widget.onSubmit(true);
                      String res = "";
                      res = await FirestoreMethods().isSatisfiedUpdate(
                          widget.snap['postId'],
                          choice!,
                          myTextFieldController.text);
                      debugPrint("Satisfaction Change");
                      if (!mounted) return;
                      Navigator.of(context).pop();
                      Future.delayed(const Duration(milliseconds: 1), () {
                        final scaffoldContext = ScaffoldMessenger.of(context);
                        bool isDark = AdaptiveTheme.of(context).brightness ==
                            Brightness.dark;
                        late String snackbarText;
                        if (res == "success") {
                          snackbarText = "Satisfaction Recorded";
                        } else {
                          snackbarText = res;
                        }
                        final snackBar = SnackBar(
                          content: Text(
                            snackbarText,
                            style: TextStyle(
                                color: isDark ? kTextColor : kLTextColor),
                          ),
                          behavior: SnackBarBehavior.floating,
                          backgroundColor: isDark ? kGrey40 : kLBlack10,
                        );
                        scaffoldContext.showSnackBar(snackBar);
                      });
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
}
