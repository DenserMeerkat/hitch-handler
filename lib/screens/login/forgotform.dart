import 'package:flutter/material.dart';
import '../../constants.dart';
import '../components/customtextfield.dart';
import '../components/customsubmitbutton.dart';
import 'otp_screen.dart';

class ForgotForm extends StatefulWidget {
  const ForgotForm({
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
  State<ForgotForm> createState() => ForgotFormState(fgcolor, title, icon);
}

class ForgotFormState extends State<ForgotForm> {
  ForgotFormState(this.fgcolor, this.title, this.icon);
  final Color fgcolor;
  final String title;
  final IconData icon;
  final _formOTPKey = GlobalKey<FormState>();
  final List<String> errors = [];

  late FocusNode pin2FocusNode;
  late FocusNode pin3FocusNode;
  late FocusNode pin4FocusNode;

  @override
  void initState() {
    super.initState();
    pin2FocusNode = FocusNode();
    pin3FocusNode = FocusNode();
    pin4FocusNode = FocusNode();
  }

  void nextField({required String value, required FocusNode focusNode}) {
    if (value.length == 1) {
      focusNode.requestFocus();
    }
  }

  @override
  void dispose() {
    pin2FocusNode.dispose();
    pin3FocusNode.dispose();
    pin4FocusNode.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formOTPKey,
      child: Column(
        children: [
          SizedBox(
            height: size.height * 0.05,
          ),
          CustomTextField(
            fgcolor: fgcolor,
            index: 2,
          ),
          SizedBox(
            height: size.height * 0.05,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          CustomSubmitButton(
            size: size,
            bgcolor: kPrimaryColor,
            msg: "Send Code",
            fsize: 18,
            width: 0.08,
            press: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return OtpPage(
                    fgcolor: fgcolor,
                    title: title,
                    icon: icon,
                  );
                }),
              );
            },
          ),
        ],
      ),
    );
  }
}
