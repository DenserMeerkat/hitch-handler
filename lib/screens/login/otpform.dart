import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import '../../constants.dart';
import '../components/customsubmitbutton.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
    this.index,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  final int? index;
  @override
  State<OtpForm> createState() => OtpFormState(fgcolor, title, icon);
}

class OtpFormState extends State<OtpForm> {
  OtpFormState(this.fgcolor, this.title, this.icon);
  final Color fgcolor;
  final String title;
  final IconData icon;
  final _formOTPKey = GlobalKey<FormState>();
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formOTPKey,
      child: Column(
        children: [
          OTPTextField(
            length: 4,
            width: size.width,
            spaceBetween: 0,
            fieldWidth: 50,
            otpFieldStyle: OtpFieldStyle(
              backgroundColor: Color.fromRGBO(25, 25, 25, 1),
              borderColor: fgcolor.withOpacity(0.3),
              focusBorderColor: fgcolor,
              disabledBorderColor: Colors.grey,
              enabledBorderColor: fgcolor.withOpacity(0.2),
              errorBorderColor: Colors.red,
            ),
            style: const TextStyle(fontSize: 24),
            textFieldAlignment: MainAxisAlignment.spaceAround,
            outlineBorderRadius: 5.0,
            fieldStyle: FieldStyle.box,
            cursorColor: fgcolor,
            onChanged: (value) {},
            onCompleted: (pin) {
              print("Completed: " + pin); //Todo
            },
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomSubmitButton(
                size: size,
                bgcolor: kSecButtonColor,
                msg: "Resend",
                fsize: 18,
                width: 0.08,
                press: () {}, //Todo
              ),
              CustomSubmitButton(
                size: size,
                bgcolor: kPrimaryColor,
                msg: "Submit",
                fsize: 18,
                width: 0.08,
                press: () {}, //Todo
              ),
            ],
          ),
        ],
      ),
    );
  }
}
