import 'package:flutter/material.dart';
import 'package:hitch_handler/screens/components/customfields/fieldlabel.dart';
import '../components/customfields/custommessagefield.dart';
import '../components/customfields/customtitlefield.dart';
import '../../constants.dart';
import '../components/customfields/customsubmitbutton.dart';

class AddForm extends StatefulWidget {
  const AddForm({
    super.key,
  });

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  String initialValue = "";

  final myTitleFieldController = TextEditingController();
  final myMsgFieldController = TextEditingController();

  @override
  void dispose() {
    myTitleFieldController.dispose();
    myMsgFieldController.dispose();
    super.dispose();
  }

  bool _anon = false;
  bool? _dept = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTitleField(
              fgcolor: kPrimaryColor,
              controller: myTitleFieldController,
              hintText: "Suitable title ",
              title: "Title",
              length: 50,
            ),
            CustomMessageField(
              fgcolor: kPrimaryColor,
              controller: myMsgFieldController,
              hintText: "Explain your problem briefly ",
              title: "Description",
              length: 250,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FieldLabel(
                    fgcolor: kPrimaryColor,
                    title: "More Details",
                    bgcolor: kBlack15,
                    tooltip: 'tooltip'),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  decoration: const BoxDecoration(
                      color: kGrey50,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 3),
                          color: kBlack20,
                        )
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SwitchListTile(
                        title: Text(
                          'Do you want this to be an Anonymous entry?',
                          style: TextStyle(
                            fontSize: 15,
                            color: kTextColor.withOpacity(0.8),
                          ),
                        ),
                        enableFeedback: true,
                        activeColor: kPrimaryColor,
                        activeTrackColor: kBlack20,
                        inactiveThumbColor: kGrey90,
                        inactiveTrackColor: kBlack20,
                        tileColor: kGrey40,
                        value: _anon,
                        onChanged: (bool value) {
                          setState(() {
                            _anon = value;
                          });
                        },
                      ),
                      const Divider(
                        thickness: 1.0,
                        color: kBlack10,
                      ),
                      CheckboxListTile(
                        title: Text(
                          'Is this a problem in your department?',
                          style: TextStyle(
                            fontSize: 15,
                            color: kTextColor.withOpacity(0.8),
                          ),
                        ),
                        side: const BorderSide(
                          color: kBlack10,
                          width: 1.6,
                        ),
                        checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        enableFeedback: true,
                        activeColor: kPrimaryColor,
                        checkColor: kBlack10,
                        value: _dept,
                        onChanged: (bool? value) {
                          setState(() {
                            _dept = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            CustomSubmitButton(
              size: size,
              bgcolor: kPrimaryColor,
              msg: "Submit",
              fsize: 18,
              width: 0.15,
              press: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
                  print("________");
                  print(initialValue); //Todo
                } else {
                  print(">>>>>ERRORS!");
                }
              }, //Todo_Navigation
            ),
          ],
        ),
      ),
    );
  }
}
