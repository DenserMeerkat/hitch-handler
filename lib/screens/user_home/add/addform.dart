import 'package:flutter/material.dart';
import '../../components/customfields/customdatetimefield.dart';
import '../../components/customfields/custommessagefield.dart';
import '../../components/customfields/customtitlefield.dart';
import '../../../constants.dart';
import '../../components/customfields/customsubmitbutton.dart';
import '../../components/customfields/customtypeaheadfield.dart';
import 'addimages.dart';
import 'addpostbrain.dart';
import 'moredetails.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddForm extends StatefulWidget {
  const AddForm({
    super.key,
  });

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();

  final myTitleFieldController = TextEditingController();
  String titleErrorText = '';
  final myMsgFieldController = TextEditingController();
  String msgErrorText = '';
  final myLocFieldController = TextEditingController();
  String locErrorText = '';
  final DateTime myDateController = DateTime.now();
  final TimeOfDay myTimeController = TimeOfDay.now();

  bool _addImageEnabled = UploadFileList.currLength() < 5 ? true : false;
  bool _viewImagesEnabled = UploadFileList.currLength() > 0 ? true : false;

  final bool _anon = false;
  final bool _dept = false;

  @override
  void dispose() {
    UploadFileList.clearFileList();
    myTitleFieldController.dispose();
    myMsgFieldController.dispose();
    myLocFieldController.dispose();
    CustomMessageField.hasError = false;
    CustomTitleField.hasError = false;
    CustomTypeAheadField.hasError = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
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
              errorText: titleErrorText,
            ),
            CustomMessageField(
              fgcolor: kPrimaryColor,
              controller: myMsgFieldController,
              hintText: "Explain your problem briefly ",
              title: "Description",
              length: 250,
              errorText: msgErrorText,
            ),
            AddImages(
                addImageEnabled: _addImageEnabled,
                viewImagesEnabled: _viewImagesEnabled),
            const SizedBox(
              height: 40,
            ),
            CustomDateTime(
              dateController: myDateController,
              timeController: myTimeController,
            ),
            const SizedBox(
              height: 36,
            ),
            CustomTypeAheadField(
              fgcolor: kPrimaryColor,
              controller: myLocFieldController,
              hintText: "Location",
              title: "Location",
              length: 50,
              errorText: locErrorText,
            ),
            MoreDetails(anon: _anon, dept: _dept),
            const SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 5,
                ),
                Expanded(
                  child: CustomSubmitButton(
                    size: size,
                    bgcolor: kSecButtonColor,
                    msg: "Clear",
                    fsize: 15,
                    width: 0.1,
                    press: () {
                      WidgetsBinding.instance.focusManager.primaryFocus
                          ?.unfocus();
                      debugPrint(UploadFileList.clearFileList());
                      setState(() {
                        myTitleFieldController.clear();
                        titleErrorText = '';
                        myMsgFieldController.clear();
                        msgErrorText = '';
                        myLocFieldController.clear();
                        locErrorText = '';
                        CustomMessageField.hasError = false;
                        CustomTitleField.hasError = false;
                        _addImageEnabled =
                            UploadFileList.currLength() < 5 ? true : false;
                        _viewImagesEnabled =
                            UploadFileList.currLength() > 0 ? true : false;
                      });
                    }, //Todo Dialog
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
                    fsize: 15,
                    width: 0.1,
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        WidgetsBinding.instance.focusManager.primaryFocus
                            ?.unfocus();
                        debugPrint("________");

                        String formattedDate = DateFormat('dd-MM-yyyy').format(myDateController);
                        String formattedTime = DateFormat('HH-mm-ss').format(myDateController);
                        final docUser = FirebaseFirestore.instance
                            .collection('Complaints')
                            .doc('Complaint' + complaint_num.toString());

                        final json = {
                          'compaint_id': complaint_num,
                          'title':myTitleFieldController.text,
                          'description':myMsgFieldController.text,
                          'date':formattedDate,
                          'time':formattedTime,
                          'location':myLocFieldController.text,
                          'anonymous':_anon,
                          'in_department':_dept,
                          'domain':"",
                        };
                        complaint_num += 1;
                        print(formattedDate);
                        print(formattedTime);
                        docUser.set(json);
                      } else {
                        debugPrint(">>>>>ERRORS!");
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
