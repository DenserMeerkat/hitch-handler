// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;

// Project imports:
import 'package:hitch_handler/args_class.dart';
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/screens/components/customfields/customdatepickfield.dart';
import 'package:hitch_handler/screens/components/customfields/custommultifield.dart';
import 'package:hitch_handler/screens/components/customfields/customsubmitbutton.dart';
import 'package:hitch_handler/screens/components/utils/signupdialog.dart';
import 'package:hitch_handler/screens/user_home/notifiers.dart';

class StudentSignupForm extends StatefulWidget {
  const StudentSignupForm({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
    required this.homeroute,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  final String homeroute;

  @override
  State<StudentSignupForm> createState() => _StudentSignupFormState();
}

class _StudentSignupFormState extends State<StudentSignupForm> {
  _StudentSignupFormState();
  final _formKey = GlobalKey<FormState>();

  final myTextFieldController = TextEditingController();
  final myDateFieldController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    myTextFieldController.dispose();
    myDateFieldController.dispose();
    super.dispose();
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
              //index: 3,
              hints: const [
                // 'E-mail',
                // 'Phone',
                'Roll Number',
              ],
              icons: const [
                // Icons.alternate_email,
                // Icons.call,
                Icons.badge,
              ],
              keyboards: const [
                // TextInputType.emailAddress,
                // TextInputType.phone,
                TextInputType.number,
              ],
            ),
            CustomDatePickField(
              controller: myDateFieldController,
              fgcolor: widget.fgcolor,
            ),
            SizedBox(
              height: 10.h,
            ),
            CustomSubmitButton(
              size: size,
              bgcolor: isDark ? kPrimaryColor : kLPrimaryColor,
              msg: "Continue",
              fsize: 20.sp,
              width: 2.5.w,
              press: () {
                handleSubmit(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void handleSubmit(
    BuildContext context,
  ) async {
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    final scaffoldContext = ScaffoldMessenger.of(context);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      debugPrint("____SignUp Form Valid!");
      try {
        UserData? user = await apiRequest(
          int.parse(myTextFieldController.text),
          myDateFieldController.text,
        );
        if (mounted) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
        if (user != null) {
          SignUpDialog dialog = SignUpDialog(
            title: widget.title,
            icon: widget.icon,
            homeroute: widget.homeroute,
            user: user,
          );
          if (!mounted) return;
          showDialog(
              context: context,
              barrierDismissible: false,
              barrierColor:
                  isDark ? kBlack10.withOpacity(0.8) : kGrey30.withOpacity(0.8),
              builder: (BuildContext context) {
                return dialog;
              });
        } else {
          if (mounted) {
            scaffoldContext.removeCurrentSnackBar();
            final snackBar = SnackBar(
              content: Text(
                "Invalid Credentials",
                style: TextStyle(
                  color: AdaptiveTheme.of(context).theme.colorScheme.error,
                ),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: isDark ? kGrey40 : kLBlack10,
            );
            scaffoldContext.showSnackBar(snackBar);

            debugPrint("____SignUp Form Error!");
          }
        }
      } catch (err) {
        debugPrint(err.toString());
      }
    } else {
      scaffoldContext.removeCurrentSnackBar();
      final snackBar = SnackBar(
        content: Text(
          "One or more Fields have Errors",
          style: TextStyle(
            color: AdaptiveTheme.of(context).theme.colorScheme.error,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? kGrey40 : kLBlack10,
      );
      scaffoldContext.showSnackBar(snackBar);

      debugPrint("____SignUp Form Error!");
    }
  }

  Future<UserData?> apiRequest(int roll, String dob) async {
    String fdob =
        '${dob.substring(6, 10)}-${dob.substring(3, 5)}-${dob.substring(0, 2)}';
    String url =
        'https://api.kurukshetraceg.org.in/api/services/check-if-cegian-by-roll-and-dob';
    setState(() {
      isLoading = true;
      IsLoading(isLoading).dispatch(context);
    });
    http.Response response = await http.post(
      Uri.parse(url),
      headers: {
        "content-type": "application/json",
        "x-service-application": "hitch-handler",
        "x-service-key": dotenv.env['API_KEY'] ?? "API_KEY not found",
      },
      body: jsonEncode({"roll": roll, "dob": fdob}),
    );
    setState(() {
      isLoading = false;
      IsLoading(isLoading).dispatch(context);
    });
    dynamic responseData = json.decode(response.body);
    if (responseData['message'] == 'CEGian found.') {
      UserData user = UserData(
        'CEG',
        responseData['name'],
        responseData['email'],
        responseData['phone'],
        responseData['roll'],
        '********',
        fdob,
        responseData['gender'],
      );
      return user;
    }
    return null;
  }
}
