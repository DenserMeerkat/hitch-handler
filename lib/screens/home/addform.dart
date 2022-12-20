import 'package:flutter/material.dart';
import '../../string_extensions.dart';

import '../../constants.dart';
import '../components/customsubmitbutton.dart';

class AddForm extends StatefulWidget {
  const AddForm({
    super.key,
  });

  @override
  State<AddForm> createState() => _AddFormState();
}

final _formKey = GlobalKey<FormState>();
String initialValue = "";

class _AddFormState extends State<AddForm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.8,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              validator: (value) {
                if (value == null || value.isWhitespace()) {
                  return "Field can't be Empty";
                } else {
                  return null;
                }
              },
              initialValue: initialValue,
              style: const TextStyle(
                fontSize: 16.0,
              ),
              cursorColor: kPrimaryColor,
              cursorHeight: 20.0,
              textInputAction: TextInputAction.next,
              onSaved: (value) {
                setState(() {
                  initialValue = value!;
                });
                FocusScope.of(context).nextFocus();
              },
              onChanged: (value) {
                setState(() {
                  initialValue = value;
                });
              },
              onFieldSubmitted: (value) {
                setState(() {
                  initialValue = value;
                });
                //FocusScope.of(context).nextFocus();
              },
              minLines: 5,
              maxLines: 5,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Color.fromRGBO(50, 50, 50, 1),
                helperText: '',
                errorStyle: TextStyle(color: kErrorColor),
                hintText:
                    "Enter your Message here", //_________________HINT TEXT____________
                hintStyle: TextStyle(
                  fontSize: 15.0,
                  color: Color.fromRGBO(90, 90, 90, 1),
                  letterSpacing: 1,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.never,
                floatingLabelAlignment: FloatingLabelAlignment.start,
              ),
              keyboardType: TextInputType.multiline,
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
