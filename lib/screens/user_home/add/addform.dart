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
  DateTime myDateController = DateTime.now();
  TimeOfDay myTimeController = const TimeOfDay(hour: 0, minute: 0);

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
        DateFormat('dd-MM-yyyy').format(myDateController),
        getTime(myTimeController),
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
                CustomTypeAheadField(
                  fgcolor: kPrimaryColor,
                  controller: myDomFieldController,
                  hintText: "Domain",
                  title: "Domain",
                  length: 50,
                  errorText: domErrorText,
                  showErrors: true,
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
                CustomTypeAheadField(
                  fgcolor: kPrimaryColor,
                  controller: myLocFieldController,
                  hintText: "Location",
                  title: "Location",
                  length: 50,
                  errorText: locErrorText,
                  showErrors: false,
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
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void clearForm() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    showConfirmDialog(
      context,
      DialogCont(
        title: "Reset Fields",
        message: "Are you sure you want to reset all fields ?",
        icon: Icons.restore_page_rounded,
        iconBackgroundColor: kSecButtonColor.withOpacity(1),
        secondaryButtonColor: kSecButtonColor.withOpacity(1),
        primaryButtonLabel: "Reset",
        primaryButtonColor: kGrey150,
        primaryFunction: () {
          debugPrint(UploadFileList.clearFileList());
          clearFields();
          Navigator.pop(context);
          ScaffoldMessenger.of(context).clearSnackBars();
          Navigator.of(context).pop();
        },
        secondaryFunction: () {
          Navigator.pop(context);
        },
        borderRadius: 10,
        //showSecondaryButton: false,
      ),
      borderRadius: 10,
    );
  }

  void validateForm() {
    final User user = Provider.of<UserProvider>(context, listen: false).getUser;
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
      debugPrint("________");
      showConfirmDialog(
        context,
        DialogCont(
          title: "Confirm Post",
          message: "Looks good!, Click 'Confirm' to add complaint",
          icon: Icons.check_box_rounded,
          iconBackgroundColor: kPrimaryColor.withOpacity(0.7),
          secondaryButtonColor: kGrey150,
          primaryButtonLabel: "Confirm",
          primaryButtonColor: kPrimaryColor.withOpacity(0.7),
          primaryFunction: () {
            addPost(user.uid);
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
    } else {
      AddPage.scrollController.animateTo(0,
          duration: const Duration(milliseconds: 500), curve: Curves.easeIn);
      debugPrint("Hi");
      final snackBar = showCustomSnackBar(
        context,
        "One or more Fields have Errors",
        "Ok",
        () {},
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBar)
          .closed
          .then((value) => ScaffoldMessenger.of(context).clearSnackBars());
      debugPrint(">>>>>ERRORS!");
    }
  }
}
