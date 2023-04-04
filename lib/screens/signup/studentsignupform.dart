import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hitch_handler/screens/user_home/notifiers.dart';
import '../../args_class.dart';
import '../components/customfields/customdatepickfield.dart';
import '../components/utils/customdialog.dart';
import 'create_password.dart';
import '../common/otp_screen.dart';
import '../../constants.dart';
import '../components/customfields/customsubmitbutton.dart';
import '../components/customfields/custommultifield.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
                'ID Number',
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
          OTPArguments args = OTPArguments(
            widget.fgcolor,
            widget.title,
            widget.icon,
            CreatePasswordPage(
              fgcolor: widget.fgcolor,
              title: widget.title,
              icon: widget.icon,
              homeroute: widget.homeroute,
              user: user,
            ),
            widget.homeroute,
            user,
          );
          if (mounted) {
            Navigator.pushNamed(
              context,
              OtpScreen.routeName,
              arguments: args,
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).removeCurrentSnackBar();
            final snackBar = showCustomSnackBar(
                context, "Invalid Credentials", () {},
                backgroundColor: isDark ? kGrey40 : kLBlack10,
                margin: EdgeInsets.symmetric(horizontal: 70.w, vertical: 10),
                borderColor: AdaptiveTheme.of(context).theme.colorScheme.error,
                textColor: AdaptiveTheme.of(context).theme.colorScheme.error,
                icon: Icon(
                  Icons.error_outline_rounded,
                  color: AdaptiveTheme.of(context).theme.colorScheme.error,
                ));
            ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then(
                (value) => ScaffoldMessenger.of(context).clearSnackBars());
            debugPrint("____SignUp Form Error!");
          }
        }
      } catch (err) {
        debugPrint(err.toString());
      }
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      final snackBar =
          showCustomSnackBar(context, "One or more Fields have Errors", () {},
              backgroundColor: isDark ? kGrey40 : kLBlack10,
              borderColor: AdaptiveTheme.of(context).theme.colorScheme.error,
              textColor: AdaptiveTheme.of(context).theme.colorScheme.error,
              icon: Icon(
                Icons.error_outline_rounded,
                color: AdaptiveTheme.of(context).theme.colorScheme.error,
              ));
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar)
          .closed
          .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
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
