// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/providers/user_provider.dart';
import 'package:hitch_handler/resources/auth_methods.dart';
import 'package:hitch_handler/screens/components/customfields/custommultifield.dart';
import 'package:hitch_handler/screens/components/customfields/custompasswordfield.dart';
import 'package:hitch_handler/screens/components/customfields/customsubmitbutton.dart';
import 'package:hitch_handler/screens/user_home/notifiers.dart';
import 'forgotmodal.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.userIndex,
    required this.fgcolor,
    required this.title,
    required this.icon,
    required this.homeroute,
  });
  final int userIndex;
  final Color fgcolor;
  final String title;
  final IconData icon;
  final String homeroute;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  _LoginFormState();

  final _formKey = GlobalKey<FormState>();

  void showBottomSheet() {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    showModalBottomSheet(
      backgroundColor: isDark ? kGrey30 : kLGrey30,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0.r)),
      ),
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ForgotModalForm(
            fgcolor: widget.fgcolor,
            title: widget.title,
            icon: widget.icon,
            homeroute: widget.homeroute,
          ),
        );
      },
    );
  }

  addData() async {
    UserProvider userProvider = Provider.of(context, listen: false);
    await userProvider.refreshUser();
  }

  final myTextFieldController = TextEditingController();
  final myPassFieldController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    myTextFieldController.dispose();
    myPassFieldController.dispose();
    super.dispose();
  }

  void loginAuthentication(String email, String pass) async {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    String res = "UnknownError";
    final scaffoldContext = ScaffoldMessenger.of(context);
    setState(() {
      isLoading = true;
      IsLoading(isLoading).dispatch(context);
    });
    res = await AuthMethods().loginUser(
      email: email,
      password: myPassFieldController.text,
    );
    setState(() {
      isLoading = false;
      IsLoading(isLoading).dispatch(context);
    });
    if (res == "success") {
      //addData();
      debugPrint(res);
    } else {
      if (context.mounted) {
        scaffoldContext.clearSnackBars();
        final snackBar = SnackBar(
          content: Text(
            res.toString(),
            style: TextStyle(color: isDark ? kTextColor : kLTextColor),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: isDark ? kGrey40 : kLBlack10,
        );
        scaffoldContext
            .showSnackBar(snackBar)
            .closed
            .then((value) => scaffoldContext.clearSnackBars());
      }
      debugPrint("Error in Login");
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomMultiField(
              controller: myTextFieldController,
              fgcolor: widget.fgcolor,
              index: 3,
              hints: const [
                'E-mail',
                'Phone',
                'ID Number',
              ],
              icons: const [
                Icons.alternate_email,
                Icons.call,
                Icons.badge,
              ],
              keyboards: const [
                TextInputType.emailAddress,
                TextInputType.phone,
                TextInputType.number,
              ],
            ),
            CustomPasswordField(
              controller: myPassFieldController,
              onSubmit: (value) {},
              onChange: (value) {},
              fgcolor: widget.fgcolor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).removeCurrentSnackBar();
                    showBottomSheet();
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.resolveWith((states) {
                      return isDark
                          ? kTextColor.withOpacity(0.08)
                          : kLTextColor.withOpacity(0.1);
                    }),
                    shape: MaterialStateProperty.resolveWith((states) {
                      return RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      );
                    }),
                    padding: MaterialStateProperty.resolveWith((states) {
                      return const EdgeInsets.fromLTRB(8, 4, 8, 2);
                    }),
                  ),
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.6.sp,
                      color: Colors.transparent,
                      shadows: [
                        Shadow(
                            color: isDark ? widget.fgcolor : kLTextColor,
                            offset: const Offset(0, -4))
                      ],
                      decoration: TextDecoration.underline,
                      decorationColor: isDark ? widget.fgcolor : kLTextColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.h,
            ),
            CustomSubmitButton(
              size: size,
              bgcolor: isDark ? kPrimaryColor : kLPrimaryColor,
              msg: "Continue",
              fsize: 20.sp,
              width: 2.5.w,
              press: () {
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  debugPrint("___________________");
                  debugPrint("${_formKey.currentState!.validate()}");

                  String email = myTextFieldController.text;
                  loginAuthentication(email, myPassFieldController.text);
                } else {
                  ScaffoldMessenger.of(context).clearSnackBars();
                  final scaffoldContext = ScaffoldMessenger.of(context);
                  final snackBar = SnackBar(
                    content: Text(
                      "One or more Fields have Errors",
                      style: TextStyle(
                        color:
                            AdaptiveTheme.of(context).theme.colorScheme.error,
                      ),
                    ),
                    behavior: SnackBarBehavior.floating,
                    backgroundColor: isDark ? kGrey40 : kLBlack10,
                  );
                  scaffoldContext.showSnackBar(snackBar);

                  debugPrint(">>>>>ERRORS!");
                }
              }, //Todo_Navigation
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }
}
