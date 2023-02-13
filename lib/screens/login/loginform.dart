import 'package:flutter/material.dart';
import '../../resources/auth_methods.dart';
import '../components/utils/customdialog.dart';
import '../user_home/notifiers.dart';
import 'forgotmodal.dart';
import '../user_home/main_app.dart';
import '../../constants.dart';
import '../components/customfields/customsubmitbutton.dart';
import '../components/customfields/custommultifield.dart';
import '../components/customfields/custompasswordfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
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
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  _LoginFormState();

  final _formKey = GlobalKey<FormState>();

  void showBottomSheet() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    showModalBottomSheet(
      backgroundColor: isDark ? kGrey30 : kLGrey30,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
      context: context,
      builder: (context) {
        return Padding(
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

  final myTextFieldController = TextEditingController();
  final myPassFieldController = TextEditingController();
  bool isLoading = false;

  String email = "email";

  @override
  void dispose() {
    myTextFieldController.dispose();
    myPassFieldController.dispose();
    super.dispose();
  }

  void loginAuthentication(String email, String pass) async {
    String res = "UnknownError";
    final navigator = Navigator.of(context);
    final scaffoldContext = ScaffoldMessenger.of(context);
    setState(() {
      isLoading = true;
      IsLoading(isLoading).dispatch(context);
    });
    res = await AuthMethods().loginUser(
      email: email,
      password: myPassFieldController.text,
    );
    if (res == "success") {
      debugPrint(res);
      navigator.pushNamed(
        AppScreen.routeName,
      );
    } else {
      final snackBar = SnackBar(
        content: Text(res.toString()),
      );
      scaffoldContext
          .showSnackBar(snackBar)
          .closed
          .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
      debugPrint("Error in Login");
    }
    setState(() {
      isLoading = false;
      IsLoading(isLoading).dispatch(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
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
            SizedBox(
              height: size.height * 0.01,
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
                        borderRadius: BorderRadius.circular(10.0),
                      );
                    }),
                    padding: MaterialStateProperty.resolveWith((states) {
                      return const EdgeInsets.symmetric(
                        horizontal: 12,
                      );
                    }),
                  ),
                  child: Text(
                    "Forgot Password ?",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      letterSpacing: 0.6,
                      color: isDark ? widget.fgcolor : kLTextColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            CustomSubmitButton(
              size: size,
              bgcolor: isDark ? kPrimaryColor : kLPrimaryColor,
              msg: "Continue",
              fsize: 20,
              width: 2.5,
              press: () {
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  debugPrint("___________________");
                  debugPrint("${_formKey.currentState!.validate()}");

                  email = myTextFieldController.text;
                  loginAuthentication(email, myPassFieldController.text);
                } else {
                  final snackBar = showCustomSnackBar(
                    context,
                    "One or more Fields have Errors",
                    "Ok",
                    () {},
                  );
                  ScaffoldMessenger.of(context)
                      .showSnackBar(snackBar)
                      .closed
                      .then((value) =>
                          ScaffoldMessenger.of(context).clearSnackBars());
                  debugPrint(">>>>>ERRORS!");
                }
              }, //Todo_Navigation
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
          ],
        ),
      ),
    );
  }
}
