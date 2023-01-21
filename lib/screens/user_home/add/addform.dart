import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hitch_handler/resources/firestore_methods.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../models/user.dart';
import '../../../providers/user_provider.dart';
import '../../components/customfields/customdatetimefield.dart';
import '../../components/customfields/custommessagefield.dart';
import '../../components/customfields/customtitlefield.dart';
import '../../../constants.dart';
import '../../components/customfields/customsubmitbutton.dart';
import '../../components/customfields/customtypeaheadfield.dart';
import '../../components/utils/customdialog.dart';
import '../../components/utils/dialogcont.dart';
import '../add_page.dart';
import 'addimages.dart';
import '../../../resources/post_methods.dart';
import 'moredetails.dart';
import 'notifiers.dart';

class AddForm extends StatefulWidget {
  final ScrollController scrollController;
  const AddForm({
    required this.scrollController,
    super.key,
  });

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  final myTitleFieldController = TextEditingController();
  String titleErrorText = '';
  final myMsgFieldController = TextEditingController();
  String msgErrorText = '';
  final myLocFieldController = TextEditingController();
  String locErrorText = '';
  DateTime myDateController = DateTime.now();
  TimeOfDay myTimeController = const TimeOfDay(hour: 0, minute: 0);

  bool isAnon = false;
  bool isDept = false;

  bool _addImageEnabled = UploadFileList.currLength() < 5 ? true : false;
  bool _viewImagesEnabled = UploadFileList.currLength() > 0 ? true : false;

  void addPost(String uid) async {
    setState(() {
      _isLoading = true;
    });
    String res = "Error in adding Post";
    try {
      res = await FirestoreMethods().uploadPost(
        uid,
        myTitleFieldController.text,
        myMsgFieldController.text,
        myLocFieldController.text,
        "open-domain", //
        DateFormat('dd-MM-yyyy').format(myDateController),
        getTime(myTimeController),
        isAnon.toString(),
        isDept.toString(),
        UploadFileList.retrieveFileList(),
      );

      if (res == "PostUploadSuccess") {
        setState(() {
          _isLoading = false;
        });
        debugPrint(res); //Todo
      } else {
        setState(() {
          _isLoading = false;
        });
        debugPrint(res);
      }
    } catch (e) {
      debugPrint(res);
    }
  }

  String getTime(TimeOfDay controller) {
    final TimeOfDay time = controller;
    String minute = time.minute.toString();
    if (time.minute.toString().length == 1) {
      minute = "0${time.minute}";
    }
    String stringTime =
        "${time.hourOfPeriod}:$minute ${time.period == DayPeriod.pm ? "pm" : "am"}";
    return stringTime;
  }

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
    final User user = Provider.of<UserProvider>(context).getUser;
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width * 0.8,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            //_isLoading ? const LinearProgressIndicator() : Container(),
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
            NotificationListener<DateTimeChanged>(
              child: const CustomDateTime(),
              onNotification: (n) {
                setState(() {
                  myDateController = n.date;
                  myTimeController = n.time;
                });
                return true;
              },
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
            NotificationListener<SwitchChanged>(
              child: const MoreDetails(),
              onNotification: (n) {
                setState(() {
                  isAnon = n.anon;
                  isDept = n.dept;
                });
                return true;
              },
            ),
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
                    msg: "Reset",
                    fsize: 16,
                    press: () {
                      debugPrint(getTime(myTimeController));
                      debugPrint("$myDateController");
                      WidgetsBinding.instance.focusManager.primaryFocus
                          ?.unfocus();
                      showConfirmDialog(
                        context,
                        DialogCont(
                          title: "Reset Fields",
                          message:
                              "Are you sure you want to reset all fields ?",
                          icon: Icons.restore_page_rounded,
                          iconBackgroundColor: kSecButtonColor.withOpacity(0.7),
                          secondaryButtonColor:
                              kSecButtonColor.withOpacity(0.7),
                          primaryButtonLabel: "Reset",
                          primaryButtonColor: kGrey150,
                          primaryFunction: () {
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
                              _addImageEnabled = UploadFileList.currLength() < 5
                                  ? true
                                  : false;
                              _viewImagesEnabled =
                                  UploadFileList.currLength() > 0
                                      ? true
                                      : false;
                            });
                            Navigator.pop(context);
                          },
                          secondaryFunction: () {
                            Navigator.pop(context);
                          },
                          borderRadius: 10,
                          //showSecondaryButton: false,
                        ),
                        borderRadius: 10,
                      );
                    }, //Todo Dialog
                  ),
                ),
                const SizedBox(
                  width: 30,
                ),
                Expanded(
                  child: CustomSubmitButton(
                    size: size,
                    bgcolor: kPrimaryColor,
                    msg: "Done",
                    fsize: 16,
                    press: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        WidgetsBinding.instance.focusManager.primaryFocus
                            ?.unfocus();
                        debugPrint("________");
                        addPost(user.uid);
                        // String formattedDate =
                        //     DateFormat('dd-MM-yyyy').format(myDateController);
                        // String formattedTime =
                        //     DateFormat('HH-mm-ss').format(myDateController);
                        // final docUser = FirebaseFirestore.instance
                        //     .collection('Complaints')
                        //     .doc('Complaint' + complaint_num.toString());

                        // final json = {
                        //   'compaint_id': complaint_num,
                        //   'title': myTitleFieldController.text,
                        //   'description': myMsgFieldController.text,
                        //   'date': formattedDate,
                        //   'time': formattedTime,
                        //   'location': myLocFieldController.text,
                        //   'anonymous': _anon,
                        //   'in_department': _dept,
                        //   'domain': "",
                        // };
                        // complaint_num += 1;
                        // print(formattedDate);
                        // print(formattedTime);
                        // docUser.set(json);
                      } else {
                        AddPage.scrollController.animateTo(0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn);
                        debugPrint("Hi");
                        final snackBar = customSnackBar(
                            "One or more Fields have Errors", "Ok", () {},
                            backgroundColor: kGrey30);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(snackBar)
                            .closed
                            .then((value) =>
                                ScaffoldMessenger.of(context).clearSnackBars());
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
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
