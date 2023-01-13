import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'forgotmodal.dart';
import '../user_home/app.dart';
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
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    showModalBottomSheet(
        backgroundColor: kGrey30,
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
              ));
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
                      color: widget.fgcolor,
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
                if (!_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  print("___________________");
                  print(_formKey.currentState!.validate());

                  Navigator.pushNamed(
                    context,
                    AppScreen.routeName,
                  );

                  print(myTextFieldController.text);
                  print(myPassFieldController.text);
                } else {
                  showSimpleNotification(
                      Container(
                        decoration: BoxDecoration(
                            color: kBackgroundColor,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: kErrorColor, width: 2)),
                        child: const ListTile(
                          leading: Icon(
                            Icons.error_outline,
                            size: 25,
                          ),
                          title: Text(
                            "One or more fields have Errors",
                          ),
                        ),
                      ),
                      background: Colors.transparent,
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                      position: NotificationPosition.top);
                  print(">>>>>ERRORS!");
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
