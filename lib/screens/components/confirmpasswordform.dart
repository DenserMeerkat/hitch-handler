import 'package:flutter/material.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;
    Size size = MediaQuery.of(context).size; // Available screen size
    return Container(
      height: size.height * 0.78,
      width: size.width,
      color: isDark ? kGrey30 : kLGrey30,
      child: SingleChildScrollView(
        controller: scroll,
        child: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.02,
              left: size.width * 0.1,
              right: size.width * 0.1,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height * 0.03,
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
                  height: size.height * 0.015,
                ),
                FittedBox(
                  child: Text(
                    widget.subtitle,
                    style: TextStyle(
                      color: isDark ? kTextColor.withOpacity(0.7) : kLTextColor,
                      letterSpacing: 0.6,
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.07,
                ),
                CustomConfirmPasswordField(
                  fgcolor: widget.fgcolor,
                  controller: myPassFieldController,
                ),
                SizedBox(
                  height: size.height * 0.05,
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
                  }, //Todo_Navigation,
                ),
                SizedBox(
                  height: size.height * 0.05,
                ),
                ValidPassExpansionTile(
                  fgcolor: widget.fgcolor,
                  scroll: (value) {
                    if (value == true) {
                      scrollDown(size.height * 0.01);
                    }
                  },
                ),
                SizedBox(
                  height: size.height * 0.04,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
