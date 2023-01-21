import 'package:flutter/material.dart';
import '../../args_class.dart';
import 'reset_password.dart';
import '../../constants.dart';
import '../components/customfields/custommultifield.dart';
import '../components/customfields/customsubmitbutton.dart';
import '../components/otp_screen.dart';

class ForgotModalForm extends StatefulWidget {
  const ForgotModalForm({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
    required this.homeroute,
    this.index,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  final String homeroute;
  final int? index;
  @override
  State<ForgotModalForm> createState() => ForgotModalFormState();
}

class ForgotModalFormState extends State<ForgotModalForm> {
  ForgotModalFormState();
  final _formKey = GlobalKey<FormState>();

  final myTextFieldController = TextEditingController();

  @override
  void dispose() {
    myTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.height * 0.06,
              child: Center(
                child: Container(
                  height: 5,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.025,
            ),
            const FittedBox(
              child: Text(
                "Forgot Password ?",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: kTextColor,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                  fontSize: 28,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            FittedBox(
              child: Text(
                "Enter registered Email ID / Mobile Number.",
                style: TextStyle(
                  color: kTextColor.withOpacity(0.7),
                  letterSpacing: 0.6,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
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
              height: size.height * 0.010,
            ),
            CustomSubmitButton(
              size: size,
              bgcolor: kPrimaryColor,
              msg: "Send Code",
              fsize: 18,
              width: 2,
              press: () {
                WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print("____Forgot Form Valid!");

                  UserData user = UserData(
                    myTextFieldController.text,
                    '0000000000', //Todo UserData
                    '2021000000', //Todo UserData
                    '**********', //Todo UserData
                    '00-00-0000', //Todo UserData
                  );

                  OTPArguments args = OTPArguments(
                    widget.fgcolor,
                    widget.title,
                    widget.icon,
                    ResetPasswordPage(
                      fgcolor: widget.fgcolor,
                      title: widget.title,
                      icon: widget.icon,
                      homeroute: widget.homeroute,
                      user: user,
                    ),
                    widget.homeroute,
                    user,
                  );
                  Navigator.pushNamed(
                    context,
                    OtpScreen.routeName,
                    arguments: args,
                  );
                  print(myTextFieldController.text);
                } else {
                  print("____Forgot Form Error!");
                }
              }, //Todo_Navigation
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
          ],
        ),
      ),
    );
  }
}
