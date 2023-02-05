import 'package:flutter/material.dart';
import 'package:hitch_handler/screens/user_home/notifiers.dart';
import 'add/addform.dart';
import '../../constants.dart';
import 'package:flutter/foundation.dart';

class AddPage extends StatefulWidget {
  static String routeName = '/add_page';
  static ScrollController scrollController = ScrollController();
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Available screen size
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: loading
              ? const LinearProgressIndicator(
                  backgroundColor: kBlack20,
                  color: kPrimaryColor,
                )
              : Container(),
        ),
        SliverFillRemaining(
          child: Container(
            height: size.height * 0.9,
            color: kGrey30.withOpacity(0.7),
            child: SingleChildScrollView(
              controller: AddPage.scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  const Text(
                    "Add new Problem",
                    style: TextStyle(
                      color: kTextColor,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                      fontSize: 32,
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                  Text(
                    "Explain you problem with details.",
                    style: TextStyle(
                      color: kTextColor.withOpacity(0.7),
                      letterSpacing: 0.6,
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  NotificationListener<IsLoading>(
                    child: AddForm(
                      scrollController: AddPage.scrollController,
                    ),
                    onNotification: (n) {
                      setState(() {
                        loading = n.isLoading;
                      });
                      return true;
                    },
                  ),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class DropdownDemo extends StatefulWidget {
  const DropdownDemo({Key? key}) : super(key: key);
  @override
  State<DropdownDemo> createState() => _DropdownDemoState();
}
class _DropdownDemoState extends State<DropdownDemo> {
  String dropdownValue = 'Administration';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ...,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            DropdownButton<String>(
              value: dropdownValue,
              items: <String>['Administration', 'Examination', 'Sanitation',
                'Departmental issues','Hostel and mess','Wifi connection',
                'Placement/Internship','Student exchange programme',
                'Infrastructure and logistics','Faculty issues',
                'Project/Start ups','Admission issues','Sports issues',
                'Affiliated college issues', 'Research','Amenities','Common']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(fontSize: 30),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Selected Value: $dropdownValue',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}