import 'package:flutter/material.dart';
import 'forgotmodal.dart';
import '../home/app.dart';
import '../../constants.dart';
import '../components/customsubmitbutton.dart';
import '../components/customtextfield.dart';
import '../components/custompasswordfield.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    super.key,
    required this.fgcolor,
    required this.title,
    required this.icon,
  });
  final Color fgcolor;
  final String title;
  final IconData icon;
  @override
  State<LoginForm> createState() => _LoginFormState(fgcolor, title, icon);
}

class _LoginFormState extends State<LoginForm> {
  _LoginFormState(this.fgcolor, this.title, this.icon);
  final Color fgcolor;
  final String title;
  final IconData icon;
  final _formKey = GlobalKey<FormState>();

  void showBottomSheet() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    showModalBottomSheet(
        backgroundColor: const Color.fromRGBO(30, 30, 30, 1),
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        context: context,
        builder: (context) {
          return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child:
                  ForgotModalForm(fgcolor: fgcolor, title: title, icon: icon));
        });
  }

  final myTextFieldController = TextEditingController();
  final myPassFieldController = TextEditingController();

  @override
  void dispose() {
    myTextFieldController.dispose();
    myPassFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextField(
            current: 2,
            controller: myTextFieldController,
            fgcolor: fgcolor,
          ),
          SizedBox(
            height: size.height * 0.015,
          ),
          CustomPasswordField(
            controller: myPassFieldController,
            onSubmit: (value) {},
            onChange: (value) {},
            fgcolor: fgcolor,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () {
                  showBottomSheet();
                },
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.resolveWith((states) {
                    return Colors.white.withOpacity(0.08);
                  }),
                  shape: MaterialStateProperty.resolveWith((states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
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
                    color: fgcolor,
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
            bgcolor: kPrimaryColor,
            msg: "Continue",
            fsize: 18,
            width: 0.15,
            press: () {
              WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                print("___________________");
                print(_formKey.currentState!.validate());
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const StudentHomeScreen();
                  }),
                );

                print(myTextFieldController.text);
                print(myPassFieldController.text);
              } else {
                print(">>>>>ERRORS!");
              }
            }, //Todo_Navigation
          ),
        ],
      ),
    );
  }
}
