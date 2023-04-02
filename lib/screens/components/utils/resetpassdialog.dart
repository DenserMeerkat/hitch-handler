import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:hitch_handler/resources/auth_methods.dart';
import 'package:hitch_handler/string_extensions.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';
import 'package:provider/provider.dart';
import 'package:hitch_handler/models/user.dart' as model;
import 'package:hitch_handler/providers/user_provider.dart';

class ResetPasswordDialog extends StatefulWidget {
  const ResetPasswordDialog({
    super.key,
  });

  @override
  State<ResetPasswordDialog> createState() => _ResetPasswordDialogState();
}

class _ResetPasswordDialogState extends State<ResetPasswordDialog> {
  final TextEditingController myTextFieldController = TextEditingController();

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  bool submit = false;
  bool clear = false;

  @override
  void dispose() {
    myTextFieldController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    model.User? user =
        Provider.of<UserProvider>(context, listen: false).getUser;
    myTextFieldController.addListener(() {
      setState(() {
        clear = myTextFieldController.text.isNotEmpty;
        submit = myTextFieldController.text.trim() == user.email;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    OutlineInputBorder border(Color color) {
      OutlineInputBorder outlineInputBorder = OutlineInputBorder(
        borderSide: BorderSide(
          color: color,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10.r),
      );
      return outlineInputBorder;
    }

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: isDark ? kGrey40 : kLBlack10,
      surfaceTintColor: isDark ? kGrey40 : kLBlack10,
      title: Row(
        children: [
          const FittedBox(
            child: Icon(
              MdiIcons.lockReset,
              color: kPrimaryColor,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            'Rest Password',
            style:
                AdaptiveTheme.of(context).theme.textTheme.bodyLarge!.copyWith(
                      color: kPrimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
          ),
        ],
      ),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          Text(
            "An email will be sent with instructions to reset your password.",
            style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
          ),
          Text(
            "Please type your email to confirm.",
            style: AdaptiveTheme.of(context).theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 10),
          Form(
            key: _formkey,
            child: Container(
              constraints: BoxConstraints(maxWidth: 270.w),
              //height: 44,
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                style: AdaptiveTheme.of(context).theme.textTheme.bodyMedium,
                validator: (value) {
                  return validateEmail(value);
                },
                controller: myTextFieldController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding:
                      const EdgeInsets.only(top: 4, bottom: 4, left: 16),
                  border: border(Colors.transparent),
                  focusedBorder: border(kPrimaryColor),
                  errorBorder:
                      border(AdaptiveTheme.of(context).theme.colorScheme.error),
                  enabledBorder: border(isDark ? kGrey70 : kLBlack20),
                  disabledBorder: border(Colors.transparent),
                  suffixIconColor: kPrimaryColor,
                  suffixIcon: clear
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              myTextFieldController.clear();
                            });
                          },
                          icon: const Icon(
                            Icons.clear,
                          ),
                        )
                      : const Icon(
                          Icons.alternate_email_outlined,
                        ),
                  hintText: "Email",
                  hintStyle: AdaptiveTheme.of(context)
                      .theme
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                        color: isDark
                            ? kTextColor.withOpacity(0.5)
                            : kLTextColor.withOpacity(0.5),
                      ),
                  fillColor: isDark ? kGrey50 : kLBlack15,
                  filled: true,
                ),
              ),
            ),
          ),
        ],
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
                      AuthMethods()
                          .passReset(myTextFieldController.text.trim());
                      debugPrint("Print");
                      Navigator.of(context).pop();
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
    model.User? user =
        Provider.of<UserProvider>(context, listen: false).getUser;
    if (value!.isWhitespace()) {
      return "Email can\t be empty";
    } else if (value == user.email) {
      return null;
    } else {
      return "Incorrect Email";
    }
  }
}
