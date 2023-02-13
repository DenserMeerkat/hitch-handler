import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import '../../constants.dart';
import 'customfields/customsubmitbutton.dart';

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
  State<OtpForm> createState() => OtpFormState();
}

class OtpFormState extends State<OtpForm> {
  OtpFormState();
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String otp = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OTPTextField(
              length: 4,
              width: size.width,
              spaceBetween: 0,
              fieldWidth: 50,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 14.0, horizontal: 4.0),
              otpFieldStyle: OtpFieldStyle(
                backgroundColor: isDark ? kBlack20 : kLGrey40,
                borderColor: isDark ? kTextColor.withOpacity(0.2) : kLTextColor,
                focusBorderColor: widget.fgcolor,
                disabledBorderColor: Colors.grey,
                enabledBorderColor:
                    isDark ? kTextColor.withOpacity(0.2) : kLTextColor,
                errorBorderColor: Colors.red,
              ),
              style: const TextStyle(fontSize: 30),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              outlineBorderRadius: 5.0,
              fieldStyle: FieldStyle.box,
              cursorColor: widget.fgcolor,
              onChanged: (value) {},
              onCompleted: (pin) {
                print("Completed: " + pin); //Todo
                otp = pin;
              },
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            Row(
              children: [
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: CustomSubmitButton(
                    size: size,
                    bgcolor: kSecButtonColor,
                    msg: "Resend",
                    fsize: 20,
                    press: () {}, //Todo
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: CustomSubmitButton(
                    size: size,
                    bgcolor: kPrimaryColor,
                    msg: "Submit",
                    fsize: 20,
                    press: () {
                      WidgetsBinding.instance.focusManager.primaryFocus
                          ?.unfocus();
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        print("___________________");
                        print(_formKey.currentState!.validate());
                        ScaffoldMessenger.of(context).removeCurrentSnackBar();
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return widget.nextPage;
                          }),
                        );
                        print("OTP : " + otp);
                      } else {
                        print(">>>>>ERRORS!");
                      }
                    }, //Todo_Navigation
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
