import 'package:flutter/material.dart';
import '../../constants.dart';
import 'customfields/customconfirmpassword.dart';
import 'customfields/customsubmitbutton.dart';
import 'validpassword.dart';

class ConfirmPasswordBody extends StatefulWidget {
  final Color fgcolor;
  final String title;
  final String subtitle;
  final Function() press;
  const ConfirmPasswordBody({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.press,
    required this.subtitle,
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

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return Container(
      height: size.height * 0.78,
      width: size.width,
      color: kGrey30,
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
                    style: const TextStyle(
                      color: kTextColor,
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
                      color: kTextColor.withOpacity(0.7),
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
                  press: () {
                    WidgetsBinding.instance.focusManager.primaryFocus
                        ?.unfocus();
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      print("___________________");
                      print(_formKey.currentState!.validate());
                      widget.press();
                    } else {
                      print(">>>>>ERRORS!");
                    }
                    print(myPassFieldController.text);
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