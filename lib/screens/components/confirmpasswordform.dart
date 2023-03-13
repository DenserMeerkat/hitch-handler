import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'utils/customdialog.dart';
import '../../args_class.dart';
import '../../resources/auth_methods.dart';
import '../../constants.dart';
import 'customfields/customconfirmpassword.dart';
import 'customfields/customsubmitbutton.dart';
import 'utils/dialogcont.dart';
import 'validpassword.dart';

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
    final navigator = Navigator.of(context);
    final BuildContext contexT = context;
    String res = "UnknownError";
    if (widget.authentication == 1) {
      res = await AuthMethods().signUpUser(
        email: user.email,
        mobno: user.mobno,
        rollno: user.rollno,
        password: user.password,
        dob: user.dob,
        domain: '',
        userType: 'user',
      );
      if (res != "success") {
        showCustomSnackBar(contexT, res, "Ok", () {
          navigator.pop();
        });
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
                    SizedBox(
                      height: 50.h,
                    ),
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
                      height: 42.h,
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: isDark ? kBackgroundColor : kLBackgroundColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, -2),
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
            ],
          ),
        ),
      ),
    );
  }
}
