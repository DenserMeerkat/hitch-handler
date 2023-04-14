// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// Project imports:
import 'package:hitch_handler/args_class.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/common/otp_screen.dart';
import 'package:hitch_handler/screens/components/customfields/dialogtextfield.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';
import 'package:hitch_handler/screens/signup/create_password.dart';
import 'package:hitch_handler/string_extensions.dart';

class SignUpDialog extends StatefulWidget {
  final String title;
  final IconData icon;
  final String homeroute;
  final UserData user;
  const SignUpDialog({
    super.key,
    required this.user,
    required this.title,
    required this.icon,
    required this.homeroute,
  });

  @override
  State<SignUpDialog> createState() => _SignUpDialogState();
}

class _SignUpDialogState extends State<SignUpDialog> {
  final TextEditingController myEmailController = TextEditingController();
  final TextEditingController myPhoneController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool submit = false;
  bool clearEmail = false;
  bool clearPhone = false;
  late UserData newUser;
  @override
  void dispose() {
    myEmailController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    newUser = widget.user;
    widget.user.email != '' ? myEmailController.text = widget.user.email : null;
    widget.user.mobno != '' ? myEmailController.text = widget.user.mobno : null;
    myEmailController.addListener(() {
      setState(() {
        clearEmail = myEmailController.text.isNotEmpty;
        submit = myEmailController.text.trim().isNotEmpty &&
            myPhoneController.text.trim().isNotEmpty;
      });
    });
    myPhoneController.addListener(() {
      setState(() {
        clearPhone = myPhoneController.text.isNotEmpty;
        submit = myEmailController.text.trim().isNotEmpty &&
            myPhoneController.text.trim().isNotEmpty;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(widget.user.rollno);
    // debugPrint(widget.user.name);
    // debugPrint(widget.user.email);
    // debugPrint(widget.user.gender);
    // debugPrint(widget.user.clg);
    // debugPrint(widget.user.password);
    // debugPrint(widget.user.mobno);
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: isDark ? kGrey40 : kLBlack10,
      surfaceTintColor: isDark ? kGrey40 : kLBlack10,
      title: Row(
        children: [
          const FittedBox(
            child: Icon(
              MdiIcons.accountDetails,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Verify Details',
            style:
                AdaptiveTheme.of(context).theme.textTheme.bodyLarge!.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
          ),
        ],
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              "Verify or update your email and phone number.",
              style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 10),
            Form(
              key: _formkey,
              child: Container(
                constraints: BoxConstraints(maxWidth: 300.w),
                //height: 44,
                child: Column(
                  children: [
                    DialogTextFormField(
                      validator: (value) {
                        return validateEmail(value);
                      },
                      controller: myEmailController,
                      keyboardType: TextInputType.emailAddress,
                      icon: Icons.alternate_email_outlined,
                      hintText: "Email",
                      clear: clearEmail,
                      maxLines: 1,
                    ),
                    const SizedBox(height: 10),
                    DialogTextFormField(
                      validator: (value) {
                        return validatePhone(value);
                      },
                      controller: myPhoneController,
                      keyboardType: TextInputType.phone,
                      icon: Icons.numbers,
                      hintText: "Phone",
                      clear: clearPhone,
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      contentPadding: const EdgeInsets.fromLTRB(24, 16, 24, 4),
      actions: [
        buildCancelButton(context),
        buildActiveButton(
            context,
            submit,
            "Confirm",
            submit
                ? () {
                    if (_formkey.currentState!.validate()) {
                      debugPrint("Print");
                      Navigator.of(context).pop();
                      newUser.email = myEmailController.text;
                      newUser.mobno = myPhoneController.text;
                      OTPArguments args = OTPArguments(
                        null,
                        widget.title,
                        widget.icon,
                        CreatePasswordPage(
                          title: widget.title,
                          icon: widget.icon,
                          homeroute: widget.homeroute,
                          user: newUser,
                        ),
                        widget.homeroute,
                        newUser,
                      );
                      if (mounted) {
                        Navigator.pushNamed(
                          context,
                          OtpScreen.routeName,
                          arguments: args,
                        );
                      }
                    } else {
                      debugPrint("Error");
                    }
                  }
                : null),
      ],
      actionsPadding: const EdgeInsets.fromLTRB(24, 4, 24, 16),
    );
  }

  String? validateEmail(String? value) {
    if (value!.isWhitespace()) {
      return "Email can't be empty";
    } else if (value.isValidEmail()) {
      return null;
    } else {
      return "Not a valid Email";
    }
  }

  String? validatePhone(String? value) {
    if (value!.isWhitespace()) {
      return "Phone can't be empty";
    } else if (value.isValidMobile()) {
      return null;
    } else {
      return "Not a valid Phone";
    }
  }
}
