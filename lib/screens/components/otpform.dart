import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import '../../constants.dart';
import 'customsubmitbutton.dart';

class OtpForm extends StatefulWidget {
  const OtpForm({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
    required this.nextPage,
    this.index,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  final int? index;
  final Widget nextPage;
  @override
  State<OtpForm> createState() => OtpFormState(fgcolor, title, icon, nextPage);
}

class OtpFormState extends State<OtpForm> {
  OtpFormState(
    this.fgcolor,
    this.title,
    this.icon,
    this.nextPage,
  );
  final Color fgcolor;
  final String title;
  final IconData icon;
  final Widget nextPage;
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: _formKey,
      child: Column(
        children: [
          OTPTextField(
            length: 4,
            width: size.width,
            spaceBetween: 0,
            fieldWidth: 50,
            contentPadding:
                EdgeInsets.symmetric(vertical: 14.0, horizontal: 4.0),
            otpFieldStyle: OtpFieldStyle(
              backgroundColor: const Color.fromRGBO(20, 20, 20, 1),
              borderColor: kTextColor.withOpacity(0.2),
              focusBorderColor: fgcolor,
              disabledBorderColor: Colors.grey,
              enabledBorderColor: kTextColor.withOpacity(0.2),
              errorBorderColor: Colors.red,
            ),
            style: const TextStyle(fontSize: 30),
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
            height: size.height * 0.06,
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
                press: () {
                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    print("___________________");
                    print(_formKey.currentState!.validate());
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return nextPage;
                      }),
                    );
                  } else {
                    print(">>>>>ERRORS!");
                  }
                }, //Todo_Navigation
              ),
            ],
          ),
        ],
      ),
    );
  }
}
