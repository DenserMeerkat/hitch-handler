import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
import '../notifiers.dart';

class AddForm extends StatefulWidget {
  const AddForm({required Key key}) : super(key: key);

  @override
  State<AddForm> createState() => AddFormState();
}

class AddFormState extends State<AddForm> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

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

  bool _addImageEnabled = UploadFileList.currLength() < 5 ? true : false;
  bool _viewImagesEnabled = UploadFileList.currLength() > 0 ? true : false;

  void addPost(String uid) async {
    final scaffoldContext = ScaffoldMessenger.of(context);

    String res = "Error in adding Post";
    try {
      setState(() {
        _isLoading = true;
        IsLoading(_isLoading).dispatch(context);
      });
      res = await FirestoreMethods().uploadPost(
        uid,
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
                SizedBox(
                  height: 35.h,
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
                SizedBox(
                  height: 35.h,
                ),
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

  void validateForm() {
    final User user = Provider.of<UserProvider>(context, listen: false).getUser;
    final bool isDark = AdaptiveTheme.of(context).brightness == Brightness.dark;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      debugPrint("________");
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
              addPost(user.uid);
              Navigator.pop(context);
            },
          )
        ],
        Icons.check_box_outlined,
      );
    } else {
      AddPage.scrollController.animateTo(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);

      ScaffoldMessenger.of(context).clearSnackBars();
      final snackBar =
          showCustomSnackBar(context, "One or more Fields have Errors", () {},
              backgroundColor: isDark ? kGrey40 : kLBlack10,
              borderColor: AdaptiveTheme.of(context).theme.colorScheme.error,
              textColor: AdaptiveTheme.of(context).theme.colorScheme.error,
              icon: Icon(
                Icons.error_outline_rounded,
                color: AdaptiveTheme.of(context).theme.colorScheme.error,
              ));
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar)
          .closed
          .then((value) => ScaffoldMessenger.of(context).clearSnackBars());

      debugPrint(">>>>>ERRORS!");
    }
  }
}
