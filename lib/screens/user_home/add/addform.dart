// Dart imports:
import 'dart:convert';

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:hitch_handler/constants.dart';
import 'package:hitch_handler/models/user.dart';
import 'package:hitch_handler/providers/user_provider.dart';
import 'package:hitch_handler/resources/firestore_methods.dart';
import 'package:hitch_handler/resources/post_methods.dart';
import 'package:hitch_handler/screens/components/customfields/customdatetimefield.dart';
import 'package:hitch_handler/screens/components/customfields/custommessagefield.dart';
import 'package:hitch_handler/screens/components/customfields/customtitlefield.dart';
import 'package:hitch_handler/screens/components/customfields/customtypeaheadfield.dart';
import 'package:hitch_handler/screens/components/utils/customdialog.dart';
import 'package:hitch_handler/screens/user_home/add/addimages.dart';
import 'package:hitch_handler/screens/user_home/add_page.dart';
import 'package:hitch_handler/screens/user_home/notifiers.dart';

class AddForm extends StatefulWidget {
  const AddForm({required Key key}) : super(key: key);

  @override
  State<AddForm> createState() => AddFormState();
}

class AddFormState extends State<AddForm> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  GlobalKey<CustomDateTimeState> globalKey1 = GlobalKey();
  final myTitleFieldController = TextEditingController();
  String titleErrorText = '';
  final myMsgFieldController = TextEditingController();
  String msgErrorText = '';
  final myLocFieldController = TextEditingController();
  String locErrorText = '';
  final myDomFieldController = TextEditingController();
  String domErrorText = '';
  DateTime? myDateController;
  TimeOfDay? myTimeController;

  bool isAnon = false;
  bool isDept = false;
  bool isLoading = false;

  bool _addImageEnabled = UploadFileList.currLength() < 5 ? true : false;
  bool _viewImagesEnabled = UploadFileList.currLength() > 0 ? true : false;

  void addPost(String uid, String name) async {
    final scaffoldContext = ScaffoldMessenger.of(context);

    String res = "Error in adding Post";
    try {
      setState(() {
        _isLoading = true;
        IsLoading(_isLoading).dispatch(context);
      });
      res = await FirestoreMethods().uploadPost(
        uid,
        name,
        myTitleFieldController.text,
        myMsgFieldController.text,
        myLocFieldController.text,
        myDomFieldController.text,
        myDateController != null
            ? DateFormat('dd-MM-yyyy').format(myDateController!)
            : null,
        myTimeController != null ? getTime(myTimeController!) : null,
        isAnon.toString(),
        isDept.toString(),
        UploadFileList.retrieveFileList(),
      );

      if (res == "success") {
        setState(() {
          _isLoading = false;
          IsLoading(_isLoading).dispatch(context);
        });
        clearFields();
        const snackBar = SnackBar(
          content: Text("Posted Successfully"),
        );
        scaffoldContext
            .showSnackBar(snackBar)
            .closed
            .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
        debugPrint(res); //Todo
      } else {
        setState(() {
          _isLoading = false;
          IsLoading(_isLoading).dispatch(context);
        });
        final snackBar = SnackBar(
          content: Text(res.toString()),
        );
        scaffoldContext
            .showSnackBar(snackBar)
            .closed
            .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
        debugPrint(res);
      }
    } catch (e) {
      res = "$e";
      setState(() {
        _isLoading = false;
        IsLoading(_isLoading).dispatch(context);
      });
      final snackBar = SnackBar(
        content: Text(res.toString()),
      );
      scaffoldContext
          .showSnackBar(snackBar)
          .closed
          .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
      debugPrint(res);
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
    myDomFieldController.dispose();
    CustomMessageField.hasError = false;
    CustomTitleField.hasError = false;
    CustomTypeAheadField.hasError = false;
    super.dispose();
  }

  void clearFields() {
    debugPrint(UploadFileList.clearFileList());
    setState(() {
      myTitleFieldController.clear();
      titleErrorText = '';
      myMsgFieldController.clear();
      msgErrorText = '';
      myDomFieldController.clear();
      domErrorText = '';
      myLocFieldController.clear();
      locErrorText = '';
      CustomMessageField.hasError = false;
      CustomTitleField.hasError = false;
      CustomTypeAheadField.hasError = false;
      _addImageEnabled = UploadFileList.currLength() < 5 ? true : false;
      _viewImagesEnabled = UploadFileList.currLength() > 0 ? true : false;
      globalKey1.currentState!.resetTime();
      globalKey1.currentState!.resetDate();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
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
                CustomTypeAheadField(
                  fgcolor: kPrimaryColor,
                  controller: myDomFieldController,
                  hintText: "Domain",
                  title: "Domain",
                  length: 50,
                  errorText: domErrorText,
                  showErrors: true,
                ),
                CustomTypeAheadField(
                  fgcolor: kPrimaryColor,
                  controller: myLocFieldController,
                  hintText: "Location",
                  title: "Location",
                  length: 50,
                  errorText: locErrorText,
                  showErrors: false,
                ),
                AddImages(
                    addImageEnabled: _addImageEnabled,
                    viewImagesEnabled: _viewImagesEnabled),
                const SizedBox(height: 20),
                NotificationListener<DateTimeChanged>(
                  child: CustomDateTime(
                    key: globalKey1,
                  ),
                  onNotification: (n) {
                    setState(() {
                      myDateController = n.date;
                      myTimeController = n.time;
                    });
                    return true;
                  },
                ),
                const SizedBox(height: 20),
                // NotificationListener<SwitchChanged>(
                //   child: const MoreDetails(),
                //   onNotification: (n) {
                //     setState(() {
                //       isAnon = n.anon;
                //       isDept = n.dept;
                //     });
                //     return true;
                //   },
                // ),
                // const SizedBox(
                //   height: 30,
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void clearForm() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    if (myTitleFieldController.text != "" ||
        myMsgFieldController.text != "" ||
        myDomFieldController.text != "" ||
        myLocFieldController.text != "" ||
        myDateController != null ||
        myTimeController != null ||
        UploadFileList.currLength() != 0) {
      showAlertDialog(
        context,
        "Discard edits?",
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "If you go back now you'll lose all the edits you've made.",
              style: AdaptiveTheme.of(context).theme.textTheme.bodyLarge,
            ),
          ],
        ),
        [
          buildCancelButton(context),
          buildActiveButton(
            context,
            true,
            "Discard",
            () {
              clearFields();
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).clearSnackBars();
              Navigator.of(context).pop();
            },
            fgColor: kErrorColor,
          )
        ],
        Icons.delete_forever_outlined,
        fgColor: kErrorColor,
      );
    } else {
      ScaffoldMessenger.of(context).clearSnackBars();
      Navigator.pop(context);
    }
  }

  void validateForm() async {
    final User user = Provider.of<UserProvider>(context, listen: false).getUser;
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      debugPrint("________");
      try {
        setState(() {
          isLoading = true;
          IsLoading(isLoading).dispatch(context);
        });
        bool? check1 = await toxicRequest(myTitleFieldController.text);
        bool? check2 = await toxicRequest(myMsgFieldController.text);
        setState(() {
          isLoading = false;
          IsLoading(isLoading).dispatch(context);
        });
        if (mounted) {
          ScaffoldMessenger.of(context).removeCurrentSnackBar();
        }
        if ((check1 == true) && (check2 == true)) {
          if (mounted) {
            showAlertDialog(
              context,
              "Confirm Post",
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Looks good!\nClick 'Confirm' to add complaint.",
                    style: AdaptiveTheme.of(context).theme.textTheme.bodyLarge,
                  ),
                ],
              ),
              [
                buildCancelButton(context),
                buildActiveButton(
                  context,
                  true,
                  "Confirm",
                  () {
                    addPost(user.uid, user.name);
                    Navigator.pop(context);
                  },
                )
              ],
              Icons.check_box_outlined,
            );
          }
        } else {
          if (mounted) {
            ScaffoldMessenger.of(context).clearSnackBars();
            final scaffoldContext = ScaffoldMessenger.of(context);
            final snackBar = SnackBar(
              content: Text(
                "Your post appears to be abusive, avoid any form of toxicity.",
                style: TextStyle(
                  color: AdaptiveTheme.of(context).theme.colorScheme.error,
                ),
              ),
              behavior: SnackBarBehavior.floating,
              backgroundColor: isDark ? kGrey40 : kLBlack10,
            );
            scaffoldContext.showSnackBar(snackBar);
            debugPrint("Toxicity Error!");
          }
        }
      } catch (err) {
        setState(() {
          isLoading = false;
          IsLoading(isLoading).dispatch(context);
        });
        debugPrint(err.toString());
      }
    } else {
      AddPage.scrollController.animateTo(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);

      ScaffoldMessenger.of(context).clearSnackBars();
      final scaffoldContext = ScaffoldMessenger.of(context);
      final snackBar = SnackBar(
        content: Text(
          "One or more Fields have Errors",
          style: TextStyle(
            color: AdaptiveTheme.of(context).theme.colorScheme.error,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        backgroundColor: isDark ? kGrey40 : kLBlack10,
      );
      scaffoldContext.showSnackBar(snackBar);

      debugPrint(">>>>>ERRORS!");
    }
  }

  Future<bool?> toxicRequest(String sentence) async {
    String url = dotenv.env['TOXIC_API']!;
    url += '=$sentence';
    http.Response response = await http.get(
      Uri.parse(url),
    );
    dynamic responseData = json.decode(response.body);
    if (((responseData[0]) >= 0.5) ||
        ((responseData[1]) >= 0.5) ||
        ((responseData[2]) >= 0.5) ||
        ((responseData[3]) >= 0.5) ||
        ((responseData[4]) >= 0.5) ||
        ((responseData[5]) >= 0.5)) {
      return false;
    }
    return true;
  }
}
