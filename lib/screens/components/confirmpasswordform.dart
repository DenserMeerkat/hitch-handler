// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// Project imports:
import '../../args_class.dart';
import '../../constants.dart';
import '../../resources/auth_methods.dart';
import '../common/validpassword.dart';
import 'customfields/customconfirmpassword.dart';
import 'customfields/customsubmitbutton.dart';

class ConfirmPasswordBody extends StatefulWidget {
  final Color fgcolor;
  final String title;
  final String subtitle;
  final UserData user;
  final int authentication;
  const ConfirmPasswordBody({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.subtitle,
    required this.user,
    required this.authentication,
  });

  @override
  State<ConfirmPasswordBody> createState() => _ConfirmPasswordBodyState();
}

class _ConfirmPasswordBodyState extends State<ConfirmPasswordBody> {
  _ConfirmPasswordBodyState();
  final ScrollController scroll = ScrollController();
  final myPassFieldController = TextEditingController();

  @override
  void dispose() {
    scroll.dispose();
    myPassFieldController.dispose();
    super.dispose();
  }

  void scrollDown(double height) {
    Future.delayed(const Duration(milliseconds: 200), () {
      scroll.animateTo(scroll.position.maxScrollExtent + height,
          duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
    });
  }

  Future<String> performAuthentication(UserData user) async {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    final scaffoldContext = ScaffoldMessenger.of(context);
    String res = "UnknownError";
    if (widget.authentication == 1) {
      res = await AuthMethods().signUpUser(
        name: user.name,
        email: user.email,
        mobno: user.mobno,
        rollno: user.rollno,
        password: user.password,
        dob: user.dob,
        domain: '',
        userType: 'user',
      );
      if (res != "success") {
        scaffoldContext.clearSnackBars();
        final snackBar = SnackBar(
          content: Text(
            res,
            style: TextStyle(
              color: isDark ? kTextColor : kLTextColor,
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: isDark ? kGrey40 : kLBlack10,
        );
        scaffoldContext.showSnackBar(snackBar);
      }
    } else if (widget.authentication == 2) {
      res = "Not yet done";
    }
    return res;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size; // Available screen size
    return Container(
      width: size.width,
      color: isDark ? kGrey30 : kLGrey30,
      child: SingleChildScrollView(
        controller: scroll,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: 10.h,
                  left: 30.w,
                  right: 30.w,
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20.h,
                    ),
                    FittedBox(
                      child: Text(
                        widget.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: isDark ? kTextColor : kLTextColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                          fontSize: 32,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    FittedBox(
                      child: Text(
                        widget.subtitle,
                        style: TextStyle(
                          color: isDark
                              ? kTextColor.withOpacity(0.7)
                              : kLTextColor,
                          letterSpacing: 0.6,
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    CustomConfirmPasswordField(
                      fgcolor: widget.fgcolor,
                      controller: myPassFieldController,
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    CustomSubmitButton(
                      size: size,
                      bgcolor: kPrimaryColor,
                      msg: "Continue",
                      press: () async {
                        WidgetsBinding.instance.focusManager.primaryFocus
                            ?.unfocus();
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          debugPrint("___________________");
                          debugPrint("${_formKey.currentState!.validate()}");
                          widget.user.password = myPassFieldController.text;
                          String res = await performAuthentication(widget.user);
                          if (res == "success") {}
                          debugPrint(res);
                        } else {
                          debugPrint(">>>>>ERRORS!");
                        }
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 15.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: isDark ? kBackgroundColor : kLBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0, -2),
                      color: isDark ? kBlack15 : kLGrey50,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
                child: ValidPassExpansionTile(
                  fgcolor: widget.fgcolor,
                  scroll: (value) {
                    if (value == true) {
                      scrollDown(40.h);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
