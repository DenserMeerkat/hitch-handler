import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var inputDecoration = InputDecoration(
      enabledBorder: outlineInputBorder(fgcolor.withOpacity(0.7), 1.0, 10.0),
      focusedBorder: outlineInputBorder(fgcolor, 2.0, 10.0),
      border: outlineInputBorder(fgcolor, 1.0, 10.0),
    );
    return Form(
      key: _formOTPKey,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: const Color.fromRGBO(30, 30, 30, 1),
                    borderRadius: BorderRadius.circular(10.0)),
                width: size.width * 0.175,
                child: TextFormField(
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                  autofocus: true,
                  cursorColor: kTextColor,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration,
                  onChanged: (value) {
                    nextField(value: value, focusNode: pin2FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: size.width * 0.175,
                child: TextFormField(
                  focusNode: pin2FocusNode,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                  cursorColor: kTextColor,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration,
                  onChanged: (value) {
                    nextField(value: value, focusNode: pin3FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: size.width * 0.175,
                child: TextFormField(
                  focusNode: pin3FocusNode,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                  cursorColor: kTextColor,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration,
                  onChanged: (value) {
                    nextField(value: value, focusNode: pin4FocusNode);
                  },
                ),
              ),
              SizedBox(
                width: size.width * 0.175,
                child: TextFormField(
                  focusNode: pin4FocusNode,
                  style: const TextStyle(
                    fontSize: 24,
                  ),
                  cursorColor: kTextColor,
                  textAlign: TextAlign.center,
                  keyboardType: TextInputType.number,
                  decoration: inputDecoration,
                  onChanged: (value) => {},
                ),
              ),
            ],
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

  OutlineInputBorder outlineInputBorder(
      Color color, double width, double radius) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: BorderSide(
        width: width,
        color: color,
      ),
    );
  }
}
